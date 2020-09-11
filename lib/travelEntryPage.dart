import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'networking.dart';

import 'package:animated_card/animated_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tollgate_app/register.dart';
import 'package:tollgate_app/savingProgressBar2.dart';
import 'package:tollgate_app/savingProgressbarPage.dart';
import 'package:tollgate_app/userEntry.dart';

import 'checkingPage.dart';
import 'login.dart';
// import 'package:grouped_checkbox/grouped_checkbox.dart';

// final FirebaseApp app = FirebaseApp(
//   options:FirebaseOptions(
//     googleAppID: '1:885996125635:android:3a410d02f96fa088555176',
//     apiKey: 'AIzaSyDGH04Iz7GnVH98Qs_mcmBng9R7G4bVMJY',
//     databaseURL: 'https://tollgateapp-febd0.firebaseio.com',
//   )
// );

class TravelEntryPage extends StatefulWidget {
  // final String getUserIdValue;

  // // receive data from the FirstScreen as a parameter
  // UserEntryPage({Key key, @required this.getUserIdValue}) : super(key: key);

  @override
  State createState() => new TravelEntryPageState();
}

class TravelEntryPageState extends State<TravelEntryPage> {
  String uid;

  void userData2() async {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    final auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    itemRef2 = database.reference().child("${user.uid}/travelinfo");
    itemRef2.onChildAdded.listen(_onEntryAdded);
    itemRef2.onChildChanged.listen(_onEntryChanged);
    // print("CURRENT USER LOGGED IN: "+user.uid);
  }

  List<Items2> itemsList2 = List();
  Items2 items2;
  DatabaseReference itemRef2;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData2();

    // items2 = Items2("", "", "", "", "", "", "", "");
    items2 = Items2("", "", "");
    final FirebaseDatabase database = FirebaseDatabase.instance;

