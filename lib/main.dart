import 'package:flutter/material.dart';
import 'package:handyman/Onboarding/goodjob.dart';
import 'package:handyman/Onboarding/login.dart';
import 'package:handyman/Onboarding/signup.dart';
import 'package:handyman/Onboarding/verification.dart';
import 'package:handyman/CustomerScreens/PostJob.dart';
import 'package:handyman/CustomerScreens/notifications.dart';
import 'package:handyman/CustomerScreens/home.dart';
import 'package:handyman/CustomerScreens/joblist.dart';
import 'package:handyman/CustomerScreens/navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String name;
    return MaterialApp(
      title: 'Handyman',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(44, 18, 75, 1),
          backgroundColor: Color.fromRGBO(30, 30, 30, 1),
          buttonColor: Color.fromRGBO(224, 186, 8, 1),
          shadowColor: Color.fromRGBO(217, 217, 217, 1)),
      routes: {
        '/': (ctx) => LoginScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        Verifyscreen.routeName: (ctx) => Verifyscreen(),
        Goodjobscreen.routeName: (ctx) => Goodjobscreen(),
        Navigationscreen.routeName: (ctx) => Navigationscreen(),
        Homescreen.routeName: (ctx) => Homescreen(name),
        JoblistScreen.routeName: (ctx) => JoblistScreen(),
        PostjobScreen.routeName: (ctx) => PostjobScreen(),
        NotificationScreen.routeName: (ctx) => NotificationScreen()
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
  
// }
