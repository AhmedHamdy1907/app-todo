import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/strings_manger/strings_manger.dart';
import '../../../core/Routes_manegar/routes_manger.dart';
import '../../../core/assets_manger/assets_manger.dart';
import '../../../core/constant_manager.dart';
import '../../../core/dialog/dialogs.dart';
import '../../../core/emial_validation.dart';
import '../../../core/reusable_component/custem_text_form_field.dart';
import '../../../core/strings_manager.dart';
import '../../../data_base_manger/model/user_DM.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  AssetsManger.routLogo,
                  width: 237.w,
                  height: 71.h,
                ),
                SizedBox(height: 12.h),
                const Text('Email address' , style: TextStyle(color: Colors.white)),
                SizedBox(height: 12.h),
                CustomTextField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter email';
                    }
                    if (!isValidEmail(input)) {
                      return 'Email bad format';
                    }
                    return null;
                  },
                  controller: emailController,
                  hintText: ConstantManager.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 12.h),
                const Text('Password' , style: TextStyle(color: Colors.white)),
                SizedBox(height: 12.h),
                CustomTextField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter password';
                    }
                    return null;
                  },
                  controller: passwordController,
                  hintText: ConstantManager.password,
                  keyboardType: TextInputType.visiblePassword,
                  isSecureText: true,
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    padding: REdgeInsets.symmetric(vertical: 11),
                  ),
                  onPressed: () {
                    login();
                  },
                  child: const Text('Sign-In' , style: TextStyle(color: Colors.black)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.cyanAccent),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManger.register,
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == false) return;

    try {
      // show Loading
      MyDialog.showLoading(context,
          loadingMessage: 'Waiting...', isDismissible: false);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserDM.currentUser = await readUserFromFireStore(credential.user!.uid);

      //hide loading
      if (mounted) {
        MyDialog.hide(context);
      }
      // show success message
      if (mounted) {
        MyDialog.showMessage(
          context,
          body: 'User Logged in successfully',
          posActionTitle: 'Ok',
          posAction: () {
            Navigator.pushReplacementNamed(
              context,
              RoutesManger.homeRoue, // تأكد أن الاسم ده صح عندك
            );
          },
        );
      }
    } on FirebaseAuthException catch (authError) {
      if (mounted) {
        MyDialog.hide(context);
      }
      late String message;

      if (authError.code == ConstantManager.invalidCredential) {
        message = StringsManager.wrongEmailOrPasswordMessage;
      } else {
        message = authError.message ?? 'Error occurred';
      }

      if (mounted) {
        MyDialog.showMessage(
          context,
          title: 'Error',
          body: message,
          posActionTitle: 'OK',
        );
      }
    } catch (error) {
      if (mounted) {
        MyDialog.hide(context);
        MyDialog.showMessage(
          context,
          title: 'Error',
          body: error.toString(),
          posActionTitle: 'Try again',
        );
      }
    }
  }

  Future<UserDM> readUserFromFireStore(String uid) async {
    CollectionReference usersCollection =
    FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDocument = usersCollection.doc(uid);
    DocumentSnapshot userDocumentSnapshot = await userDocument.get();
    Map<String, dynamic> json =
    userDocumentSnapshot.data() as Map<String, dynamic>;
    UserDM userDM = UserDM.fromFireStore(json);
    return userDM;
  }
}
