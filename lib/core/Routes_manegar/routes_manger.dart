import 'package:flutter/material.dart';
import 'package:todo_app/presentaion/authntacation/login/login_screen.dart';
import 'package:todo_app/presentaion/authntacation/register/register_screen.dart';
import '../../presentaion/home/home_screen.dart';
class RoutesManger
{
  static const String homeRoue="/home";
  static const String register="/register";
  static const String login="/login";


  static Route<dynamic>? router (RouteSettings settings)
  {
    switch (settings.name)
    {
      case homeRoue:
       { return MaterialPageRoute(builder: (context) => HomeScreen(),);}
      case register :
        { return MaterialPageRoute(builder:  (context) => RegisterScreen(),);}
      case login :
        {return MaterialPageRoute(builder: (context) =>LoginScreen (),);}


    }
  }
}