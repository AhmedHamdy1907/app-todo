import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
typedef Validator = String? Function(String?) ;
class CustemTextFormField extends StatelessWidget {
  String hintTex;
  Validator? validator;
  bool isScecure;
  TextEditingController? controller;
   CustemTextFormField({required this.hintTex, this.validator,this.controller,this.isScecure=false});
  // super.key,
  @override
  Widget build(BuildContext context) {
    return TextFormField
      (
      obscureText: isScecure,
      controller: controller,
      validator:validator ,
      decoration: InputDecoration
        (
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white,width: 2)

        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white,width: 2)

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white,width: 2)
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red,width: 2)
        ),
        hintText: hintTex,
        hintStyle: GoogleFonts.poppins(
          fontSize:16,
          fontWeight:FontWeight.w300,
          color:Color(0XFF000000)
        )

      ),
    );
  }
}

//(input)
//       {
//       if(input==null||input.trim().isEmpty)
//         {
//           return" Plz ,enter Full name";
//         }
//       if (input.length<6)
//         {
//           return "Invalid Input ,full name should be at least 6 charas";
//         }
//       },