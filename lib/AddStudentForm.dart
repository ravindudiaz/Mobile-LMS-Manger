import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {}

class AddStudentForm extends StatefulWidget {
  AddStudentForm(this.screenWidth, this.screenHeight);
  var screenWidth;
  var screenHeight;
  @override
  AddStudentFormState createState() {
    return AddStudentFormState(screenWidth, screenHeight);
  }
}

class AddStudentFormState extends State<AddStudentForm> {
  // String baseUri = "http://10.0.2.2:8080/";
  String baseUri = "http://192.168.8.130:8080/";

  //constructor
  AddStudentFormState(this.screenWidth, this.screenHeight);

  //screen measurement properties
  var screenHeight;
  var screenWidth;

  //Form properties
  final _addStudentFormKey = GlobalKey<FormState>();

  Map<String, dynamic> stuDetailsToAdd = {};
  Future<http.Response> createStudentResponse;

  //Create Student
  Future<http.Response> createStudent(var email, var name) async {
    var uri = baseUri + "students/addstudent";

    var response = await http.post(
      uri,
      body: jsonEncode(
        <String, dynamic>{
          "email": email,
          "name": name,
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
      throw Exception('Failed to create student');
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
              'Enter the details of the student below:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            child: Form(
                key: _addStudentFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                              stuDetailsToAdd = {"name": value.toString()};
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
                            return 'Enter an email address';
                          } else {
                            this.setState(() {
                              stuDetailsToAdd
                                  .addAll({"email": value.toString()});
                            });

                            print(stuDetailsToAdd);
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
                          print("Submit button pressed...");
                          if (_addStudentFormKey.currentState.validate()) {
                            print(_addStudentFormKey.currentState);

                            setState(() {
                              createStudentResponse = createStudent(
                                stuDetailsToAdd["email"],
                                stuDetailsToAdd["name"],
                              );
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
                            'Create Student',
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
