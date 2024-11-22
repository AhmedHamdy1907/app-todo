import 'package:flutter/material.dart';
import 'package:todo_app/core/text_manger/textStyles.dart';
import '../../core/colors_manger/colors_manger.dart';
class MyTheme
{
  static ThemeData ligth =ThemeData(
    indicatorColor: ColorsManger.WhiteColors,
    scaffoldBackgroundColor:ColorsManger.ligthScaffoldGround ,
    cardTheme:const CardTheme(
      color:Colors.transparent,
      elevation: 0
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    dividerColor: ColorsManger.blueColor,
    useMaterial3: false,
    primaryColor: ColorsManger.blueColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: ColorsManger.blueColor,
          centerTitle: true,
          titleTextStyle:AppLigthStayel.AppBarTextStayel,
  ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: true,
        enableFeedback: true,
      selectedItemColor: ColorsManger.blueColor,
      unselectedItemColor:ColorsManger.grayColor
        ,elevation: 0,
        backgroundColor: Colors.transparent,
        selectedIconTheme: IconThemeData(size:32 )
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
          color: ColorsManger.ligthButtonNavigationBar,
          shape: CircularNotchedRectangle(),
          elevation: 14
      ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorsManger.blueColor,
      elevation: 18,
      iconSize: 30,
      shape: StadiumBorder(
          side: BorderSide(color: ColorsManger.WhiteColors, width: 4))
    ),
    bottomSheetTheme:const BottomSheetThemeData(
      backgroundColor: ColorsManger.WhiteColors,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12))
      )
    )


  );












  static ThemeData dark =ThemeData(
    indicatorColor: ColorsManger.blackAcent,
      scaffoldBackgroundColor:ColorsManger.darkScafoldBackGround ,
      cardTheme:const CardTheme(
          color:Colors.transparent,
          elevation: 20
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      dividerColor: ColorsManger.blueColor,
      useMaterial3: false,
      primaryColor: ColorsManger.blueColor,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManger.blueColor    ,
        elevation: 4,
        centerTitle: true,
        titleTextStyle:AppLigthStayel.AppBarTextStayel,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showSelectedLabels: true,
          enableFeedback: true,
          selectedItemColor: ColorsManger.blueColor,
          unselectedItemColor:ColorsManger.grayColor
          ,elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size:32 )
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
          color: ColorsManger.DarkButtonNavigationBar,
          shape: CircularNotchedRectangle(),
          elevation: 14
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorsManger.blueColor,
          elevation: 18,
          iconSize: 30,
          shape: StadiumBorder(
              side: BorderSide(color: ColorsManger.WhiteColors, width: 4))
      ),
      bottomSheetTheme:const BottomSheetThemeData(
        backgroundColor:ColorsManger.blackAcent ,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12))
          )
      )


  );

}