import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handyman/Onboarding/goodjob.dart';
import 'package:handyman/Onboarding/login.dart';
import 'package:handyman/Onboarding/verification.dart';
import 'package:handyman/services/authservice.dart';
import 'package:progress_indicator_button/button_stagger_animation.dart';
import 'package:progress_indicator_button/progress_button.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var email, phone, password, confPassword;
  bool emailValid;
  bool pwdTapped = false;
  bool emailAvailable = false;
  bool phoneAvailable = false;
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  void httpJob(AnimationController controller) async {
    controller.forward();
    await AuthService().checkEmailAvailability(email).then((val) {
      setState(() {
        loading = true;
      });
      if (val.data['success']) {
        emailAvailable = true;
      }
    });
    await AuthService().checkPhoneAvailability(phone).then((val) {
      if (val.data['success']) {
        phoneAvailable = true;
      }
    });
    controller.reset();
  }

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
                            keyboardType: TextInputType.phone,
                            onChanged: (val) {
                              phone = val;
                            },
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
                            onChanged: (val) {
                              email = val;
                              emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email);
                            },
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
                            onChanged: (val) {
                              password = val;
                            },
                            onTap: () {
                              pwdTapped = true;
                            },
                          ),
                        ),
                        Visibility(
                          child: Text(
                            'Passwords must be at least 8 characters long and include numbers and symbols',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          visible: pwdTapped,
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
                            onChanged: (val) {
                              confPassword = val;
                            },
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
                    // onTap: () {
                    //   print('object');
                    //   // AuthService().checkEmailAvailability(email).then((val) {
                    //   //   setState(() {
                    //   //     loading = true;
                    //   //   });
                    //   //   if (val.data['success']) {
                    //   //     emailAvailable = true;
                    //   //   }
                    //   //   AuthService().checkPhoneAvailability(phone).then((val) {
                    //   //     if (val.data['success']) {
                    //   //       phoneAvailable = true;
                    //   //     }
                    //   //   });
                    //   //   setState(() {
                    //   //     loading = false;
                    //   //   });
                    //   // });
                    //   // if (loading) return loadingWidget(context);

                    //   //  else {

                    //   // AuthService()
                    //   //     .addUserCustomer(fName, lName, phone, email, password)
                    //   //     .then((val) {
                    //   //   // Navigator.of(context)
                    //   //   //     .pushNamed(Goodjobscreen.routeName);
                    //   //   Navigator.of(context).push(MaterialPageRoute(
                    //   //       builder: (context) => Goodjobscreen(),
                    //   //       settings: RouteSettings(arguments: data)));
                    //   //   Fluttertoast.showToast(
                    //   //       msg: 'Successfully Registered',
                    //   //       toastLength: Toast.LENGTH_SHORT,
                    //   //       gravity: ToastGravity.BOTTOM,
                    //   //       timeInSecForIosWeb: 1,
                    //   //       backgroundColor: Theme.of(context).buttonColor,
                    //   //       textColor: Theme.of(context).shadowColor,
                    //   //       fontSize: 16.0);
                    //   // });

                    //   // }
                    // },
                    child: Container(
                      height: 46,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ProgressButton(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Text('Sign up',
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                          onPressed: (AnimationController controller) async {
                            await httpJob(controller);
                            if (phone == null ||
                                email == null ||
                                password == null ||
                                confPassword == null) {
                              Fluttertoast.showToast(
                                  msg: 'Please enter the required fields',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (!emailValid) {
                              Fluttertoast.showToast(
                                  msg: 'Invalid Email',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (password != confPassword) {
                              Fluttertoast.showToast(
                                  msg: 'Passwords do not match',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (!RegExp(
                                    r"^(?=.*[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}")
                                .hasMatch(password)) {
                              Fluttertoast.showToast(
                                  msg: 'Enter a valid password',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (phone.length != 10) {
                              Fluttertoast.showToast(
                                  msg: 'Invalid Phone No.',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (!emailAvailable) {
                              Fluttertoast.showToast(
                                  msg: 'This e-mail has already registered',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (!phoneAvailable) {
                              Fluttertoast.showToast(
                                  msg: 'This phone no. has already registered',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              List data = [phone, email, password];
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Goodjobscreen(),
                                  settings: RouteSettings(arguments: data)));
                            }
                          }),
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
