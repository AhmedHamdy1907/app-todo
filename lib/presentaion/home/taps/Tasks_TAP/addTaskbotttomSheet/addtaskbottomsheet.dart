import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/data_utils/data_utils.dart';
import '../../../../../core/text_manger/textStyles.dart';
import '../../../../../data_base_manger/model/data_todo.dart';
class  Addtaskbottomsheet extends StatefulWidget
{
  @override
  State<Addtaskbottomsheet> createState() => _AddtaskbottomsheetState();
  static Future show(BuildContext context)
  {
    return showModalBottomSheet(
      // scrollControlDisabledMaxHeightRatio:0.8 ,
      // isScrollControlled: true,
        context: context,
      builder: (context) => Addtaskbottomsheet(),
    );
  }
}
class _AddtaskbottomsheetState extends State<Addtaskbottomsheet>
{
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  GlobalKey<FormState>formKey = GlobalKey<FormState>();
  DateTime userSelectedDate=DateTime.now(); // تعريف متغير واخد قيمه الوقت الان
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Container(
        child: Form(
          key: formKey,
          child: Column
            (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                  "Add new Task",textAlign: TextAlign.center,style: AppLigthStayel.TaskTitleStyal),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (inputUser)
                {
                  if(inputUser==null||inputUser.trim().isEmpty)
                    {
                      return "plz,enter title";
                    }
                  return null;
                },
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Enter task title",
                  hintStyle:AppLigthStayel.hintTextStayel

                ),
              ),
              TextFormField(
                validator: (inputUser)
                {
                  if(inputUser==null||inputUser.trim().isEmpty)
                  {
                    return "plz,enter description";
                  }
                  return null;
                },
                controller: descriptionController,
                decoration: InputDecoration(
                 hintText: "Enter task description",
                 hintStyle:AppLigthStayel.hintTextStayel

                ),

                ),
              const SizedBox(
                height: 20,),
              Text("Select Data",
                textAlign: TextAlign.center,style: AppLigthStayel.greyStyl?.copyWith(color: Colors.black),),
               const SizedBox(
                 height: 10,),
               InkWell(
                 onTap: ()
                 {
                   showTaskDataPiker();

                 },
                   child:Text(userSelectedDate.formate,
                   // Text(dataformate(userSelectedDate),
                   // child: Text("${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
                       textAlign: TextAlign.center,style: AppLigthStayel.greyStyl)),
               Spacer(),
               ElevatedButton(onPressed: ()
               {
                 addTodoFireStore();
               }, child: Text("Add Task"))

                ],
          ),
        ),
      ),
    );
  }
  void showTaskDataPiker()async
  {
     userSelectedDate= await showDatePicker(
      initialDate:DateTime.now(),
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))) ??userSelectedDate;
     setState(() {
     });
  }
  void addTodoFireStore()
  {
    if (formKey.currentState!.validate()==false)return;
    //  بقول لو حالة ال formKay لو ال بتاعها  validate بي false اعمل return
    CollectionReference todoCollection = FirebaseFirestore.instance.collection(TodoDataModel.Colicationname);
    DocumentReference doc= todoCollection.doc();
    TodoDataModel Todo=TodoDataModel(
        id: doc.id,
        title: titleController.text,
        description: descriptionController.text,
        date:userSelectedDate,
        iSdone: false,
    );
    doc.set
      (
     Todo.toSendDataTojeso()
    )
        .then((_){} ,)
        .onError((error, stackTrace) {},).timeout
      (
        Duration(microseconds: 500), onTimeout: ()
    {
      if(mounted) //
        {
          Navigator.pop(context);
        }
    }
    );

  }

}
