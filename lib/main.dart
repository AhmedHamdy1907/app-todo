import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'my_app/my_application.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const  FirebaseOptions(
        apiKey: "AIzaSyAV3GJ6Uu_VGofsGSbXuO0Zo900eHLmdPY",
        appId: "com.example.todo_app",
        messagingSenderId:"",
        projectId: "todo-application-57f64"
    )
  );
  await FirebaseFirestore.instance.disableNetwork();
  runApp( MyApp());
}
// DefaultFirebaseOptions

