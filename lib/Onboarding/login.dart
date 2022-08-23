import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handyman/CustomerScreens/home.dart';
import 'package:handyman/CustomerScreens/navigation.dart';
import 'package:handyman/Onboarding/signup.dart';
import 'package:handyman/services/authservice.dart';
import 'package:progress_indicator_button/progress_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginscreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email, password, token;
  bool credentialsCorrect = false;
  @override
  Widget build(BuildContext context) {
    void httpJob(AnimationController controller) async {
      controller.forward();

      await AuthService().loginCustomer(email, password).then((val) {
        if (val.data['success']) {
          token = val.data['token'];
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Navigationscreen()));
        } else {
          Fluttertoast.showToast(
              msg: 'Incorrect Credentials!',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return;
        }
      });
      controller.reset();
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height * 0.5,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/HandymanMobile.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
              child: Text(
                'Best platform to connect with your desired workers',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15, top: 7, bottom: 10),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Theme.of(context).buttonColor,
                  ),
                  labelText: 'E-Mail',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).shadowColor),
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
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 7, right: 15),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Theme.of(context).buttonColor,
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).shadowColor),
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
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Theme.of(context).buttonColor, fontSize: 14),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 3, left: 15, right: 15, bottom: 10),
              child: GestureDetector(
                child: Container(
                  height: 46,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ProgressButton(
                      color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Text('Login',
                          style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      onPressed: (AnimationController controller) async {
                        if (email == "" || password == "") {
                          Fluttertoast.showToast(
                              msg: 'Please enter the required fields',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          await httpJob(controller);
                        }
                      }),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account?',
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
                              .pushNamed(SignupScreen.routeName),
                          child: Text(
                            'Sign up',
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
