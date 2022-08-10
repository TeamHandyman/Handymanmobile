import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  static const routeName = '/homescreen';

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
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
            Padding(
              padding: EdgeInsets.only(top: 3.0, bottom: 0, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Hello there',
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
                      'Welcome to Handyman now you can search for workers, jobs and more',
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).shadowColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 50,
                width: width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Text(
                          'Search',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Filter',
                    style: TextStyle(
                        color: Theme.of(context).shadowColor, fontSize: 15),
                  ),
                ),
                Icon(
                  Icons.account_tree_outlined,
                  color: Theme.of(context).shadowColor,
                  size: 15,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                color: Theme.of(context).shadowColor,
                child: Container(
                  height: 200,
                  width: width,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                color: Theme.of(context).shadowColor,
                child: Container(
                  height: 200,
                  width: width,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                color: Theme.of(context).shadowColor,
                child: Container(
                  height: 200,
                  width: width,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                color: Theme.of(context).shadowColor,
                child: Container(
                  height: 200,
                  width: width,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
