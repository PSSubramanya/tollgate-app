import 'dart:async';
// import 'networking.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:geolocator/geolocator.dart';

import 'package:tollgate_app/socket.dart';
// import 'package:firebase_database/firebase_database.dart';

import 'model/userData.dart';
// import 'package:grouped_checkbox/grouped_checkbox.dart';

class CheckPage extends StatefulWidget {
  @override
  State createState() => new CheckPageState();
}

class CheckPageState extends State<CheckPage> {
  List<UserData> userDataList = [];

  // var location = new Location();

  // // Map<String, double> userLocation;
  // Map<String, double> currentLocation;

  /*
  //typ11
  Geolocator geolocator = Geolocator();

  Position userLocation;*/

  // String _locationMessage = "";
  // // LatLng _center;
  Position _currentPosition;
  String _currentAddress;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  // Position currentLocation;

  _getCurrentLocation() {
    // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    // final Geolocator geolocator = Geolocator();
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  //from here.............
  userFetch() async {
    final FirebaseDatabase database = FirebaseDatabase.instance;
    final auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      uid = user.uid;
    });
    // DatabaseReference userdetailref =
    //     // FirebaseDatabase.instance.reference().child("${user.uid}").child("userinfo");
    //     FirebaseDatabase.instance.reference().child("${user.uid}");
    //     return userdetailref;
    // print(userdetailref.path);
    // try {
    //   var snap = (await userdetailref.once()).value;
    //   print("*********** ${snap}");
    //   print("hello");
    //   // var KEYS = snap.value.keys;
    //   // var DATA = snap.value;

    //   // userDataList.clear();

    //   // for (var individualKey in KEYS) {
    //   //   UserData userDatas = new UserData(
    //   //     // amount,
    //   //     // DATA[individualKey]['amount'],
    //   //     DATA[individualKey]['name'],
    //   //     // DATA[individualKey]['phoneNumber'],
    //   //     // DATA[individualKey]['vehicleNumber'],
    //   //     // DATA[individualKey]['vehicleType'],
    //   //   );

    //   //   userDataList.add(userDatas);
    //   // }

    //   // // setState(() {
    //   // print('Length : $userDataList.length');
    //   // print(userDataList);
    // } catch (e) {
    //   print("***************************** error $e");
    // }
    // print();
    // });

    // return userDataList;
  }
  //till here..........

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUserLocation();
    // _getCurrentLocation();
    _getCurrentLocation();
    startTime();
    userFetch();
    // userFetch();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: initScreen(context),
  //   );
  // }

  // void initPlatformState() {

  // }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, null);
  }

  int count = 0;
  int count2 = 0;
  var result = "";
  TextEditingController _paymentTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  // String url = "http://192.168.137.1:5000";
  // String url = "";
  var parseddata;
  String content;
  String uid;

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
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.shortestSide * 0.04),
                  child: Container(),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15.0,
                      top: MediaQuery.of(context).size.shortestSide * 0.15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/travelentrypage');
                    },
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Icon(
                              Icons.chevron_left,
                              size: 18.0,
                            ),
                          ),
                          Text(
                            'BACK',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.black,
                                letterSpacing: .4,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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
                      'WELCOME',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: Colors.white,
                          letterSpacing: .4,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
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
                      'Payment page',
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
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.08,
                    bottom: MediaQuery.of(context).size.shortestSide * 0.1),
                child: Container(
                    width: 200.0,
                    child: Text(
                      // "Statebank, Mangalore",

                      //   "Location:" +
                      // userLocation["latitude"].toString() +
                      // " " +
                      // userLocation["longitude"].toString(),

                      // "Location:" + currentLocation["latitude"].toString() + " " + currentLocation["longitude"].toString(),

                      // "Tollgate at\nLAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}",
                      "Tollgate\n\n" + _currentAddress,

                      // "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}",
                      // _locationMessage,
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
                  top: MediaQuery.of(context).size.shortestSide * 0.02,
                ),
                child: SizedBox(
                  height: 40.0,
                  width: 200.0,
                  child: FlatButton(
                      color: Colors.white,
                      onPressed: () async {
                        // _onClear();
                        String url = "http://192.168.137.1:5000/check";
                        result = await NetworkHelper(url).getData();
                        _paymentTextController.text = result;
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.white)),
                      child: Text(
                        'Payment',
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
                    bottom: MediaQuery.of(context).size.height * 0.6),
                // bottom: MediaQuery.of(context).size.shortestSide * 0.05),
                child: Container(
                    width: 250.0,
                    height: 60.0,
                    child: TextFormField(
                      //here you have to fetch and display from flask
                      // "Rs. 400 paid",
                      controller: _paymentTextController,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        // hintText: sLabel
                      ),
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

/*6th June 2020
//Image processed number plate store
//vehicle type remove hardcode
//flutter geo location if possible
//firebase fetch username
*/
