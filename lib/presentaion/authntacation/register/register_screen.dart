import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/Routes_manegar/routes_manger.dart';
import 'package:todo_app/core/reusable_component/custem_text_form_field.dart';
import 'package:todo_app/core/strings_manger/strings_manger.dart';
import '../../../core/assets_manger/assets_manger.dart';
class RegisterScreen extends StatelessWidget {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade900,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              SvgPicture.asset(AssetsManger.routLogo),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: ListView(
                  children: [
                    buildTitle("Full name"),
                    buildFullNameFormFelid(),
                    buildTitle("UserName"),
                    buildUserNameFormField(),
                    buildTitle("E-mail"),
                    buildEmailFormField(),
                    buildTitle("Password"),
                    buildPasswordFormField(),
                    buildTitle("Re-Password"),
                    buildRePasswordFormField(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildMatirialButton(),
                    buildTitlePushLoginScreen(context)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFullNameFormFelid() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustemTextFormField(
          controller: fullNameController,
          hintTex: "full name",
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return " Plz ,enter Full name";
            }
            return null;
          },
        ),
      );

  Widget buildUserNameFormField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustemTextFormField(
          controller: userNameController,
          hintTex: "enter user name",
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return " Plz ,enter user name";
            }
            return null;
          },
        ),
      );

  Widget buildEmailFormField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustemTextFormField(
          controller: emailController,
          hintTex: "enter your email ",
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return " Plz ,enter email-address";
            }
            return null;
            //check email format
          },
        ),
      );

  Widget buildPasswordFormField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustemTextFormField(
          isScecure: true,
          controller: passwordController,
          hintTex: "enter Your Password",
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return " Plz ,enter Password";
            }
            if (input.length < 6) {
              return "sorry ,Password should be at least 6 chars";
            }
            return null;
          },
        ),
      );

  Widget buildRePasswordFormField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustemTextFormField(
          isScecure: true,
          controller: rePasswordController,
          hintTex: "enter Your re-Password",
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return " Plz ,enter re-Password";
            }
            if (input.length < 6) {
              return "sorry ,Password should be at least 6 chars";
            }
            return null;
          },
        ),
      );

  Widget buildTitle(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
      );

  Widget buildMatirialButton() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: MaterialButton(
        padding: EdgeInsets.all(1),
        height: 50,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        onPressed: () {},
        child: Text(
         StringsManger.SignUp,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0XFF004182)),
        )),
  );

  Widget buildTitlePushLoginScreen(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have Account?",
            style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.normal),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, RoutesManger.login);
              },
              child: Text(
                StringsManger.SignIn,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.underline),
              ))
        ],
      );
}
