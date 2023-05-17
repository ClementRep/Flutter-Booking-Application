import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(2022, 11, 21);
    // ignore: prefer_const_constructors
    TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');

    final TextEditingController firstname_controller = TextEditingController();
    final TextEditingController lastname_controller = TextEditingController();
    final TextEditingController txemail_controller = TextEditingController();

    void Dispose() {
      firstname_controller.dispose();
      lastname_controller.dispose();
      txemail_controller.dispose();
    }

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 200,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
            child: Container(
                child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 0),
                  child: Image.asset("img/COVERB.png"),
                ),
              ],
            ))),
        Container(
            margin: EdgeInsets.only(left: 5, top: 30),
            child: Text(
              "${date.day}/${date.month}/${date.year}",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700),
            )),
        SizedBox(height: 15),
        ElevatedButton(
          child: Text("Select your date to book the appointment"),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(150, 50),
            padding: EdgeInsets.all(0),
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            shadowColor: Colors.red,
          ),
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1800),
              lastDate: DateTime(2025),
            );
          },
        ),
        Container(
            margin: EdgeInsets.only(left: 5, top: 30),
            child: Text(
              "${time.hour}:${time.minute}",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700),
            )),
        SizedBox(height: 15),
        ElevatedButton(
          child: Text("Select your TIME For your Appointment"),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(150, 50),
            padding: EdgeInsets.all(0),
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            shadowColor: Colors.purple,
          ),
          onPressed: () async {
            TimeOfDay? newTime =
                await showTimePicker(context: context, initialTime: time);
          },
        ),
        SizedBox(height: 30),
        Container(
          child: Column(
            children: [
              TextField(
                controller: firstname_controller,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Container(
          child: Column(
            children: [
              TextField(
                controller: lastname_controller,
                decoration: InputDecoration(
                  hintText: "Enter your last name",
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Container(
          child: Column(
            children: [
              TextField(
                controller: txemail_controller,
                decoration: InputDecoration(
                  hintText: "Enter your Phone number",
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),

        /*  
      child:
     FutureBuilder<List<patients>>(
future:DatabaseHelper.instance.getpatients(),
builder:(BuildContext context , AsyncSnapshot<List<patients>>snapshot){
  if(!snapshot.hasData){
    return Center(child:Text(
      'Loading'
    ));
  }
  // ignore: dead_code
  return snapshot.data!.isEmpty
   ? Center(child:Text('No patients in list'))
  :ListView(
    children:snapshot.data!.map((patients)){
      return Center(
        child:ListTile(
          title:Text(patients.name),
        )
      ) 
    }).toList();
}

       ),
  */

        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(5),
          ),
          child: GestureDetector(
            onTap: () async {
              await DatabaseHelper.instance.add(
                patients(
                  name: firstname_controller.text,
                  lname: lastname_controller.text,
                  email: txemail_controller.text,
                ),
              );
              setState(() {
                firstname_controller.clear();
                lastname_controller.clear();
                txemail_controller.clear();
              });
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple,
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(5, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(-5, -5),
                  )
                ],
              ),
              child: Center(
                  child: Text(
                "MAKE AN APPOINTMENT",
                style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
            ),
          ),
        )
      ],
    )));
  }

  doctorTimings(String time, bool isSelected) {
    return isSelected
        ? Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            decoration: BoxDecoration(
                color: Color(0xff613), borderRadius: BorderRadius.circular(5)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 2),
                    child: Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 5,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 2),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
          )
        : Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            decoration: BoxDecoration(
                color: Color(0xffEEEEEE),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 2),
                      child: Icon(
                        Icons.access_time,
                        color: Colors.black,
                        size: 1,
                      )),
                  Container(
                    margin: EdgeInsets.only(right: 2),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
          );
  }

  demodates(String day, String date, bool isSelected) {
    return isSelected
        ? Container(
            width: 70,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(day,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(7),
                  child: Text(date,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ],
            ),
          )
        : Container(
            width: 70,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(day,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(7),
                  child: Text(date,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ],
            ),
          );
  }
}

// ignore: camel_case_types
class patients {
  final int? id;
  final String name;
  final String lname;
  final String email;

  patients(
      {this.id, required this.name, required this.lname, required this.email});

  factory patients.fromMap(Map<String, dynamic> json) => new patients(
        id: json['id'],
        name: json['name'],
        lname: json['lname'],
        email: json['email'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lname': lname,
      'email': email,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'patient.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE patient(
        id INTEGER PRIMARY KEY,
        name TEXT,
        lname TEXT,
        email TEXT
      )''');
  }

  Future<List<patients>> getpatients() async {
    Database db = await instance.database;
    var patient = await db.query('patient', orderBy: 'name');

    List<patients> patientlist = patient.isNotEmpty
        ? patient.map((c) => patients.fromMap(c)).toList()
        : [];
    return patientlist;
  }

  Future<int> add(patients Patients) async {
    Database db = await instance.database;
    return await db.insert('patient', Patients.toMap());
  }
}
