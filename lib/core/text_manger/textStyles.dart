import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors_manger/colors_manger.dart';

class AppLigthStayel {
  static TextStyle? AppBarTextStayel = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: ColorsManger.WhiteColors);
  static TextStyle? bottomSheetTitleStyle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: Color(0XFF383838));
  static TextStyle? hintTextStayel = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color: Color(0XFFA9A9A99C));
  static TextStyle? greyStyl = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFA9A9A99C));
  static TextStyle? TaskTitleStyal = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w700, color: ColorsManger.blueColor);
  static TextStyle? DateStyle = GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w700, color: ColorsManger.dataColor);
  // settings Taps
  static TextStyle? settingsItemTextStyel = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black);
  static   TextStyle? drobDownBottunTextStayel = GoogleFonts.poppins(
    color:Colors.black,fontSize: 14,fontWeight: FontWeight.w400);
  static TextStyle? ItemViweStayel = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color:ColorsManger.blueColor);




}
class AppDarkStayel {
  static TextStyle? AppBarTextStayel = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: ColorsManger.black);
  static TextStyle? bottomSheetTitleStyle = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w700, color:Colors.white);
  static TextStyle? hintTextStayel = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color: Color(0XFFA9A9A99C));
  static TextStyle? greyStyl = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFA9A9A99C));
  static TextStyle? TaskTitleStyal = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w700, color: ColorsManger.blueColor);
  static TextStyle? DateStyle = GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w700, color: ColorsManger.WhiteColors);
  // settingS Taps
  static TextStyle? settingsItemTextStyel = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white);
  static   TextStyle? DarkdrobDownBottunTextStayel = GoogleFonts.poppins(
      color:Colors.white,fontSize: 14,fontWeight: FontWeight.w400);
  static TextStyle? ItemViweStayel = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color:ColorsManger.blueColor);
}

