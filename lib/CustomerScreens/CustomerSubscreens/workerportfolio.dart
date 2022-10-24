import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/authservice.dart';

class WorkerPortfolio extends StatefulWidget {
  static const routeName = '/portfolioscreen';

  @override
  State<WorkerPortfolio> createState() => _WorkerPortfolioState();
}

class _WorkerPortfolioState extends State<WorkerPortfolio> {
  var _saved = false;
  @override
  Widget build(BuildContext context) {
    List data = ModalRoute.of(context).settings.arguments as List;
    Future<void> _getQuotationState() async {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // var token = prefs.getString('token');
      // Map<String, dynamic> payload = Jwt.parseJwt(token);
      // email = payload['email'];
      // name = payload['fName'] + ' ' + payload['lName'];
      // await AuthService().getQuotationState(ad_data[9]).then((val) {
      //   var emails = val.data["emails"];
      //   // isAccepted = emails.contains(email);
      // });
    }

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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

    void _requestQuote() {
      Fluttertoast.showToast(
          msg: "Requested successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).buttonColor,
          textColor: Colors.black,
          fontSize: 16.0);
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, top: 15, bottom: 3),
                      child: Container(
                        height: height * 0.4,
                        width: width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).shadowColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/portfolio1.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
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
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/portfolio2.jpeg'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
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
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/portfolio3.jpeg'),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
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
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/portfolio3.jpeg'),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
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
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/portfolio1.jpeg'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
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
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/portfolio2.jpeg'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
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
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/portfolio1.jpeg'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                                  fontWeight: FontWeight.bold),
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
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3),
                              child: Column(
                                children: [
                                  Container(
                                    height: 130,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).shadowColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/services1.jpeg'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 5),
                                    child: Text(
                                      'Plumbing',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3),
                              child: Column(
                                children: [
                                  Container(
                                    height: 130,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).shadowColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/services2.jpeg'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15, top: 5),
                                    child: Text(
                                      'Carpentary',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                              backgroundImage:
                                  data[2] != "" ? NetworkImage(data[2]) : null,
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
                                    'Member since 2020',
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
                              _requestQuote();
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
