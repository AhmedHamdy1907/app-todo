import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/strings_manger/strings_manger.dart';
import '../../../core/Routes_manegar/routes_manger.dart';
import '../../../core/assets_manger/assets_manger.dart';
import '../../../core/reusable_component/custem_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue.shade900,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buildImageLogo(),
              Expanded(
                child: ListView(
                  children:
                  [
                    buildTitle("E-mail"),
                    buildEmailField(),
                    buildTitle("password"),
                    buildPasswordField(),
                    const SizedBox(height: 20,),
                    buildMatirialbutton(),
                    buildTitlePushRegisterScreen(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }









  Widget buildImageLogo()=>Padding(
    padding:  EdgeInsets.symmetric(vertical: 30),
    child: SvgPicture.asset(AssetsManger.routLogo),
  );
  Widget buildEmailField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustemTextFormField
          (
          controller: emailController,
          hintTex: "enter your email ",
          validator: (input) {
            if (input == null || input
                .trim()
                .isEmpty) {
              return " Plz ,enter email-address";
            }
            return null;
            //check email format
          },
        ),
      );
  Widget buildPasswordField() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: CustemTextFormField
      (
      isScecure: true,
      controller: passwordController,
      hintTex: "enter Your Password",
      validator: (input) {
        if (input == null || input
            .trim()
            .isEmpty) {
          return " Plz ,enter Password";
        }
        if (input.length < 6) {
          return "sorry ,Password should be at least 6 chars";
        }
        return null;
      },
    ),
  );
  Widget buildMatirialbutton()=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: MaterialButton
      (
        padding: EdgeInsets.all(1),
        height: 50,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        color: Colors.white,
        onPressed: () {},
        child: Text(StringsManger.SignIn, style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0XFF004182)),)),
  );
  Widget buildTitle(String title)=>Text(
      title,
    style: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w400),
  );
  Widget buildTitlePushRegisterScreen(BuildContext context) => Row(
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
            Navigator.pushReplacementNamed(context, RoutesManger.register);
          },
          child: Text(
            StringsManger.SignUp,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.underline),
          ))
    ],
  );







}

