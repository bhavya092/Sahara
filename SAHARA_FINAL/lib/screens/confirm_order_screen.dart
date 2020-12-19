import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './receiver_home_screen.dart';

class ConfirmOrderScreen extends StatefulWidget {
  static const routeName = 'confirm-order-screen';

  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  Map userData = {};

  @override
  Widget build(BuildContext context) {
    userData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Donation claimed successfully!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
                child: Icon(Icons.check_circle_outline,
                    size: 150, color: Colors.green)),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 1000,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(18),
              ),
              child: FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .popAndPushNamed(ReceiverHomeScreen.routeName);
                  },
                  child: Text(
                    'Continue Recieving',
                    style: TextStyle(fontSize: 15),
                  )),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              width: 1000,
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(18),
              ),
              child: FlatButton(
                  onPressed: () async {
                    await Firestore.instance
                        .collection('donors')
                        .document(userData['userId'])
                        .collection('orders')
                        .document(userData['id'])
                        .updateData({
                      'status': false,
                      'orderconfirmed': "Not yet Confirmed",
                    });
                    await Firestore.instance
                        .collection('orders')
                        .document(userData['id'])
                        .updateData({
                      'status': false,
                    });
                    await Firestore.instance
                        .collection('receiver')
                        .document(userData['receiverId'])
                        .collection('past orders')
                        .document(userData['id'])
                        .delete();
                    Navigator.of(context)
                        .popAndPushNamed(ReceiverHomeScreen.routeName);
                  },
                  child: Text(
                    'Cancel Donation',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
