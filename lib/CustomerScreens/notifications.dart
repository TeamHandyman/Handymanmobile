import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notificationscreen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
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
            Container(
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
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 10),
                        child: Text(
                          'Notification',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 5),
                        child: Text(
                          'This is a sample notification',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
