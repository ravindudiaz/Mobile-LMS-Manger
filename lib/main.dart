import 'dart:convert';

import 'package:StudentPlatformApp/UpdateStudentForm.dart';
import 'package:StudentPlatformApp/addStudentForm.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './Domains/Student.dart';
import 'dart:async';

void main() {
  runApp(PlatformApp());
}

class PlatformApp extends StatelessWidget {
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
          ),
        ),
      ),
      home: StudentPlatformApp(),
    );
  }
}

class StudentPlatformApp extends StatefulWidget {
  @override
  StudentPlatformAppState createState() {
    return StudentPlatformAppState();
  }
}

class StudentPlatformAppState extends State<StudentPlatformApp> {
  // String baseUri = "http://10.0.2.2:8080/";
  String baseUri = "http://192.168.8.130:8080/";

  //Regarding Students
  Future<http.Response> allStudentsResponse;

  // Map<String, dynamic> stuDetailsToAdd = {};
  // Future<http.Response> createStudentResponse;

  Map<String, dynamic> stuDetailsToUpdate = {};
  Future<http.Response> updatedStudentResponse;

  Future<http.Response> deletedStudentResponse;

  bool addStudentSelected = false;
  bool getStudentSelected = false;
  bool deleteStudentSelected = false;
  bool updateStudentSelected = false;

  //Regarding Teachers
  bool getAllTeacherDataDone = false;

  bool addTeacherSelected = false;
  bool getTeacherSelected = false;
  bool deleteTeacherSelected = false;
  bool updateTeacherSelected = false;

  var receivedTeacherData;

  var sHeight;
  var sWidth;

  //Regarding Courses
  bool getAllCourseDataDone = false;

  bool addCourseSelected = false;
  bool getCourseSelected = false;
  bool deleteCourseSelected = false;
  bool updateCourseSelected = false;

  var receivedCourseData;

  Color defaultDrawerItemColor = Colors.blue[100];
  Color selectedDraweItemColor = Colors.blue[300];

