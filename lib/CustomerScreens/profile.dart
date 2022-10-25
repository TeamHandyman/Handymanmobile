import 'package:flutter/material.dart';
import 'package:handyman/CustomerScreens/CustomerSubscreens/savedworkers.dart';
import 'package:handyman/Onboarding/login.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Widget profileButtons(BuildContext context, String text, IconData icon) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: (() =>
                  Navigator.of(context).pushNamed(SavedworkerScreen.routeName)),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).buttonColor,
                child: Icon(
                  icon,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
          ],
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          profileButtons(context, 'Edit', Icons.edit),
                          profileButtons(
                              context, 'Message', Icons.chat_bubble_outline),
                          profileButtons(
                              context, 'Payment', Icons.payment_outlined),
                          profileButtons(
                              context, 'Saved', Icons.bookmark_border),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 10,
                          left: 15,
                          right: 15,
                        ),
                        child: GestureDetector(
                          child: Container(
                            height: 46,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ProgressButton(
                                color: Theme.of(context).backgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                child: Text('Log Out',
                                    style: TextStyle(
                                        color: Theme.of(context).buttonColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                onPressed:
                                    (AnimationController controller) async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  await preferences.clear();
                                  Navigator.of(context)
                                      .pushNamed(LoginScreen.routeName);
                                }),
                          ),
                        ),
                      ),
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
