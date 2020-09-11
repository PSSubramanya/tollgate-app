import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tollgate_app/login.dart';
import 'dart:async';

// import 'package:tollgate_app/payment_page.dart';

import 'landingPage.dart';

class HomeDisplay extends StatefulWidget {
  @override
  State createState() => new HomeDisplayState();
  // State<StatefulWidget> createState() {
  //   return HomeDisplayState();
}

class HomeDisplayState extends State<HomeDisplay> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  setVisitingFlag(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString("userId");
    int count = preferences.getInt('count');
    print(count);
    if (id == null) {
      Future.delayed(Duration(seconds: 1)).then((value) {
        Navigator.pushReplacementNamed(context, "/auth");
      });
    } else {
      if (count == null) {
        preferences.setInt('count', 0);
        Future.delayed(Duration(seconds: 1)).then((value) {
          Navigator.pushReplacementNamed(context, "/feedLanding");
        });
      } else {
        preferences.setInt('count', count + 1);
        Future.delayed(Duration(seconds: 1)).then((value) {
          Navigator.pushReplacementNamed(context, "/feedLanding");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => LandingPage()));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.1),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/tollgate.png"),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.shortestSide * 0.06),
                  child: Container(
                    child: Text(
                      'TollGate App',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Colors.black,
                          letterSpacing: .4,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  initState() {
    super.initState();
    setVisitingFlag(context);
  }

  setVisitingFlag(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString("userId");
    int count = preferences.getInt('count');
    print("********* $count");
    if (id == null) {
      Future.delayed(Duration(seconds: 1)).then((value) {
        Navigator.pushReplacementNamed(context, "/login");
      });
    } else {
      if (count == null) {
        preferences.setInt('count', 0);
        Future.delayed(Duration(seconds: 1)).then((value) {
          Navigator.pushReplacementNamed(context, "/travelentrypage");
        });
      } else {
        preferences.setInt('count', count + 1);
        Future.delayed(Duration(seconds: 1)).then((value) {
          Navigator.pushReplacementNamed(context, "/travelentrypage");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white
//        gradient: LinearGradient(
//          begin: Alignment.topLeft,
//          colors: [
//            Color(0xBBFB9426),
//            Color(0xBBF80D7C),
//          ],
//        ),
            ),
        child: Center(
          // child: FlutterLogo(
          //   size: 100,
          // ),

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.shortestSide * 0.1),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/images/tollgate.png"),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.shortestSide * 0.06),
                    child: Container(
                      child: Text(
                        'TollGate App',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black,
                            letterSpacing: .4,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
