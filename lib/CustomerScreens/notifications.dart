import 'package:flutter/material.dart';
import 'package:handyman/CustomerScreens/CustomerSubscreens/workerportfolio.dart';
import 'package:handyman/services/authservice.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notificationscreen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var jobAcceptNotificationData, workerDetails = [];
  var emailList = [];
  @override
  void getCustomerNotificationsForJobAccept() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    var email = payload['email'];

    await AuthService().getCustomerNotificationsForJobAccept(email).then((val) {
      jobAcceptNotificationData = val.data["responses"];
    });
    for (var i in jobAcceptNotificationData) {
      if (!i['responses'].isEmpty) {
        emailList += i['responses'];
      }
    }
    for (var i in emailList) {
      await AuthService().getInfo(i).then((val) {
        if (val.data['success']) {
          workerDetails.add(val.data["user"]);
        }
      });
    }

    setState(() {});
  }

  void initState() {
    super.initState();
    getCustomerNotificationsForJobAccept();
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Widget notificationCard(
        BuildContext context,
        String text,
        Color color,
        String desc,
        String workerName,
        String workerDistrict,
        String workerPropic) {
      return GestureDetector(
        onTap: () {
          List data = [workerName, workerDistrict, workerPropic];
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => WorkerPortfolio(),
              settings: RouteSettings(arguments: data)));
        },
        child: Container(
          height: 70,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black38,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color,
                  ),
                  child: Center(
                    child: Icon(Icons.notifications),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 10),
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      desc,
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Handyman',
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'AlfaSlabOne',
              color: Theme.of(context).buttonColor),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.chat_bubble), onPressed: () {}),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    'Notification',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 40),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            for (var i in workerDetails)
              notificationCard(
                context,
                'Job accepted',
                Colors.amber,
                i['fName'] + ' ' + i['lName'] + ' accepted your job request.',
                i['fName'] + ' ' + i['lName'],
                i['district'],
                i['profilePic'],
              ),
          ],
        ),
      ),
    );
  }
}
