import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(StudentPlatformApp());
}

class StudentPlatformApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StudentPlatformAppState();
  }
}

class StudentPlatformAppState extends State<StudentPlatformApp> {
  //Regarding Students
  bool getAllStudentDataDone = false;

  bool addStudentSelected = false;
  bool getStudentSelected = false;
  bool deleteStudentSelected = false;

  var receivedStudentData;

//build function
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        accentColor: Colors.white54,
        appBarTheme: AppBarTheme(
            actionsIconTheme: IconThemeData(
          color: Colors.white24,
          opacity: 0.5,
          size: 30,
        )),
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Student Platform'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.supervised_user_circle),
                ),
                Tab(
                  icon: Icon(Icons.person),
                ),
                Tab(
                  icon: Icon(Icons.book),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Scaffold(
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue[800],
                        ),
                        child: Text(
                          'Perform Student Op',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.add_a_photo),
                          title: Text('Find Student'),
                          onTap: () {
                            setState(() {
                              this.addStudentSelected = true;
                            });
                          },
                          hoverColor: Colors.blue[100],
                          selectedTileColor: Colors.blue[100],
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.read_more),
                          title: Text('Add Student'),
                          hoverColor: Colors.blue[100],
                          focusColor: Colors.blue[100],
                          selectedTileColor: Colors.blue[100],
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.update),
                          title: Text('Update Student'),
                          hoverColor: Colors.blue[100],
                          selectedTileColor: Colors.blue[100],
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Delete Student'),
                          hoverColor: Colors.blue[100],
                          selectedTileColor: Colors.blue[100],
                        ),
                      )
                    ],
                  ),
                ),
                body: this.addStudentSelected
                    ? Scaffold(
                        body: Column(
                          children: [
                            Center(
                              child: RaisedButton(
                                onPressed: this.getAllStudents,
                                child: Text('Get All Students'),
                              ),
                            ),
                            Center(
                              child: Center(
                                child: this.getAllStudentDataDone
                                    ? Text(this.receivedStudentData)
                                    : Text(''),
                              ),
                            )
                          ],
                        ),
                      )
                    : Scaffold(
                        body: Card(
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(50.0),
                                    child: Center(
                                      child: Text("Default Get Student View"),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                    child: Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Icon(Icons.add_a_photo, size: 120),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              Scaffold(
                backgroundColor: Color.fromRGBO(240, 240, 240, 0.7),
                body: Text(
                  'Teacher Details here',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Color.fromRGBO(240, 240, 240, 0.7),
                body: Text(
                  'Course Details here',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //http call funtions
  Future<http.Response> getAllStudents() async {
    // var uri = "https://192.168.8.130:8080/students/getstudentnames";
    var uri = "https://localhost:8080/students/getstudentnames";
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      this.getAllStudentDataDone = true;
      this.receivedStudentData = jsonDecode(response.body);
    } else {
      throw Exception('Failed to load the students');
    }
  }
}
