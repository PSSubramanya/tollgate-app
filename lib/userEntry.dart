import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'networking.dart';

import 'package:animated_card/animated_card.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:tollgate_app/constants.dart';
import 'package:tollgate_app/register.dart';
import 'package:tollgate_app/savingProgressbarPage.dart';
// import 'package:toast/toast.dart';

import 'checkingPage.dart';
import 'login.dart';

class UserEntryPage extends StatefulWidget {
  @override
  State createState() => new UserEntryPageState();
}

class UserEntryPageState extends State<UserEntryPage> {
  // String userIDValue = getUserIdValue;
  String uid;

  String vehicleTypeDropdown;
  Color fieldColor = Color(0xFFF59656);

  void userData() async {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    final auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    itemRef = database.reference().child("${user.uid}/userinfo");
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
  }

  List<Items> itemsList = List();
  Items items;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData();

    // items = Items("", "", "", "", "", "", "", "")
    items = Items("", "", "", "", "");

    // itemRef = database.reference().child('items');
    // itemRef = database.reference().child(inputUserInfo()).child('userinfo');

    // startTime();
  }

  _onEntryAdded(Event event) {
    setState(() {
      // itemRef.child(_userId);
      itemsList.add(Items.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = itemsList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      itemsList[itemsList.indexOf(old)] = Items.fromSnapshot(event.snapshot);
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      itemRef.push().set(items.toJson());
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

  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _phoneNumberTextController = TextEditingController();
  TextEditingController _vehicleNumberTextController = TextEditingController();
  TextEditingController _vehicleTypeTextController = TextEditingController();
  TextEditingController _amountTextController = TextEditingController();

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
                        top: MediaQuery.of(context).size.shortestSide * 0.1),
                    child: Container(
                      child: Text(
                        'User info',
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
                  //abcd
                  padding: const EdgeInsets.only(
                      left: 40.0, top: 15.0, right: 40.0, bottom: 5.0),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _nameTextController,

                      // initialValue: '',
                      validator: (value) =>
                          value.isEmpty ? "Name can't be empty" : null,
                      onSaved: (value) => items.name = value,
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
                        hintText: 'Name',
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
                      controller: _phoneNumberTextController,
                      // initialValue: '',
                      validator: (value) =>
                          value.isEmpty ? "Phone number can't be empty" : null,
                      onSaved: (value) => items.phoneNumber = value,
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
                        hintText: 'Phone number',
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
                      controller: _vehicleNumberTextController,
                      // initialValue: '',
                      validator: (value) =>
                          value.isEmpty ? "Vehicle no. can't be empty" : null,
                      onSaved: (value) => items.vehicleNumber = value,
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
                        hintText: 'Vehicle number',
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
                  child: Container(
                    height: 58.0,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.black, width: 0.2),
                      color: fieldColor,
                      // borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListTile(
                      title: DropdownButtonFormField(
                        value: vehicleTypeDropdown,
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     // return "select an option";

                        //   }
                        //   return null;
                        // },

                        // validator: (value) =>
                        //     value.isEmpty ? "Vehicle Type can't be empty": null,

                        validator: (value) => value.isEmpty
                            ? "Vehicle Type can't be emptys"
                            : null,

                        // value.isEmpty
                        //     ? Toast.show(
                        //         "Vehicle Type can't be empty", context,
                        //         duration: Toast.LENGTH_LONG)
                        //     : null,

                        // itemHeight: 48.1,
                        itemHeight: 48.1,
                        iconEnabledColor: Colors.white,
                        decoration: InputDecoration.collapsed(
                          // hoverColor: Colors.black,
                          // // fillColor: Colors.black,
                          // // focusColor: Colors.black,
                          // enabled: true,
                          // filled: true,
                          hintText: "Vehicle Type",
                          hintStyle: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.black,
                              letterSpacing: .4,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        items: vehicleType.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: .4,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            vehicleTypeDropdown =
                                vehicleType[vehicleType.indexOf(value)];
                            _vehicleTypeTextController.text =
                                vehicleTypeDropdown;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40.0, top: 5.0, right: 40.0, bottom: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _amountTextController,
                    // initialValue: '',
                    validator: (value) =>
                        value.isEmpty ? "Amount can't be empty" : null,
                    onSaved: (value) => items.amount = value,
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
                      hintText: 'Amount in the wallet',
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
                    ),
                  ),
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
                          if (formKey.currentState.validate()) {
                            final item = Items(
                                _nameTextController.text,
                                _phoneNumberTextController.text,
                                _vehicleNumberTextController.text,
                                _vehicleTypeTextController.text,
                                _amountTextController.text);
                            itemRef.push().set(item.toJson());
                            if (itemRef.key != null) {
                              Navigator.pushReplacementNamed(
                                  context, '/travelentrypage');
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
                    // child: FlatButton(
                    //     // color: Colors.white,
                    //     onPressed: () {
                    //       // _onClear();
                    //       Navigator.pop(context
                    //           // MaterialPageRoute(
                    //           //   builder: (context) => LoginPage(),
                    //           // ),
                    //           );
                    //     },
                    //     shape: RoundedRectangleBorder(
                    //         // borderRadius: BorderRadius.circular(25.0),
                    //         // side: BorderSide(color: Colors.white)
                    //         ),
                    //     child: Text(
                    //       'Cancel',
                    //       textAlign: TextAlign.center,
                    //       style: GoogleFonts.lato(
                    //         textStyle: TextStyle(
                    //           color: Colors.black,
                    //           letterSpacing: .4,
                    //           fontSize: 14.0,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     )),
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

class Items {
  String key;
  String name;
  String phoneNumber;
  String vehicleNumber;
  String vehicleType;
  String amount;

  Items(
    // this.uid,
    this.name,
    this.phoneNumber,
    this.vehicleNumber,
    this.vehicleType,
    this.amount,
    // this.starting,
    // this.destination,
    // this.arrival,
  );

  Items.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        // :uid = snapshot.inputData(),
        name = snapshot.value["name"],
        phoneNumber = snapshot.value["phoneNumber"],
        vehicleNumber = snapshot.value["vehicleNumber"],
        vehicleType = snapshot.value["vehicleType"],
        amount = snapshot.value["amount"];
  // starting = snapshot.value["starting"],
  // destination = snapshot.value["destination"],
  // arrival = snapshot.value["arrival"];

  toJson() {
    return {
      "name": name,
      "phoneNumber": phoneNumber,
      "vehicleNumber": vehicleNumber,
      "vehicleType": vehicleType,
      "amount": amount,
      // "starting": starting,
      // "destination": destination,
      // "arrival": arrival,
    };
  }
}
