import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/data_utils/data_utils.dart';
import '../../../../core/colors_manger/colors_manger.dart';
import 'task_item/task_item.dart';
import '../../../../data_base_manger/model/data_todo.dart';

class TaskTap extends StatefulWidget {
  TaskTap({super.key});

  @override
  State<TaskTap> createState() => TaskTapState();
}

class TaskTapState extends State<TaskTap> {
  DateTime calnderSelectedDate = DateTime.now();
  List<TodoDataModel>todosList=[];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              Container(
                height: 80,
                color: ColorsManger.blueColor,
              ),
              buildCalender(),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(TodoDataModel.Colicationname).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text("Error loading data"));
              }
              List<QueryDocumentSnapshot>documents= snapshot.data!.docs;
              todosList = documents.map((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                TodoDataModel todo = TodoDataModel.readDataFormJesoTOobject(data);
                return todo;
              }).toList();

              todosList= todosList.where((todo) =>
              todo.date.day == calnderSelectedDate.day &&
                  todo.date.month == calnderSelectedDate.month &&
                  todo.date.year == calnderSelectedDate.year).toList();
              return ListView.builder(
                itemCount: todosList.length,
                itemBuilder: (context, index) =>TaskItem(todo: todosList[index],)
              );
            },
          ),
        ),
      ],
    );
  }
  Widget buildCalender() {
    return EasyInfiniteDateTimeLine(
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      focusDate: calnderSelectedDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
      onDateChange: (selectedDate) {
        setState(() {
          calnderSelectedDate = selectedDate;
        });
      },
      itemBuilder: (context, date, isSelected, onTap) {
        BoxBorder border = const Border(
          top: BorderSide(color: Colors.black),
          left: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
          right: BorderSide(color: Colors.black),
        );
        return InkWell(
          onTap: () {
            setState(() {
              calnderSelectedDate = date;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.deepPurpleAccent, Colors.blue])
                  : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.red, Colors.yellowAccent]),
              border: border,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${date.day}",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? ColorsManger.WhiteColors : ColorsManger.black),
                ),
                SizedBox(height: 4),
                Text(
                  date.getDay,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? ColorsManger.WhiteColors : ColorsManger.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
