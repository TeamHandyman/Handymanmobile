import 'package:flutter/material.dart';
// import 'package:handyman/Screens/home.dart';
// import 'package:handyman/Screens/navigation.dart';

class Goodjobscreen extends StatefulWidget {
  static const routeName = '/goodjob';
  @override
  State<Goodjobscreen> createState() => _GoodjobscreenState();
}

class _GoodjobscreenState extends State<Goodjobscreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
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
                    'Good job',
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
                    'Thank you for signing upfor Handyman. To give you a personalized experience we would like to get more details from you.',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            width: width,
                            child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color:
                                                Theme.of(context).buttonColor,
                                          ),
                                          labelText: 'Name',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .shadowColor),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.accessibility_new_rounded,
                                            color:
                                                Theme.of(context).buttonColor,
                                          ),
                                          labelText: 'Gender',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .shadowColor),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color:
                                                Theme.of(context).buttonColor,
                                          ),
                                          labelText: 'Date of birth',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .shadowColor),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock_open_sharp,
                                            color:
                                                Theme.of(context).buttonColor,
                                          ),
                                          labelText: 'District',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .shadowColor),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                  ],
                                ))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            bottom: 10,
                            left: 15,
                            right: 15,
                          ),
                          child: GestureDetector(
                            // onTap: () => Navigator.of(context)
                            //     .pushNamed(Homescreen.routeName),
                            child: Container(
                              height: 46,
                              width: width,
                              decoration: BoxDecoration(
                                color: Theme.of(context).buttonColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text('Let\'s Go',
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Need help signing up',
                              style: TextStyle(
                                // fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: GestureDetector(
                                onTap: () => null,
                                child: Text(
                                  'Contact Us',
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
