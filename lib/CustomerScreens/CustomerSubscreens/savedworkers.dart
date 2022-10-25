import 'package:flutter/material.dart';

class SavedworkerScreen extends StatefulWidget {
  static const routeName = '/saveworkerscreen';

  @override
  State<SavedworkerScreen> createState() => _SavedworkerScreenState();
}

class _SavedworkerScreenState extends State<SavedworkerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 40,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Worker name',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Mechanic | Malabe',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        // onPressed: () => _saveWorker(),
                        icon: Icon(
                      Icons.bookmark,
                      color: Theme.of(context).buttonColor,
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
