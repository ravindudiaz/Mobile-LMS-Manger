import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UpdateStudentForm extends StatefulWidget {
//constructor
  UpdateStudentForm(this.screenWidth, this.screenHeight, this.baseUri);

  var screenWidth;
  var screenHeight;
  String baseUri;

  @override
  UpdateStudentFormState createState() {
    return UpdateStudentFormState(screenWidth, screenHeight, baseUri);
  }
}

class UpdateStudentFormState extends State<UpdateStudentForm> {
  //constructor
  UpdateStudentFormState(this.screenWidth, this.screenHeight, this.baseUri);

  var screenWidth;
  var screenHeight;
  String baseUri;

  Map<String, dynamic> stuDetailsToUpdate = {};
  Future<http.Response> updatedStudentResponse;

  //Update Student Form
  final _updateStudentFormKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: screenHeight * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.yellow[100],
            ),
            child: Text(
              'Enter the updated details of the student below:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            child: Form(
                key: _updateStudentFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.9,
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          // alignLabelWithHint: true,
                          hintText: ' Student User ID',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide:
                                BorderSide(color: Colors.blue[900], width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide:
                                BorderSide(color: Colors.blue[400], width: 2.0),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'User ID cannot be empty';
                          } else {
                            if (value.isNotEmpty) {
                              try {
                                var valNum = int.parse(value);
                              } catch (e) {
                                return 'Student ID should be a number';
                              }
                            }
                            setState(() {
                              stuDetailsToUpdate = {"uid": value};
                            });
                          }
                        },
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.9,
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          // alignLabelWithHint: true,
                          hintText: ' Student Name',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide:
                                BorderSide(color: Colors.blue[900], width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide:
                                BorderSide(color: Colors.blue[400], width: 2.0),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Student Name cannot be empty';
                          } else {
                            setState(() {
                              stuDetailsToUpdate
                                  .addAll({"name": value.toString()});
                            });
                          }
                          //  else {
                          //   try {
                          //     var valNum = int.parse(value);
                          //   } catch (Exception) {}
                          // }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.9,
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          // alignLabelWithHint: true,
                          hintText: ' Student Email Address',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide:
                                BorderSide(color: Colors.blue[900], width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide:
                                BorderSide(color: Colors.blue[400], width: 2.0),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter the student\'s email address';
                          } else {
                            this.setState(() {
                              stuDetailsToUpdate
                                  .addAll({"email": value.toString()});
                            });

                            print(stuDetailsToUpdate);
                          }
                          //  else {
                          //   try {
                          //     var valNum = int.parse(value);
                          //   } catch (Exception) {}
                          // }R
                          return null;
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: screenWidth,
                      margin: EdgeInsets.only(
                        top: 0.05 * screenHeight,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                      ),
                      child: RaisedButton(
                        color: Colors.blue[800],
                        shape: StadiumBorder(),
                        elevation: 4.0,
                        focusElevation: 5.0,
                        onPressed: () {
                          print("Update button pressed...");
                          if (_updateStudentFormKey.currentState.validate()) {
                            print(_updateStudentFormKey.currentState);

                            setState(() {
                              updatedStudentResponse =
                                  updateStudent(stuDetailsToUpdate);
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: BorderRadius.circular(40.0)),
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.1,
                          alignment: Alignment.center,
                          child: Text(
                            'Update Student',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
