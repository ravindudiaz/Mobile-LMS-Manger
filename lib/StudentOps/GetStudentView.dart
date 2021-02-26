import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class GetStudentView extends StatefulWidget {
  //constructor
  GetStudentView(this.screenWidth, this.screenHeight, this.baseUri);

  var screenWidth;
  var screenHeight;
  String baseUri;

  @override
  GetStudentViewState createState() {
    return GetStudentViewState(screenWidth, screenHeight, baseUri);
  }
}

class GetStudentViewState extends State<GetStudentView> {
  //constructor
  GetStudentViewState(this.screenWidth, this.screenHeight, this.baseUri);

  var screenWidth;
  var screenHeight;
  String baseUri;

  Future<http.Response> allStudentsResponse;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: screenWidth,
            padding: EdgeInsets.only(
                top: 0.01 * screenHeight, bottom: 0.01 * screenHeight),
            height: screenHeight * 0.1,
            alignment: Alignment.center,
            color: Colors.blue[50],
            child: RaisedButton(
              shape: StadiumBorder(),
              color: Colors.blue[900],
              elevation: 5.0,
              onPressed: () {
                setState(() {
                  this.allStudentsResponse = this.getAllStudents();
                });
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Get All Students',
                  style: TextStyle(color: Colors.white, fontSize: 15),
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
                  var studentData = jsonDecode(snapshot.data.body);
                  print(snapshot.data);

                  return ListView.builder(
                    // color: Colors.yellow[100],
                    // width: screenWidth * 0.9,
                    // shrinkWrap: true,
                    itemCount: studentData.length,
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 4.0,
                        child: ListTile(
                          title: Text(
                            studentData[index]["name"],
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Student ID : " +
                                  studentData[index]["uid"].toString()),
                              Text("Email : " + studentData[index]["email"]),
                            ],
                          ),
                          // isThreeLine: true,
                          leading: FlutterLogo(
                            size: 40.0,
                            curve: Curves.easeIn,
                            duration: Duration(milliseconds: 500),
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
    );
  }
}
