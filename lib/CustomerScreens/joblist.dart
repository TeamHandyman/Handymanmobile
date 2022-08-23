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

    Widget jobCard(BuildContext context, String status, Color progressColor) {
      return Padding(
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
                  'Mechanic job | Nugegoda | Nuwan',
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
                    bothParties(context, 'Namal Rajapakse',
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
                      'Date started: Jun 15',
                      style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Text(
                      'Date completed: Jun 20',
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
                  'Method: Contract basis',
                  style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      );
    }

    TabController _tabController = TabController(length: 3, vsync: this);

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
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            jobCard(context, 'Completed', Colors.green[600]),
                            jobCard(context, 'Started', Colors.amber[900]),
                            jobCard(context, 'On going', Colors.purple[600]),
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
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            jobCard(context, 'On going', Colors.amber[900])
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
                        child: ListView(
                          children: [
                            jobCard(context, 'Completed', Colors.green[600])
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
