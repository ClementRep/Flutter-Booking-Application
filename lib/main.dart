// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sweet/appointment.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Appointment",
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: Appointment());
  }
}