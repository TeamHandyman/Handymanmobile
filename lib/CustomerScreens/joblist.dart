import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handyman/CustomerScreens/CustomerSubscreens/confirmedjobsscreen.dart';
import 'package:handyman/CustomerScreens/CustomerSubscreens/quotation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../services/authservice.dart';

class JoblistScreen extends StatefulWidget {
  static const routeName = '/joblistscreen';

  @override
  State<JoblistScreen> createState() => _JoblistScreenState();
}

class _JoblistScreenState extends State<JoblistScreen>
    with TickerProviderStateMixin {
  var _confirmed = false;
  @override
  List<dynamic> ads = [];
  List<dynamic> confirmedQs = [];
  List<dynamic> completedQs = [];
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  void getRecievedQuotations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    var email = payload['email'];
    await AuthService().getRecievedQuotations(email).then((val) {
      ads = val.data["u"];
    });

    setState(() {});
  }

  void getConfirmedQuotations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    var email = payload['email'];
    await AuthService().getConfirmedQuotations(email).then((val) {
      confirmedQs = val.data["u"];
    });

    setState(() {});
  }

  void getCompletedQuotations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    var email = payload['email'];
    await AuthService().getCompletedQuotations(email).then((val) {
      completedQs = val.data["u"];
    });

    setState(() {});
  }

  void initState() {
    super.initState();
    getRecievedQuotations();
    getConfirmedQuotations();
    getCompletedQuotations();
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    void confirmJob(jobId, index) async {
      await AuthService().confirmJob(jobId);

      Fluttertoast.showToast(
          msg: "Quotation Confirmed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).buttonColor,
          textColor: Colors.black,
          fontSize: 16.0);

      setState(() {
        ads.removeAt(index);
      });
    }

    Widget progress(BuildContext context, String status, Color color) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            status,
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Icon(
            Icons.check,
            color: color,
            size: 20,
          )
        ],
      );
    }

    Widget bothParties(BuildContext context, String name, Color color) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(
              Icons.person,
              size: 15,
              color: color,
            ),
          ),
          Text(
            name,
            style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.normal,
                fontSize: 14),
          ),
        ],
      );
    }

    Widget jobCard(
        BuildContext context,
        String status,
        Color progressColor,
        String jobTitle,
        String workerName,
        String estDate,
        String revMethod,
        String confirmedDate,
        String desc,
        String estTotal,
        String hourlyRate,
        String imgUrl,
        String jobId,
        String jobStatus,
        String workerEmail) {
      DateTime estDateD = DateTime.parse(estDate);
      DateTime confirmedDateD = DateTime.parse(confirmedDate);
      return GestureDetector(
        onTap: () {
          if (jobStatus != "completed") {
            List data = [
              jobTitle,
              confirmedDate,
              estDate,
              revMethod,
              desc,
              estTotal,
              hourlyRate,
              imgUrl,
              jobId,
              workerEmail
            ];
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ConfirmedJobsScreen(),
                settings: RouteSettings(arguments: data)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            height: 200,
            width: width,
            decoration: BoxDecoration(
              color: Theme.of(context).shadowColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 15, bottom: 15),
                  child: Text(
                    jobTitle,
                    style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // bothParties(context, 'Nuwan Perera', Colors.amber),
                      bothParties(context, workerName,
                          Theme.of(context).backgroundColor),
                    ],
                  ),
                ),
                progress(context, status, progressColor),
                Divider(
                  thickness: 5,
                  color: progressColor,
                  indent: 25,
                  endIndent: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Text(
                        'Date started: ' + formatter.format(confirmedDateD),
                        style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Text(
                        'Date completed: ' + formatter.format(estDateD),
                        style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Method: ' + revMethod,
                    style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget pendingjobCard(
        BuildContext context,
        // String status,
        // Color progressColor,
        String jobTitle,
        String workerName,
        String estDate,
        String estTotal,
        String hourlyRate,
        String revMethod,
        String imgUrl,
        String desc,
        String jobId,
        int index) {
      return GestureDetector(
        onTap: () => null,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            height: 200,
            width: width,
            decoration: BoxDecoration(
              color: Theme.of(context).shadowColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 15, bottom: 15),
                  child: Text(
                    jobTitle,
                    style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // bothParties(context, 'Nuwan Perera', Colors.amber),
                      Text(
                        workerName + ' sent you a quotation',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.keyboard_return_rounded,
                      size: 20,
                      color: Colors.black,
                    ),
                    GestureDetector(
                      onTap: () {
                        List data = [
                          jobTitle,
                          desc,
                          estDate,
                          estTotal,
                          hourlyRate,
                          imgUrl,
                          revMethod,
                          jobId
                        ];

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => quotationScreen(),
                            settings: RouteSettings(arguments: data)));
                      },
                      child: Text(
                        'View quotation',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 46,
                        width: width * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          // color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            confirmJob(jobId, index);
                          },
                          child: Center(
                            child: Text(
                              'Confirm Job',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.clear,
                          size: 15,
                          color: Colors.black,
                        ),
                        Text(
                          'Decline',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    TabController _tabController = TabController(length: 4, vsync: this);

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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 0, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Job Schedule',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 40),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.0, bottom: 0, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      'All the confirmed jobs are displayed in here',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 15),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 60,
              child: TabBar(
                controller: _tabController,
                labelColor: Theme.of(context).buttonColor,
                unselectedLabelColor: Theme.of(context).shadowColor,
                indicatorColor: Theme.of(context).buttonColor,
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Pending'),
                  Tab(text: 'Ongoing'),
                  Tab(text: 'Completed'),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              height: height,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          //scrollDirection: Axis.vertical,
                          children: [
                            for (var i = 0; i < confirmedQs.length; i++)
                              jobCard(
                                context,
                                'Started',
                                Colors.amber[900],
                                confirmedQs[i]['jobTitle'],
                                confirmedQs[i]['workerName'],
                                confirmedQs[i]['estimatedDate'],
                                confirmedQs[i]['revenueMethod'],
                                confirmedQs[i]['confirmedDate'],
                                confirmedQs[i]['description'],
                                confirmedQs[i]['estimatedTotal'].toString(),
                                confirmedQs[i]['hourlyRate'].toString(),
                                confirmedQs[i]['imgUrl'],
                                confirmedQs[i]['jobId'],
                                confirmedQs[i]['status'],
                                confirmedQs[i]['worker'],
                              ),
                            for (var i = 0; i < completedQs.length; i++)
                              jobCard(
                                context,
                                'Completed',
                                Colors.green,
                                completedQs[i]['jobTitle'],
                                completedQs[i]['workerName'],
                                completedQs[i]['estimatedDate'],
                                completedQs[i]['revenueMethod'],
                                completedQs[i]['confirmedDate'],
                                completedQs[i]['description'],
                                completedQs[i]['estimatedTotal'].toString(),
                                completedQs[i]['hourlyRate'].toString(),
                                completedQs[i]['imgUrl'],
                                completedQs[i]['jobId'],
                                completedQs[i]['status'],
                                completedQs[i]['worker'],
                              ),
                            for (var i = 0; i < ads.length; i++)
                              jobCard(
                                context,
                                'Started',
                                Colors.amber[900],
                                ads[i]['jobTitle'],
                                ads[i]['workerName'],
                                ads[i]['estimatedDate'],
                                ads[i]['revenueMethod'],
                                ads[i]['confirmedDate'],
                                ads[i]['description'],
                                ads[i]['estimatedTotal'].toString(),
                                ads[i]['hourlyRate'].toString(),
                                ads[i]['imgUrl'],
                                ads[i]['jobId'],
                                ads[i]['status'],
                                ads[i]['worker'],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          children: [
                            for (var i = 0; i < ads.length; i++)
                              pendingjobCard(
                                  context,
                                  ads[i]['jobTitle'],
                                  ads[i]['workerName'],
                                  ads[i]['estimatedDate'],
                                  ads[i]['estimatedTotal'].toString(),
                                  ads[i]['hourlyRate'].toString(),
                                  ads[i]['revenueMethod'],
                                  ads[i]['imgUrl'],
                                  ads[i]['description'],
                                  ads[i]['jobId'],
                                  i),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          children: [
                            // jobCard(context, 'On going', Colors.amber[900])
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          children: [
                            // jobCard(context, 'Completed', Colors.green[600])
                            for (var i = 0; i < completedQs.length; i++)
                              jobCard(
                                context,
                                'Completed',
                                Colors.green,
                                completedQs[i]['jobTitle'],
                                completedQs[i]['workerName'],
                                completedQs[i]['estimatedDate'],
                                completedQs[i]['revenueMethod'],
                                completedQs[i]['confirmedDate'],
                                completedQs[i]['description'],
                                completedQs[i]['estimatedTotal'].toString(),
                                completedQs[i]['hourlyRate'].toString(),
                                completedQs[i]['imgUrl'],
                                completedQs[i]['jobId'],
                                completedQs[i]['status'],
                                completedQs[i]['worker'],
                              ),
                          ],
                        ),
                      ),
                    ),
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
