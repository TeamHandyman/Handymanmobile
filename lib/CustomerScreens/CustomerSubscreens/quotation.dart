import 'package:flutter/material.dart';

class quotationScreen extends StatefulWidget {
  static const routeName = '/quotationscreen';
  @override
  State<quotationScreen> createState() => _quotationScreenState();
}

class _quotationScreenState extends State<quotationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Quotation',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Job title',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'Mehcanic | Nuwan | Matara',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Date',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              '27, June 2022',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'No of workers',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              '3',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Tasks',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'Sample task',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Revenue method',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'Contract basis',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Total',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'LKR 30 000',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Advance',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'LKR 10 000',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      )),
    );
  }
}
