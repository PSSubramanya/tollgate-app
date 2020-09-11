import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'networking.dart';

import 'package:animated_card/animated_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tollgate_app/registerLoaderPage.dart';
import 'package:tollgate_app/userEntry.dart';

import 'login.dart';
// import 'package:grouped_checkbox/grouped_checkbox.dart';

class RegisterPage extends StatefulWidget {
  @override
  State createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // startTime();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: initScreen(context),
  //   );
  // }

  // startTime() async {
  //   var duration = new Duration(seconds: 3);
  //   return new Timer(duration, route);
  // }

  void route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => RegisterLoaderPage()));
  }

  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _email;
  String _password;
  String userid;

  SharedPreferences _sharedPreferences;
  final auth = FirebaseAuth.instance;

  bool registerAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      print('Form is valid. Email: $_email, Password: $_password');
      return true;
    } else {
      print('Form is invalid. Email: $_email, Password: $_password');
      return false;
    }
  }

  void validateAndSubmitNewUser() async {
    if (registerAndSave()) {
      // FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email, password: _password))
            .user;
        final userid = user.uid;
        print('New User Registering in: ${user.uid}');
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void registerNewUser() async {
    if (registerAndSave()) {
      // FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email, password: _password))
            .user;
        final userid = user.uid;
        _sharedPreferences = await SharedPreferences.getInstance();
        _sharedPreferences.setString("userId", user.uid);

        _sharedPreferences.setInt("count", 0);
        await auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        if (user.uid != null) {
          route();
          // Navigator.pushReplacementNamed(context, '/userentrypage');
        }

        print('New User Registering in: ${user.uid}');
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  TextEditingController _emailRegisterTextController = TextEditingController();
  TextEditingController _passwordRegisterTextController = TextEditingController();

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
            key: formkey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.shortestSide * 0.2),
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
                        top: MediaQuery.of(context).size.shortestSide * 0.15),
                    child: Container(
                      child: Text(
                        'Create account',
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
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailRegisterTextController,
                      validator: (value) =>
                          value.isEmpty ? "Email can't be empty" : null,
                      onSaved: (value) => _email = value,
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
                        hintText: 'Email',
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
                      obscureText: true,
                      controller: _passwordRegisterTextController,
                      validator: (value) =>
                          value.isEmpty ? "Password can't be empty" : null,
                      onSaved: (value) => _password = value,
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
                        hintText: 'Password',
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => UserEntryPage(),
                          //   ),
                          // );

                          // validateAndSubmitNewUser();

                          registerNewUser();

                          // route();

                          // registerAndSave();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.white)),
                        child: Text(
                          'Register',
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
                        onPressed: () {
                          // _onClear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            // borderRadius: BorderRadius.circular(25.0),
                            // side: BorderSide(color: Colors.white)
                            ),
                        child: Text(
                          'Login Page',
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
                      child: Text(
                        "If you have an account, then login",
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
