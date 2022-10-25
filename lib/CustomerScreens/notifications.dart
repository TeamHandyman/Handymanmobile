import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:handyman/CustomerScreens/CustomerSubscreens/quotationbtn.dart';
import 'package:handyman/CustomerScreens/CustomerSubscreens/workerportfolio.dart';
import 'package:handyman/services/authservice.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notificationscreen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class notification {
  String text;
  Color color;
  String desc;
  String jobTitle;
  String workerEmail;
  String workerName;
  String workerDistrict;
  String workerPropic;
  String oneSignalId;
  String jobId;
  String quoteDesc;
  String estDate;
  String estTotal;
  String hourlyRate;
  String imgUrl;
  String revMethod;
  int jobCount;
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading1 = true;
  bool isLoading2 = true;
  var jobAcceptNotificationData, quotationNotificationData;
  var emailList = [];
  var jobTitleList = [];
  List<notification> notifications = [];
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
        for (var j in i['responses']) {
          var noti = notification();
          await AuthService().getInfo(j).then((val) {
            isLoading1 = false;
            if (val.data['success']) {
              var workerDetails = val.data["user"];
              noti.text = 'Job Accepted';
              noti.color = Colors.amber;
              noti.desc = workerDetails['fName'] +
                  ' ' +
                  workerDetails['lName'] +
                  ' accepted your job request';
              noti.oneSignalId = workerDetails['oneSignalID'];
              noti.workerDistrict = workerDetails['district'];
              noti.workerEmail = workerDetails['email'];
              noti.workerName =
                  workerDetails['fName'] + ' ' + workerDetails['lName'];
              noti.workerPropic = workerDetails['profilePic'];
              noti.jobTitle = i['workerType'] +
                  ' | ' +
                  noti.workerName +
                  ' | ' +
                  i['district'];
              noti.jobId = i['_id'];
              noti.jobCount = workerDetails['jobCount'];
            }
          });
          notifications.add(noti);
        }
      }
    }
    setState(() {});
  }

  void getCustomerNotificationsForQuotations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    var email = payload['email'];

    await AuthService()
        .getCustomerNotificationsForQuotations(email)
        .then((val) {
      isLoading2 = false;
      quotationNotificationData = val.data["responses"];
    });
    for (var i in quotationNotificationData) {
      var noti = notification();
      noti.color = Colors.amber;
      noti.desc = "You have recieved a quotation from " + i["workerName"];
      noti.jobId = i['jobId'];
      noti.jobTitle = i['jobTitle'];
      noti.text = "Quotation Recieved";
      noti.quoteDesc = i['description'];
      noti.estDate = i['estimatedDate'];
      noti.estTotal = i['estimatedTotal'].toString();
      noti.hourlyRate = i['hourlyRate'].toString();
      noti.imgUrl = i['imgUrl'];
      noti.revMethod = i['revenueMethod'];
      noti.jobCount = i['jobCount'];
      notifications.add(noti);
    }
    // for (var i in jobAcceptNotificationData) {
    //   if (!i['responses'].isEmpty) {
    //     for (var j in i['responses']) {
    //       var notification = notification();
    //       await AuthService().getInfo(j).then((val) {
    //         if (val.data['success']) {
    //           var workerDetails = val.data["user"];
    //           notification.desc = workerDetails['fName'] +
    //               ' ' +
    //               workerDetails['lName'] +
    //               ' accepted your job request';
    //           notification.oneSignalId = workerDetails['oneSignalID'];
    //           notification.workerDistrict = workerDetails['district'];
    //           notification.workerEmail = workerDetails['email'];
    //           notification.workerName =
    //               workerDetails['fName'] + ' ' + workerDetails['lName'];
    //           notification.workerPropic = workerDetails['profilePic'];
    //           notification.jobTitle = i['workerType'] +
    //               ' | ' +
    //               notification.workerName +
    //               ' | ' +
    //               i['district'];
    //           notification.jobId = i['_id'];
    //         }
    //       });
    //       jobAccNotifications.add(notification);
    //     }
    //   }
    // }
    setState(() {});
  }

  void initState() {
    super.initState();
    getCustomerNotificationsForJobAccept();
    getCustomerNotificationsForQuotations();
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget notificationCard(
      BuildContext context,
      notification notification,
    ) {
      return GestureDetector(
        onTap: () {
          if (notification.text == "Job Accepted") {
            List dataForWorkerPortfolio = [
              notification.workerName,
              notification.workerDistrict,
              notification.workerPropic,
              notification.oneSignalId,
              notification.workerEmail,
              notification.jobTitle,
              notification.jobId,
              notification.jobCount
            ];

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WorkerPortfolio(),
                settings: RouteSettings(arguments: dataForWorkerPortfolio)));
          } else {
            List dataForQuotation = [
              notification.jobTitle,
              notification.quoteDesc,
              notification.estDate,
              notification.estTotal,
              notification.hourlyRate,
              notification.imgUrl,
              notification.revMethod,
              notification.jobId
            ];

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => quotationBtnScreen(),
                settings: RouteSettings(arguments: dataForQuotation)));
          }
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
                    color: notification.color,
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
                      notification.text,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 5, top: 3),
                  //   child: Text(
                  //     jobTitle,
                  //     style: TextStyle(color: Colors.white54),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 3),
                    child: Text(
                      notification.desc,
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
            isLoading1 | isLoading2
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).buttonColor,
                    ),
                  )
                : Center(),
            for (var i in notifications) notificationCard(context, i),
            // Text("Quotations"),
            // for (var i in quotationNotificationData)
            //   notificationCard(context, i),
          ],
        ),
      ),
    );
  }
}
