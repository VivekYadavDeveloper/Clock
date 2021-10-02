import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer/clock_design.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // get menuItems => null;

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat("H:m").format(now);
    var formattedDate = DateFormat("EE-dd-MM-yyyy").format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = "";
    if (!timezoneString.startsWith("-")) offsetSign = "+";
    print(timezoneString);

    return Scaffold(
      backgroundColor: Color(0xff14274E),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          "Clock",
                          style: GoogleFonts.mavenPro(
                              color: Colors.white, fontSize: 24),
                        ),
                      ),

                      //For Digital Clock Timing.
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              formattedTime,
                              style: GoogleFonts.mavenPro(
                                  color: Colors.white, fontSize: 50),
                            ),
                            Text(
                              formattedDate,
                              style: GoogleFonts.mavenPro(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),

                      // Clock Page.
                      Flexible(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.center,
                          child: ClockDesign(
                            size: 225,
                          ),
                        ),
                      ),

                      // Time Zone
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Timezone",
                              style: GoogleFonts.mavenPro(
                                  color: Colors.white, fontSize: 24),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.language_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 16),
                                Text(
                                  "UTC" + offsetSign + timezoneString,
                                  style: GoogleFonts.mavenPro(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
