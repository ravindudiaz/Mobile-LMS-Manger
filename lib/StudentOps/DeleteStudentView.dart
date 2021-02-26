import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DeleteStudentView extends StatefulWidget {
  //constructor
  DeleteStudentView(this.screenWidth, this.screenHeight, this.baseUri);

  var screenWidth;
  var screenHeight;
  String baseUri;

  @override
  DeleteStudentViewState createState() {
    return DeleteStudentViewState(
        this.screenWidth, this.screenHeight, this.baseUri);
  }
}

class DeleteStudentViewState extends State<DeleteStudentView> {
  //constructor
  DeleteStudentViewState(this.screenWidth, this.screenHeight, this.baseUri);
  var screenWidth;
  var screenHeight;
  String baseUri;

  final _deleteStudentFormKey = GlobalKey<FormState>();
  Map<String, dynamic> stuDetailsToDelete = {};
  Future<http.Response> deletedStudentResponse;

  //Delete Student Method
  Future<http.Response> deleteStudent(
      Map<String, dynamic> stuDetailsToDelete) async {
    var uri = baseUri + "students/deletestudent/" + stuDetailsToDelete["uid"];

    var response = await http.delete(uri);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Student ID : " +
          stuDetailsToDelete["uid"] +
          " deleted successfully");
    } else {
      print("Delete student unsuccessful...");
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
              'Enter the id of the student you want to delete:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            child: Form(
                key: _deleteStudentFormKey,
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
                              stuDetailsToDelete = {"uid": value};
                            });
                          }
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
                          print("Delete button pressed...");
                          if (_deleteStudentFormKey.currentState.validate()) {
                            print(_deleteStudentFormKey.currentState);

                            setState(() {
                              deletedStudentResponse =
                                  deleteStudent(stuDetailsToDelete);
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
                            'Delete Student',
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
