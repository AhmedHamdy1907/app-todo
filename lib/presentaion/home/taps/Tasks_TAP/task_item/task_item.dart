import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/colors_manger/colors_manger.dart';
import 'package:todo_app/core/utils/data_utils/data_utils.dart';
import 'package:todo_app/presentaion/home/taps/Tasks_TAP/task_item/widget_edit/widget_edit.dart';
import '../../../../../data_base_manger/model/data_todo.dart';
import '../taskTap.dart';
import '../../../../../core/Routes_manegar/routes_manger.dart';
import '../../../../../core/text_manger/textStyles.dart';

class TaskItem extends StatefulWidget {
  TodoDataModel todo;
  TaskItem({
    required this.todo,
    super.key,
  });
  @override
  State<TaskItem> createState() => TaskItemState();
}
class TaskItemState extends State<TaskItem>
{
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int indexDelete = 0;
  DateTime userSelectedDate  =DateTime.now();
  @override
  Widget build(BuildContext context) {
    return buildDoneTasksCard();
  }

  Future<Widget> showModalDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // title: Text('Task '),
            content: Text('Do you really want to delete?'),
            actions: <Widget>[
              TextButton(
                  onPressed: ()
                  {
                    deleteTodoTask();
                    Navigator.pop(context); //close Dialog
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.cyan),
                  )),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); //close Dialog
                },
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }
  deleteTodoTask() async
  {
    CollectionReference todocolection = FirebaseFirestore.instance.collection(TodoDataModel.Colicationname);
    await todocolection.doc(widget.todo.id).delete();

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
  Future<Widget> DialogDialogEdidt() async {
    return await showDialog(
        context: context,
        builder: (context) => Form(
          key: formKey,
          child: Dialog(
              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height*0.7,
                width: MediaQuery.of(context).size.width*0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Edit Task",
                        textAlign: TextAlign.center,
                        style: AppLigthStayel.TaskTitleStyal),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (inputUser) {
                        if (inputUser == null || inputUser.trim().isEmpty) {
                          return "plz,enter title";
                        }
                        return null;
                      },
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: "Enter task title",
                          hintStyle: AppLigthStayel.hintTextStayel),
                    ),
                    TextFormField(
                      validator: (inputUser) {
                        if (inputUser == null || inputUser.trim().isEmpty) {
                          return "plz,enter description";
                        }
                        return null;
                      },
                      controller: descriptionController,
                      decoration: InputDecoration(
                          hintText: "Enter task description",
                          hintStyle: AppLigthStayel.hintTextStayel),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Select Data",
                      textAlign: TextAlign.center,
                      style: AppLigthStayel.greyStyl
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: ()
                        {
                          showTaskDataPiker();
                        },
                        child: Text(userSelectedDate.formate,
                            // Text(dataformate(userSelectedDate),
                            // child: Text("${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
                            textAlign: TextAlign.center,
                            style: AppLigthStayel.greyStyl)),
                    Spacer(),
                    ElevatedButton(onPressed: ()
                    {
                      if (formKey.currentState!.validate()==false)return;
                      EdidtData();

                    }, child: Text("Save Changes"))
                  ],
                ),
              )),
        ));
  }
  EdidtData()
  {
    CollectionReference todoColliction=FirebaseFirestore.instance.collection(TodoDataModel.Colicationname);
    TodoDataModel Todo=TodoDataModel(
      id: widget.todo.id,
      title: titleController.text,
      description: descriptionController.text,
      date:userSelectedDate,
      iSdone: false,
    );
    todoColliction.doc(widget.todo.id).update
      (
        Todo.toSendDataTojeso()
    ) .then((_){} ,)
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
  UbdateData()
  {

    CollectionReference todoColliction=FirebaseFirestore.instance.collection(TodoDataModel.Colicationname);
    todoColliction.doc(widget.todo.id).update
      (
        {
          "iSdone": !widget.todo.iSdone
        }
    );

  }
  Widget buildDoneTasksCard()
  {
    if (widget.todo.iSdone)
      {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Color(0XFF61E757),
                    height: 65,
                    width: 3,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: [
                      Text(
                        widget.todo.title,
                        style: AppLigthStayel.TaskTitleStyal?.copyWith(color: Color(0XFF61E757)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.todo.description,
                        style: AppLigthStayel.TaskTitleStyal?.copyWith(color: Color(0xFF61E757)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.lock_clock),
                          Text(
                            "${widget.todo.date.formate}",
                            style: AppLigthStayel.DateStyle,
                          )
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      UbdateData();
                    },
                    child:  const Text("Done !",style: TextStyle(color:Color(0XFF61E757),fontSize:25,fontWeight: FontWeight.bold),),
                  ),

                ],
              ),
            ),
          ),
        );

      }
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) => showModalDialog(),
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) => {DialogDialogEdidt()},
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.red,
                  height: 65,
                  width: 3,
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  children: [
                    Text(
                      widget.todo.title,
                      style: AppLigthStayel.TaskTitleStyal,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.todo.description,
                      style: AppLigthStayel.TaskTitleStyal,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.lock_clock),
                        Text(
                          "${widget.todo.date.formate}",
                          style: AppLigthStayel.DateStyle,
                        )
                      ],
                    )
                  ],
                ),
                Spacer(),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        UbdateData();
                      },
                      child: Icon(
                        Icons.check,
                        color: ColorsManger.WhiteColors,
                        size: 28,
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                  color: Theme
                      .of(context)
                      .dividerColor,
                  height: 65,
                  width: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
