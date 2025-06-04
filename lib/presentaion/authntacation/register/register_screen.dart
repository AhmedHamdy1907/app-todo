import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/Routes_manegar/routes_manger.dart';
import 'package:todo_app/core/reusable_component/custem_text_form_field.dart';
import 'package:todo_app/core/strings_manger/strings_manger.dart';
import '../../../core/assets_manger/assets_manger.dart';
import '../../../core/constant_manager.dart';
import '../../../core/dialog/dialogs.dart';
import '../../../core/emial_validation.dart';
import '../../../core/strings_manager.dart';
import '../../../core/text_manger/textStyles.dart';
import '../../../data_base_manger/model/user_DM.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController fullNameController;
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
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
                const Text('Full name',  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 12.h),
                CustomTextField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter full name';
                    }
                    return null;
                  },
                  controller: fullNameController,
                  hintText: ConstantManager.fullName,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 12.h),
                const Text('user name' , style: TextStyle(color: Colors.white),),
                SizedBox(height: 12.h),
                CustomTextField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter user name';
                    }
                    return null;
                  },
                  controller: userNameController,
                  hintText: ConstantManager.userName,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 12.h),
                const Text('Email address' , style: TextStyle(color: Colors.white)),
                SizedBox(height: 12.h),
                CustomTextField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter emil';
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
                const Text('Re-password' , style: TextStyle(color: Colors.white)),
                SizedBox(height: 12.h),
                CustomTextField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter re-password';
                    }
                    if (input != passwordController.text) {
                      return "Password doesn't match";
                    }
                    return null;
                  },
                  controller: rePasswordController,
                  hintText: ConstantManager.passwordConfirmation,
                  keyboardType: TextInputType.visiblePassword,
                  isSecureText: true,
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r)),
                    padding: REdgeInsets.symmetric(vertical: 11),
                  ),
                  onPressed: () {
                    register();
                  },
                  child: const Text('Sign-Up' , style: TextStyle(color: Colors.black)),
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
                          RoutesManger.login,
                        );
                      },
                      child: const Text(
                        "Sign in",
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

  void register() async {
    if (formKey.currentState?.validate() == false) return;

    try {
      MyDialog.showLoading(context,
          loadingMessage: 'Waiting...', isDismissible: false);

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await addUserToFireStore(credential.user!.uid);

      if (!mounted) return;
      MyDialog.hide(context);

      if (!mounted) return;
      MyDialog.showMessage(context,
          body: 'User registered successfully',
          posActionTitle: 'Ok', posAction: () {
            Navigator.pushReplacementNamed(context, RoutesManger.login);
          });
    } on FirebaseAuthException catch (authError) {
      if (mounted) {
        MyDialog.hide(context);
      }
      late String message;
      if (authError.code == ConstantManager.weakPassword) {
        message = StringsManager.weakPasswordMessage;
      } else if (authError.code == ConstantManager.emailInUse) {
        message = StringsManager.emailInUseMessage;
      } else {
        message = authError.message ?? 'An error occurred';
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
        MyDialog.showMessage(context,
            title: 'Error',
            body: error.toString(),
            posActionTitle: 'Try again');
      }
    }
  }

  Future<void> addUserToFireStore(String uid) async {
    UserDM userDM = UserDM(
      id: uid,
      fullName: fullNameController.text,
      userName: userNameController.text,
      email: emailController.text,
    );
    CollectionReference usersCollection =
    FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDocument = usersCollection.doc(uid);
    await userDocument.set(userDM.toFireStore());

    print('User data added to Firestore for UID: $uid');
  }
}
