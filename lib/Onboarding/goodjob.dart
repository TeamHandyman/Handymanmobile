import 'package:flutter/material.dart';
import 'package:handyman/CustomerScreens/home.dart';
import 'package:handyman/CustomerScreens/navigation.dart';

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
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 15, bottom: 30),
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
              padding: EdgeInsets.only(top: 10.0, bottom: 0, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Good job',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).buttonColor,
                        fontSize: 40),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
              child: Text(
                'Thank you for signing up for Handyman. To give you a personalised experience we would like to know more about you',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 50,
                    ),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 5, bottom: 5),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).buttonColor,
                              ),
                              labelText: 'Name',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).shadowColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 5, bottom: 5),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.accessibility_new_rounded,
                                color: Theme.of(context).buttonColor,
                              ),
                              labelText: 'Gender',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).shadowColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 5, bottom: 5),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.cake,
                                color: Theme.of(context).buttonColor,
                              ),
                              labelText: 'Date of birth',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).shadowColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 5, bottom: 5),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Theme.of(context).buttonColor,
                              ),
                              labelText: 'District',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).shadowColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ))),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(Navigationscreen.routeName),
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
                                color: Theme.of(context).backgroundColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
