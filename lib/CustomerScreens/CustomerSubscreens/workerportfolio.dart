import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handyman/CustomerScreens/CustomerSubscreens/chatscreen.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/authservice.dart';

class WorkerPortfolio extends StatefulWidget {
  static const routeName = '/portfolioscreen';

  @override
  State<WorkerPortfolio> createState() => _WorkerPortfolioState();
}

bool isRequested;

class _WorkerPortfolioState extends State<WorkerPortfolio> {
  var _saved = false;
  List<String> _image = [];
  var _isSelected = false;
  var selectedImg = -2;
  List<String> _services = [];

  @override
  Widget build(BuildContext context) {
    List data = ModalRoute.of(context).settings.arguments as List;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var portfolio;
    Future<void> _getQuotationState() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      var email = payload['email'];
      await AuthService().getQuotationState(data[4], email).then((val) {
        isRequested = val.data["success"];
      });

      await AuthService().getWorkerPortfolios(data[4]).then((val) {
        portfolio = val.data['u'];
      });
      // portfolio[0]['urls'][0];
      print(portfolio[0]['urls'][1]);
      print('Lenght');
      print(portfolio[0]['urls'].length);
    }

    // Future<void> _getJobRequestState() async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   var token = prefs.getString('token');
    //   Map<String, dynamic> payload = Jwt.parseJwt(token);
    //   var email = payload['email'];
    //   print("asdsad");
    //   await AuthService().getQuotationState(data[4], email).then((val) {
    //     isRequested = val.data["success"];
    //   });
    // }

    void httpJob(AnimationController controller) async {
      controller.forward();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      var name = payload['fName'] + ' ' + payload['lName'];
      var email = payload['email'];
      var msg = "You have recieved a quotation request from " + name + ".";

      await AuthService().sendPushNotification(data[3], msg);
      var quotationData = [data[4], email, data[5], data[6], name];

      await AuthService().createQuotation(quotationData);

      controller.reset();
    }

    void _saveWorker() {
      print("Called");
      setState(() {
        _saved = !_saved;
        if (_saved == true) {
          Fluttertoast.showToast(
              msg: "Saved succesfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Theme.of(context).buttonColor,
              textColor: Colors.black,
              fontSize: 16.0);
        }
      });
    }

    Widget coverImage(BuildContext context, int i, bool isSelected) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 3),
        child: Container(
          height: height * 0.4,
          width: width,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: !portfolio[0]['urls'].isEmpty
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: !isSelected
                          ? NetworkImage(portfolio[0]['urls'][0])
                          : NetworkImage(portfolio[0]['urls'][i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  height: height * 0.4,
                  width: width,
                  color: Colors.grey[400],
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.black45,
                      size: 100,
                    ),
                  ),
                ),
        ),
      );
    }

    Widget imageTile(BuildContext context, String url) {
      return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).shadowColor,
          ),
          child: Container(
              decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage('assets/images/portfolio2.jpeg'),
                  //   fit: BoxFit.fill,
                  // ),
                  ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
        ),
      );
    }

    Widget imageSlider(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 100,
                width: width * 0.95,
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.white),
                //   borderRadius: BorderRadius.circular(8),
                // ),
                child: ListView.builder(
                  itemCount: portfolio[0]['urls'].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSelected = true;
                        selectedImg = i;
                      });
                    },
                    child: Container(
                      height: 120,
                      width: 90,
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(portfolio[0]['urls'][i]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      );
    }

    Widget otherServices(BuildContext context) {
      return Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Container(
            height: 40,
            width: width * 0.95,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.white),
            //   borderRadius: BorderRadius.circular(8),
            // ),
            child: ListView.builder(
              itemCount: _services.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => !_services.isEmpty
                  ? Container(
                      height: 30,
                      width: 180,
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromRGBO(255, 255, 255, 0.6),
                      ),
                      child: Center(
                        child: Text(
                          _services[i],
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        '',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
            ),
          ));
    }

    Widget requestPop(BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Container(
            margin: EdgeInsets.all(7),
            padding: EdgeInsets.all(7),
            width: width,
            height: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  width: width * 0.9,
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage('assets/images/stepsn.png'),
                          fit: BoxFit.cover)),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.link,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Learn More',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
                Center(
                  child: ProgressButton(
                      color: Theme.of(context).buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Text(
                          isRequested
                              ? 'Already Requested'
                              : 'Request Quotation',
                          style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      onPressed: (AnimationController controller) async {
                        if (isRequested) {
                          Fluttertoast.showToast(
                              msg: 'Already Requested',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          await httpJob(controller);
                          Fluttertoast.showToast(
                              msg: 'Request Sent',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Theme.of(context).buttonColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.pop(context);
                          setState(() {});
                        }
                      }),
                )
              ],
            )),
      );
    }

    return FutureBuilder(
        future: _getQuotationState(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).backgroundColor,
              ),
              backgroundColor: Theme.of(context).backgroundColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Text(
                            data[0],
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 40),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () => _saveWorker(),
                            icon: Icon(
                              Icons.bookmark,
                              color: _saved
                                  ? Theme.of(context).buttonColor
                                  : Colors.white54,
                            )),
                      ],
                    ),
                    coverImage(context, selectedImg, _isSelected),
                    Divider(color: Colors.white54, indent: 25, endIndent: 25),
                    imageSlider(context),
                    Container(
                      width: width,
                      height: 130,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About the advertisment',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              'This is a dummy description of the advertisement. You can provide all the information about the service you provided, conditions, requirements and everything',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 3, bottom: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Services Provided',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    // otherServices(context),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 3, bottom: 3),
                      child: Container(
                        width: width,
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: Theme.of(context).shadowColor,
                              backgroundImage: data[2] != null
                                  ? NetworkImage(data[2])
                                  : null,
                              child: data[2] == null
                                  ? Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    )
                                  : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 25.0, left: 15, right: 15, bottom: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data[0],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Theme.of(context).buttonColor,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Theme.of(context).buttonColor,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Theme.of(context).buttonColor,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Theme.of(context).buttonColor,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Theme.of(context).buttonColor,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'From ' + data[1],
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "asd",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 5, bottom: 5),
                      child: Container(
                        width: width,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'This is the bio of the handyman. You can tell about your work experience and everything about you',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => requestPop(context));
                            },
                            child: Container(
                              height: 40,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Theme.of(context).buttonColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text('Request Quotation',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).backgroundColor,
                                      fontSize: 14,
                                    )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(ChatScreen.routeName);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).buttonColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.chat,
                                    color: Theme.of(context).backgroundColor,
                                  ),
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
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).buttonColor,
              ),
            );
          }
        }));
  }
}
