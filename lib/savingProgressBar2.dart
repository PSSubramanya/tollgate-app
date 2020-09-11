import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tollgate_app/login.dart';
import 'dart:async';

// import 'package:tollgate_app/payment_page.dart';
import 'package:tollgate_app/travelEntryPage.dart';

import 'landingPage.dart';

class SavingProgreesPage2 extends StatefulWidget {
  @override
  State createState() => new SaveState2();
  // State<StatefulWidget> createState() {
  //   return HomeDisplayState();
}

class SaveState2 extends State<SavingProgreesPage2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
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
                      'Saving Travel Info',
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

// class HomeDisplayState extends State<HomeDisplay> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.shortestSide * 0.1),
//             child: CircleAvatar(
//               radius: 50.0,
//               backgroundImage: AssetImage("assets/images/diabetesicon.png"),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Padding(
//               padding: EdgeInsets.only(
//                   top: MediaQuery.of(context).size.shortestSide * 0.06),
//               child: Container(
//                 child: Text(
//                   'Diabetes classifier',
//                   style: GoogleFonts.lato(
//                     textStyle: TextStyle(
//                       color: Colors.black,
//                       letterSpacing: .4,
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
