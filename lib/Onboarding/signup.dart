import 'package:flutter/material.dart';
import 'package:handyman/Onboarding/login.dart';
import 'package:handyman/Onboarding/verification.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                    'Sign Up',
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
                'Join Handyman today, Let\'s create an account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                              labelText: 'Customer',
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
                                Icons.phone_android,
                                color: Theme.of(context).buttonColor,
                              ),
                              labelText: 'Phone',
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
                                Icons.email,
                                color: Theme.of(context).buttonColor,
                              ),
                              labelText: 'Email',
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
                                Icons.lock_open_sharp,
                                color: Theme.of(context).buttonColor,
                              ),
                              labelText: 'Password',
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 5, bottom: 5),
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_sharp,
                                color: Theme.of(context).buttonColor,
                              ),
                              labelText: 'Confirm Password',
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
                    onTap: () =>
                        Navigator.of(context).pushNamed(Verifyscreen.routeName),
                    child: Container(
                      height: 46,
                      width: width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).buttonColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text('Sign up',
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor,
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
                      'Already have an account?',
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
                        onTap: () => Navigator.of(context)
                            .pushNamed(LoginScreen.routeName),
                        child: Text(
                          'Login',
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
    );
  }
}