    // itemRef2 = database.reference().child('travelinfo');
    // itemRef2.onChildAdded.listen(_onEntryAdded);
    // itemRef2.onChildChanged.listen(_onEntryChanged);
    // startTime();
  }

  _onEntryAdded(Event event) {
    setState(() {
      // itemRef.child(_userId);
      itemsList2.add(Items2.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = itemsList2.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      itemsList2[itemsList2.indexOf(old)] = Items2.fromSnapshot(event.snapshot);
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      itemRef2.push().set(items2.toJson());
    }
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

  // int count = 0;
  // int count2 = 0;

  // Items items;
  // DatabaseReference itemRef;

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // TextEditingController _amountTextController = TextEditingController();
  TextEditingController _fromTextController = TextEditingController();
  TextEditingController _destinationTextController = TextEditingController();
  TextEditingController _arrivalTextController = TextEditingController();

  String _userId;
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
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.shortestSide * 0.1),
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
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.shortestSide * 0.06),
                    child: Container(
                      child: Text(
                        'Travel info',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .4,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40.0, top: 40.0, right: 40.0, bottom: 5.0),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _fromTextController,
                      // initialValue: '',
                      validator: (value) =>
                          value.isEmpty ? "This field can't be empty" : null,
                      onSaved: (value) => items2.starting = value,
                      // validator: (val) => val == "" ? val : null,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .4,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      decoration: new InputDecoration(
                        fillColor: Color(0xFFF59656),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFF59656), width: 1.0),
                          // borderRadius: const BorderRadius.all(
                          //   const Radius.circular(25.0),
                          // ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFF59656), width: 1.0),
                        ),
                        hintText: 'Starting point',
                        hintStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: .4,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, right: 8.0, left: 15.0),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40.0, top: 5.0, right: 40.0, bottom: 5.0),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _destinationTextController,
                      // initialValue: '',
                      validator: (value) =>
                          value.isEmpty ? "This field can't be empty" : null,
                      onSaved: (value) => items2.destination = value,
                      // validator: (val) => val == "" ? val : null,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .4,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      decoration: new InputDecoration(
                        fillColor: Color(0xFFF59656),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFF59656), width: 1.0),
                          // borderRadius: const BorderRadius.all(
                          //   const Radius.circular(25.0),
                          // ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFF59656), width: 1.0),
                        ),
                        hintText: 'Destination',
                        hintStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: .4,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, right: 8.0, left: 15.0),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40.0, top: 5.0, right: 40.0, bottom: 5.0),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _arrivalTextController,
                      // initialValue: '',
                      validator: (value) =>
                          value.isEmpty ? "This field can't be empty" : null,
                      onSaved: (value) => items2.arrival = value,
                      // validator: (val) => val == "" ? val : null,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .4,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      decoration: new InputDecoration(
                        fillColor: Color(0xFFF59656),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFF59656), width: 1.0),
                          // borderRadius: const BorderRadius.all(
                          //   const Radius.circular(25.0),
                          // ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFF59656), width: 1.0),
                        ),
                        hintText: 'Arrival',
                        hintStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: .4,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, right: 8.0, left: 15.0),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.1,
                  ),
                  child: SizedBox(
                    height: 40.0,
                    width: 200.0,
                    child: FlatButton(
                        color: Colors.white,
                        onPressed: () {
                          // handleSubmit();

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SavingProgreesPage(),
                          //   ),
                          // );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SavingProgreesPage2(),
                          //   ),
                          // );

                          if (formKey.currentState.validate()) {
                            final item2 = Items2(
                                _fromTextController.text,
                                _destinationTextController.text,
                                _arrivalTextController.text);
                            itemRef2.push().set(item2.toJson());
                            if (itemRef2.key != null) {
                              Navigator.pushReplacementNamed(
                                  context, '/paymentpage');
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.white)),
                        child: Text(
                          'Save',
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
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.02,
                  ),
                  child: SizedBox(
                    height: 40.0,
                    width: 200.0,
                    child: FlatButton(
                        // color: Colors.white,
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          final sharedPreference =
                              await SharedPreferences.getInstance();
                          sharedPreference.clear();
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        shape: RoundedRectangleBorder(
                            // borderRadius: BorderRadius.circular(25.0),
                            // side: BorderSide(color: Colors.white)
                            ),
                        child: Text(
                          'Logout',
                          textAlign: TextAlign.center,
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
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.shortestSide * 0.06,
                      bottom: MediaQuery.of(context).size.shortestSide * 0.3),
                  child: Container(
                    width: 200.0,
                    // child: Text(
                    //   "If you have an account, then login",
                    //   style: GoogleFonts.lato(
                    //     textStyle: TextStyle(
                    //       color: Colors.white,
                    //       letterSpacing: .4,
                    //       fontSize: 14.0,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    //   textAlign: TextAlign.center,
                    // )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.shortestSide * 0.06,
                      bottom: MediaQuery.of(context).size.height * 0.6),
                  // bottom: MediaQuery.of(context).size.shortestSide * 0.05),
                  child: Container(
                    width: 250.0,
                    height: 60.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Items2 {
  String key;
  // String uid;
  // String name;
  // String phoneNumber;
  // String vehicleNumber;
  // String vehicleType;
  // String amount;
  String starting;
  String destination;
  String arrival;

  Items2(
    // this.uid,
    // this.name,
    // this.phoneNumber,
    // this.vehicleNumber,
    // this.vehicleType,
    // this.amount,
    this.starting,
    this.destination,
    this.arrival,
  );

  Items2.fromSnapshot(DataSnapshot snapshot)
      // : key = snapshot.key,
      // : key = snapshot.value['uid'],
      // : key = snapshot.value['userid'],
      : key = snapshot.key,
        // :uid = snapshot.inputData(),
        // name = snapshot.value["name"],
        // phoneNumber = snapshot.value["phoneNumber"],
        // vehicleNumber = snapshot.value["vehicleNumber"],
        // vehicleType = snapshot.value["vehicleType"],
        // amount = snapshot.value["amount"],
        starting = snapshot.value["starting"],
        destination = snapshot.value["destination"],
        arrival = snapshot.value["arrival"];

  toJson() {
    return {
      // "name": name,
      // "phoneNumber": phoneNumber,
      // "vehicleNumber": vehicleNumber,
      // "vehicleType": vehicleType,
      // "amount": amount,
      "starting": starting,
      "destination": destination,
      "arrival": arrival,
    };
  }
}
