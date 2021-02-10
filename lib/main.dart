import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  //Regarding Students
  bool getAllStudentDataDone = false;

  bool addStudentSelected = false;
  bool getStudentSelected = false;
  bool deleteStudentSelected = false;
  bool updateStudentSelected = false;

  var receivedStudentData;

  //Regarding Teachers
  bool getAllTeacherDataDone = false;

  bool addTeacherSelected = false;
  bool getTeacherSelected = false;
  bool deleteTeacherSelected = false;
  bool updateTeacherSelected = false;

  var receivedTeacherData;

  //Regarding Courses
  bool getAllCourseDataDone = false;

  bool addCourseSelected = false;
  bool getCourseSelected = false;
  bool deleteCourseSelected = false;
  bool updateCourseSelected = false;

  var receivedCourseData;

//build function
  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final screenWidth = mediaData.size.width;
    final screenHeight = mediaData.size.height;
    return Scaffold(
      body: DefaultTabController(
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
                            child: Text(
                              'Student Operations',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.blue[100],
                          child: ListTileTheme(
                            selectedTileColor: Colors.blue[300],
                            child: ListTile(
                              // selected: true,
                              leading: Icon(Icons.person_pin),
                              title: Text('Get Student'),
                              onTap: () {
                                setState(() {
                                  this.addStudentSelected = true;
                                });
                              },
                              // selectedColor: Colors.blue[300],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.blue[100],
                          child: ListTileTheme(
                            selectedTileColor: Colors.blue[300],
                            child: ListTile(
                              leading: Icon(Icons.person_add_rounded),
                              title: Text('Add Student'),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.blue[100],
                          child: ListTileTheme(
                            selectedTileColor: Colors.blue[300],
                            child: ListTile(
                              leading: Icon(Icons.update_rounded),
                              title: Text('Update Student'),
                              hoverColor: Colors.blue[100],
                              // selectedTileColor: Colors.blue[300],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.blue[100],
                          child: ListTileTheme(
                            selectedTileColor: Colors.blue[300],
                            child: ListTile(
                              leading: Icon(Icons.person_remove_rounded),
                              title: Text('Delete Student'),
                              hoverColor: Colors.blue[100],
                              // selectedTileColor: Colors.blue[300],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                body: this.addStudentSelected
                    ? Scaffold(
                        body: Container(
                          color: Colors.blue[50],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: screenWidth * 0.5,
                                child: RaisedButton(
                                  color: Colors.blue[200],
                                  elevation: 5.0,
                                  onPressed: this.getAllStudents,
                                  child: Text('Get All Students'),
                                ),
                              ),
                              Center(
                                child: Container(
                                  // color: Colors.yellow[100],
                                  width: screenWidth * 0.9,
                                  child: this.getAllStudentDataDone
                                      ? Card(
                                          color: Colors.white,
                                          elevation: 4.0,
                                          child: ListTile(
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Student ID : " +
                                                    receivedStudentData[0]
                                                            ["uid"]
                                                        .toString()),
                                                Text("Email : " +
                                                    receivedStudentData[0]
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
                                            title: Text(
                                              this.receivedStudentData[0]
                                                  ["name"],
                                            ),
                                          ),
                                        )
                                      : Text(''),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Scaffold(
                        body: Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "Get Students",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.blue[100]),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: Container(
                                    child: Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Icon(
                                    Icons.person_pin,
                                    size: 120,
                                    color: Colors.blue[100],
                                  ),
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

  //Students
  //Get all students
  void getAllStudents() async {
    // var uri = "https://192.168.8.130:8080/students/getstudentnames";
    var uri = "http://10.0.2.2:8080/students/getallstudents";

    http.Response response = await http.get(
      uri,
      headers: {
        "Accept": "application/json",
      },
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        this.receivedStudentData = jsonDecode(response.body);
        this.getAllStudentDataDone = true;
      });

      print(this.receivedStudentData);
    } else {
      throw Exception('Failed to load the students');
    }
  }

  //Teachers
  //Get all teachers
  void getAllTeachers() async {
    var uri = "http://localhost/teachers/getallteachers";

    http.Response response = await http.get(uri, headers: {
      "Accept": "application/json",
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      this.setState(() {
        this.receivedTeacherData = jsonDecode(response.body);
        this.getAllTeacherDataDone = true;
        print(receivedTeacherData);
      });
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
        this.receivedCourseData = jsonDecode(response.body);
        this.getAllCourseDataDone = true;
        print(receivedCourseData);
      });
    } else {
      throw Exception("Could not load the courses");
    }
  }
}