  Color changeDrawerItemColor(bool selected) {
    return selected ? selectedDraweItemColor : defaultDrawerItemColor;
  }

//build function
  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final screenWidth = mediaData.size.width;
    this.sWidth = screenWidth;
    final screenHeight = mediaData.size.height;
    this.sHeight = screenHeight;
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Mobile LMS Manager'),
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
                drawer: Container(
                  width: screenWidth * 0.6,
                  child: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.blue[800],
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Student Ops',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: changeDrawerItemColor(getStudentSelected),
                          child: ListTileTheme(
                            // selectedTileColor: this.drawerItemColor,
                            child: ListTile(
                              enabled: true,
                              leading: Icon(
                                Icons.person_pin,
                                color: Colors.green,
                              ),
                              title: Text('Get Student'),
                              onTap: () {
                                setState(() {
                                  this.getStudentSelected = true;
                                  this.addStudentSelected = false;
                                  this.updateStudentSelected = false;
                                  this.deleteStudentSelected = false;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Card(
                          color: changeDrawerItemColor(addStudentSelected),
                          child: ListTileTheme(
                            selectedTileColor: Colors.blue[300],
                            child: ListTile(
                              enabled: true,
                              leading: Icon(
                                Icons.person_add_rounded,
                                color: Colors.yellow[800],
                              ),
                              title: Text('Add Student'),
                              onTap: () {
                                this.setState(() {
                                  this.addStudentSelected = true;
                                  this.getStudentSelected = false;
                                  this.updateStudentSelected = false;
                                  this.deleteStudentSelected = false;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Card(
                          color: changeDrawerItemColor(updateStudentSelected),
                          child: ListTileTheme(
                            selectedTileColor: Colors.blue[300],
                            child: ListTile(
                              leading: Icon(
                                Icons.update_rounded,
                                color: Colors.blue[800],
                              ),
                              title: Text('Update Student'),
                              onTap: () {
                                this.setState(() {
                                  this.addStudentSelected = false;
                                  this.getStudentSelected = false;
                                  this.updateStudentSelected = true;
                                  this.deleteStudentSelected = false;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Card(
                          color: changeDrawerItemColor(deleteStudentSelected),
                          child: ListTileTheme(
                            selectedTileColor: Colors.blue[300],
                            child: ListTile(
                              leading: Icon(
                                Icons.person_remove_rounded,
                                color: Colors.red,
                              ),
                              title: Text('Delete Student'),
                              onTap: () {
                                this.setState(() {
                                  this.addStudentSelected = false;
                                  this.getStudentSelected = false;
                                  this.updateStudentSelected = false;
                                  this.deleteStudentSelected = true;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                body: this.getStudentSelected
                    ? Scaffold(
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: screenWidth,
                              padding: EdgeInsets.only(
                                  top: 0.01 * screenHeight,
                                  bottom: 0.01 * screenHeight),
                              height: screenHeight * 0.1,
                              alignment: Alignment.center,
                              color: Colors.blue[50],
                              child: RaisedButton(
                                shape: StadiumBorder(),
                                color: Colors.blue[900],
                                elevation: 5.0,
                                onPressed: () {
                                  setState(() {
                                    this.allStudentsResponse =
                                        this.getAllStudents();
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Get All Students',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  width: screenWidth * 0.4,
                                ),
                              ),
                            ),
                            Container(
                              height: screenHeight * 0.7,
                              child: FutureBuilder<http.Response>(
                                future: allStudentsResponse,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var studentData =
                                        jsonDecode(snapshot.data.body);
                                    print(snapshot.data);

                                    return ListView.builder(
                                      // color: Colors.yellow[100],
                                      // width: screenWidth * 0.9,
                                      // shrinkWrap: true,
                                      itemCount: studentData.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Card(
                                          color: Colors.white,
                                          elevation: 4.0,
                                          child: ListTile(
                                            title: Text(
                                              studentData[index]["name"],
                                            ),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Student ID : " +
                                                    studentData[index]["uid"]
                                                        .toString()),
                                                Text("Email : " +
                                                    studentData[index]
                                                        ["email"]),
                                              ],
                                            ),
                                            // isThreeLine: true,
                                            leading: FlutterLogo(
                                              size: 40.0,
                                              curve: Curves.easeIn,
                                              duration:
                                                  Duration(milliseconds: 500),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.person_pin,
                                        color: Colors.blue[100],
                                        size: 120,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        // ),
                      )
                    : (this.addStudentSelected
                        ? AddStudentForm(screenWidth, screenHeight, baseUri)
                        : (this.updateStudentSelected
                            ? UpdateStudentForm(
                                screenWidth, screenHeight, baseUri)
                            : (this.deleteStudentSelected
                                ? AddStudentForm(
                                    screenWidth, screenHeight, baseUri)
                                : Scaffold(
                                    body: Container(
                                      height: double.infinity,
                                      color: Colors.blue[50],
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: screenWidth * 0.1),
                                            width: screenWidth * 0.8,
                                            height: screenHeight * 0.2,
                                            child: Text(
                                              'Welcome Admin!',
                                              style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontSize: 24),
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                          Container(
                                            width: screenWidth * 0.8,
                                            padding: EdgeInsets.only(
                                              top: screenHeight * 0.05,
                                            ),
                                            child: Icon(
                                              Icons.admin_panel_settings,
                                              color: Colors.green,
                                              size: 150.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )))),
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

//Loader display
  Widget displayProgressIndicator() {
    Timer.run(() {
      return Container(
        child: CircularProgressIndicator(
          backgroundColor: Colors.blue[200],
        ),
        width: this.sWidth,
        height: sWidth * 0.65,
        alignment: Alignment.center,
      );
    });
  }

  //Drawer Selector
  void selectedDrawerItem(bool current, bool other1, bool other2, bool other3) {
    if (!current) current = true;
    other1 = false;
    other2 = false;
    other3 = false;
  }

  //http call funtions

  //Students
  //Get all students
  Future<http.Response> getAllStudents() async {
    // var uri = "http://192.168.8.130:8080/students/getallstudents";
    var uri = baseUri + "students/getallstudents";

    var response = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response);
      return response;
    } else {
      throw Exception('Failed to load the students');
    }
  }

  //Update Student
  Future<http.Response> updateStudent(Map<String, dynamic> student) async {
    var uri = baseUri + "students/updatestudent";

    var response = await http.put(
      uri,
      body: jsonEncode(
        <String, dynamic>{
          "uid": student["uid"],
          "email": student["email"],
          "name": student["name"]
        },
      ),
      headers: {
        "Content-Type": 'application/json ; charset=UTF-8',
      },
    );
    print("Ok?");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response);
      return response;
    } else {
      throw Exception('Failed to update student');
    }
  }

  //Teachers
  //Get all teachers
  Future<http.Response> getAllTeachers() async {
    var uri = "http://localhost/teachers/getallteachers";

    var response = await http.get(uri, headers: {
      "Accept": "application/json",
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response);
      return response;
    } else {
      throw Exception('Failed to load the teachers');
    }
  }

  //Courses
  //Get all courses
  void getAllCourses() async {
    var uri = "http://localhost/courses/getallcourses";
    http.Response response = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        this.getAllCourseDataDone = true;
        print(receivedCourseData);
      });
    } else {
      throw Exception("Could not load the courses");
    }
  }
}
