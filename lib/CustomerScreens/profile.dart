import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 40),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/profile1.jpg'),
                    radius: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      'Hey I am Kasuni Silva\n from Dehiwala',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        'Rating',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Theme.of(context).buttonColor,
                          ),
                          Icon(
                            Icons.star,
                            color: Theme.of(context).buttonColor,
                          ),
                          Icon(
                            Icons.star,
                            color: Theme.of(context).buttonColor,
                          ),
                          Icon(
                            Icons.star,
                            color: Theme.of(context).buttonColor,
                          ),
                          Icon(
                            Icons.star,
                            color: Theme.of(context).shadowColor,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 35),
                        child: Center(
                            child: Text(
                          'Member since 2022',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 25,
                          ),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
