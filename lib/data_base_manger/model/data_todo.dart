import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/utils/data_utils/data_utils.dart';

class TodoDataModel {
  static const String Colicationname = "todo";
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late bool iSdone;
  TodoDataModel
  ({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.iSdone
  });

  Map<String, dynamic> toSendDataTojeso()
  {
    Timestamp timestamp = Timestamp.fromDate(date);
    return
  {
  "id": id,
  "title": title,
  "description": description,
  "date": timestamp,
  "iSdone": iSdone
  };
}

  TodoDataModel.readDataFormJesoTOobject (Map<String,dynamic>jeso)
  {
    DateTime dateTime = jeso["date"].toDate();
      id=jeso["id"];
      title=jeso["title"] ;
      description=jeso["description"] ;
      date= dateTime;
      iSdone=jeso["iSdone"];

  }
}

// :this(iSdone:false ,date:DateTime.now(),description:"sad",id:"asd" ,title: "asd");
// Map<String,dynamic>jeso




