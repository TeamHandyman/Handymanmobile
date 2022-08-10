import 'package:flutter/material.dart';

class JoblistScreen extends StatefulWidget {
  static const routeName = '/joblistscreen';

  @override
  State<JoblistScreen> createState() => _JoblistScreenState();
}

class _JoblistScreenState extends State<JoblistScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                    'Schedule',
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
                labelColor: Colors.white,
                unselectedLabelColor: Theme.of(context).shadowColor,
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Ongoing'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Pending'),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              height: height,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Text(
                    'Test 1',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Test 2',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Test 3',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Test 4',
                    style: TextStyle(color: Colors.white),
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
