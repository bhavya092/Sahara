//import 'dart:math';

import 'package:flutter/material.dart';
import '../models/orders.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersList extends StatefulWidget {
  final List<Orders> ord;

  OrdersList(this.ord);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  /* Widget getDonorTile(int i, final documents) {
    final rangenumber = documents[i]['range'];
    return InkWell(
      onTap: () {
        
      },
      child: Card(
        elevation: 2.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.all(3),
        color: Colors.grey[50],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 60,
                  color: Colors.grey,
                ),
                Text(
                  documents[i]['description'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.confirmation_number,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 4,),
                          /*Text(
                            'Order Number:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      Text('1234',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),*/
                    ],
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.verified_user,
                  size: 15,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(documents[i]['date'].toString(),
                    style: TextStyle(
                        color: Colors.black, fontStyle: FontStyle.italic)),
              ],
            ),
            Row(children: [
              Icon(
                Icons.supervised_user_circle,
                size: 15,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Serves $rangenumber',
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.64),
              documents[i]['veg']
                  ? Icon(
                      MyFlutterApp.primitive_dot,
                      size: 30,
                      color: Colors.green[700],
                    )
                  : Icon(
                      MyFlutterApp.primitive_dot,
                      size: 30,
                      color: Colors.red,
                    )
            ]),
            Row(children: [
              SizedBox(
                width: 4,
              ),
              Icon(
                Icons.calendar_today,
                size: 20,
                color: Colors.black,
              ),
              SizedBox(
                width: 4,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Received on: 19/6/2020 At 21:00 hrs',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),

                    // Text('At 21:00 hrs',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }*/

  /*void fetching() async {
    final user = await FirebaseAuth.instance.currentUser();
    var userdata = await Firestore.instance
        .collection('donors')
        .document(user.uid)
        .collection('orders')
        .snapshots();
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
      //decoration: BoxDecoration(borderRadius:BorderRadius.circular(10), ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.white]),
      ),
      height: MediaQuery.of(context).size.height * 0.4,
      child: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (ctx, snapshot1) {
            if (snapshot1.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              );
            }

            return StreamBuilder(
                stream: Firestore.instance
                    .collection('donors')
                    .document(snapshot1.data.uid)
                    .collection('orders')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    );
                  }
                  if (snapshot.data == null) {
                    return Center(
                      child: Text("nothing there",
                          style: TextStyle(color: Colors.white)),
                    );
                  }
                  final documents = snapshot.data.documents;
                  /*return Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: ListView.builder(
                        itemBuilder: (ctx, i) {
                          return getDonorTile(i, documents);
                        },
                        itemCount: documents.length),
                  );*/

                  return snapshot.data.documents.isEmpty
                      ? Center(
                          child: Text('No donations available!',
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                        )
                      : ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (ctx, i) {
                            DateTime date = documents[i]['time'].toDate();

                            // DateTime date1=documents[i]['date'].toTime();
                            // var formattedDate = DateFormat.MMMd().format(date);
                            //var formattedDate1 = DateFormat.Hm().format(date);

                            return SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  // Container(
                                  // width: MediaQuery.of(context).size.width*0.93,
                                  //height: min(MediaQuery.of(context).size.height*0.23,MediaQuery.of(context).size.height*0.3),
                                  // child:
                                  // SingleChildScrollView(
                                  //  child:
                                  Card(
                                      //elevation: 40,
                                      // borderOnForeground: true,
                                      color: Colors.amber[50],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          side: new BorderSide(
                                              color: Colors.black, width: 0.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Date: ',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  ' ${DateFormat('yMMMd').format(date)}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Serves: ',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  ' ${documents[i]['range']}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Category: ',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  ' ${documents[i]['veg'] ? 'Veg' : 'NonVeg'}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.black,
                                            ),
                                            ListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              leading: Text(
                                                'Description:',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              title: Text(
                                                ' ${documents[i]['description']}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              //),
                                              //  ],
                                            ),
                                            Divider(color: Colors.black),
                                            ListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              leading: Text(
                                                'Order Confirmed by:',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              title: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                child: Text(
                                                  ' ${documents[i]['orderconfirmed']}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              // ],
                                            ),

                                            /*Text(
                                            'Range: ${documents[i]['range']}',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            'Category: ${documents[i]['veg']?'Veg':'NonVeg'} ',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            'Description: ${documents[i]['description']}',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            'OrderConfirmeby:${documents[i]['orderconfirmed']}',
                                             style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold
                                            ),
                                          )*/
                                          ],
                                        ),
                                      )),
                                  // ),
                                  // ),
                                  SizedBox(height: 5)
                                ],
                              ),
                            );
                          });
                });
          }),
    );
    //);
  }
}
