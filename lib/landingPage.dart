import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'networking.dart';

import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tollgate_app/register.dart';

import 'login.dart';
// import 'package:grouped_checkbox/grouped_checkbox.dart';

class LandingPage extends StatefulWidget {
  @override
  State createState() => new LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: initScreen(context),
  //   );
  // }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, null);
  }

  int count = 0;
  int count2 = 0;

  TextEditingController _ageTextController = TextEditingController();
  TextEditingController _glucoseTextController = TextEditingController();
  TextEditingController _bmiTextController = TextEditingController();
  TextEditingController _insulinTextController = TextEditingController();
  TextEditingController _bpTextController = TextEditingController();
  TextEditingController _skinTextController = TextEditingController();
  TextEditingController _dpTextController = TextEditingController();
  TextEditingController _pregnancyTextController = TextEditingController();
  TextEditingController _resultTextController = TextEditingController();
  TextEditingController _urlEntryController = TextEditingController();

  // _onClear() {
  //   setState(() {
  //     _ageTextController.text = "";
  //     _glucoseTextController.text = "";
  //     _bmiTextController.text = "";
  //     _insulinTextController.text = "";
  //     _bpTextController.text = "";
  //     _skinTextController.text = "";
  //     _dpTextController.text = "";
  //     _pregnancyTextController.text = "";
  //     _resultTextController.text = "";
  //     // _urlEntryController.text = "";
  //     count = 0;
  //     count2 = 0;
  //   });
  // }

  String url = "http://192.168.137.1:5000";
  // String url = "";
  var parseddata;
  String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                // colors: [Color(0xFFFFD700), Color(0xFFFF8C00)],
                colors: [Colors.orange[200], Colors.deepOrange[300]],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
            // shape: BoxShape.circle
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.6),
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.orange[200],
                  backgroundImage: AssetImage("assets/images/tollgate.png"),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.shortestSide * 0.02),
                  child: Container(
                    child: Text(
                      'TollGate App',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.black,
                          letterSpacing: .4,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   //abcd
              //   padding: const EdgeInsets.only(
              //       left: 60.0, top: 15.0, right: 65.0, bottom: 5.0),
              //   child: TextFormField(
              //       controller: _pregnancyTextController,
              //       style: GoogleFonts.lato(
              //         textStyle: TextStyle(
              //           color: Colors.black,
              //           letterSpacing: .4,
              //           fontSize: 15.0,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //       decoration: new InputDecoration(
              //         focusedBorder: OutlineInputBorder(
              //           borderSide:
              //               BorderSide(color: Colors.indigoAccent, width: 1.0),
              //           // borderRadius: const BorderRadius.all(
              //           //   const Radius.circular(25.0),
              //           // ),
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderSide:
              //               BorderSide(color: Colors.indigoAccent, width: 1.0),
              //         ),
              //         hintText: 'Pregnancy',
              //         hintStyle: GoogleFonts.lato(
              //           textStyle: TextStyle(
              //             color: Colors.grey,
              //             letterSpacing: .4,
              //             fontSize: 15.0,
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //         contentPadding: const EdgeInsets.only(
              //             top: 8.0, bottom: 8.0, right: 8.0, left: 15.0),
              //       )),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 60.0, top: 5.0, right: 65.0, bottom: 5.0),
              //   child: TextFormField(
              //       controller: _glucoseTextController,
              //       style: GoogleFonts.lato(
              //         textStyle: TextStyle(
              //           color: Colors.black,
              //           letterSpacing: .4,
              //           fontSize: 15.0,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //       decoration: new InputDecoration(
              //         focusedBorder: OutlineInputBorder(
              //           borderSide:
              //               BorderSide(color: Colors.indigoAccent, width: 1.0),
              //           // borderRadius: const BorderRadius.all(
              //           //   const Radius.circular(25.0),
              //           // ),
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderSide:
              //               BorderSide(color: Colors.indigoAccent, width: 1.0),
              //         ),
              //         hintText: 'Glucose value',
              //         hintStyle: GoogleFonts.lato(
              //           textStyle: TextStyle(
              //             color: Colors.grey,
              //             letterSpacing: .4,
              //             fontSize: 15.0,
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //         contentPadding: const EdgeInsets.only(
              //             top: 8.0, bottom: 8.0, right: 8.0, left: 15.0),
              //       )),
              // ),

              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.3),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: SizedBox(
                        height: 40.0,
                        width: 140.0,
                        child: FlatButton(
                            color: Colors.white,
                            onPressed: () {
                              // LoginPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.white)),
                            child: Text(
                              'Login',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: .4,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        height: 40.0,
                        width: 140.0,
                        child: FlatButton(
                            color: Colors.white,
                            onPressed: () {
                              // _onClear();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.white)),
                            child: Text(
                              'Register Now',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: .4,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.06,
                    bottom: MediaQuery.of(context).size.shortestSide * 0.3),
                child: Container(
                    width: 200.0,
                    child: Text(
                      "Please register if you haven't registered yet",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .4,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
