import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manger/colors_manger.dart';
import 'package:todo_app/presentaion/home/taps/Settings_TAP/SettingsTap.dart';
import 'package:todo_app/presentaion/home/taps/Tasks_TAP/addTaskbotttomSheet/addtaskbottomsheet.dart';
import 'package:todo_app/presentaion/home/taps/Tasks_TAP/taskTap.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int SelectedIndex = 0;
  List <Widget>Taps =[TaskTap(), Settingstap()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("ToDo List"),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:buildFlotingActionButton(),
      bottomNavigationBar:buildBottomNavigator(),
      body: Taps[SelectedIndex],
    );
  }

Widget buildFlotingActionButton()=>FloatingActionButton(
  onPressed: () async
  {
   await Addtaskbottomsheet.show(context);
  },
  child: const Icon(Icons.add),
);
  Widget buildBottomNavigator() =>
      BottomAppBar(
    notchMargin: 8,
    child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onTap: (index) {
          SelectedIndex = index;
          setState(() {});
        },
        currentIndex: SelectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: "Tasks"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: "Settings")
        ]),
  );



}




