import 'package:flutter/material.dart';
import 'package:handyman/CustomerScreens/CustomerSubscreens/quotation.dart';
import 'package:progress_indicator_button/progress_button.dart';

class ConfirmedJobsScreen extends StatefulWidget {
  static const routeName = '/confiremdjobsscreen';

  @override
  State<ConfirmedJobsScreen> createState() => _ConfirmedJobsScreenState();
}

class _ConfirmedJobsScreenState extends State<ConfirmedJobsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget headingText(
        BuildContext context, String title, String worker, String location) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          title + ' | ' + worker + ' | ' + location,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            headingText(context, 'Mechanic', 'Nuwan', 'Matara'),
            Center(
              child: Text(
                'Ongoing',
                style: TextStyle(
                    color: Theme.of(context).buttonColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '21 June 2022',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '21 September 2022',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Description',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Text(
                  'Sample description Sample description Sample description Sample description Sample description Sample description Sample description Sample description Sample description',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Method - ' + 'Hourly rate',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_return_rounded,
                  size: 20,
                  color: Theme.of(context).buttonColor,
                ),
                GestureDetector(
                  onTap: () {
                    print("Clicked");
                    Navigator.of(context).pushNamed(quotationScreen.routeName);
                  },
                  child: Text(
                    'View quotation',
                    style: TextStyle(
                      color: Theme.of(context).buttonColor,
                      fontSize: 15,
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
                Text(
                  '10',
                  style: TextStyle(
                      color: Theme.of(context).buttonColor,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Hours',
                  style: TextStyle(
                      color: Theme.of(context).buttonColor, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Estimated Total',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Text(
              'LKR 10, 000',
              style:
                  TextStyle(color: Theme.of(context).buttonColor, fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Payment',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Icon(
                  Icons.check_box,
                  color: Colors.white,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_return_rounded,
                  size: 20,
                  color: Theme.of(context).buttonColor,
                ),
                Text(
                  'View payment details',
                  style: TextStyle(
                      color: Theme.of(context).buttonColor, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Add a rating',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
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
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                height: 46,
                width: width,
                decoration: BoxDecoration(
                  // color: Theme.of(context).buttonColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ProgressButton(
                    color: Theme.of(context).buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Text('Mark as completed',
                        style: TextStyle(
                            color: Theme.of(context).backgroundColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    onPressed: (AnimationController controller) async {
                      // print(date.day);

                      await null;
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
