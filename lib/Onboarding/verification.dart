import 'package:flutter/material.dart';
import 'package:handyman/Onboarding/goodjob.dart';

class Verifyscreen extends StatefulWidget {
  static const routeName = '/verify';
  @override
  State<Verifyscreen> createState() => _verifyscreenState();
}

class _verifyscreenState extends State<Verifyscreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 15, bottom: 30),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.0, bottom: 0, left: 15.0),
                  child: Text(
                    'Verification',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).buttonColor,
                        fontSize: 40),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 25),
                  child: Text(
                    'We have sent a verification code to gxxxxxxkl@gmail.com. Please enter the verification code to continue',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    width: width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(8),
                              height: 100,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(8),
                              height: 100,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(8),
                              height: 100,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(8),
                              height: 100,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    bottom: 10,
                    left: 30,
                    right: 30,
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(Goodjobscreen.routeName),
                    child: Container(
                      height: 46,
                      width: width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).buttonColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text('Continue',
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Didn\'t receive verifivation code?',
                          style: TextStyle(
                            // fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: GestureDetector(
                            onTap: () => null,
                            child: Text(
                              'Resend',
                              style: TextStyle(
                                // fontWeight: FontWeight.w500,
                                color: Theme.of(context).buttonColor,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
