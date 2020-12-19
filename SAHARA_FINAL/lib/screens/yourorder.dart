import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyOrders extends StatelessWidget {
  static const routeName = 'past-orders-screen1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: Text('My Orders')),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          // color: Colors.blue,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height,
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

                    final documents = snapshot.data.documents;

                    return snapshot.data.documents.isEmpty
                        ? Center(
                            child: Text('No donations available!',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                          )
                        : ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (ctx, i) {
                              DateTime date = documents[i]['time'].toDate();

                              // DateTime date1=documents[i]['date'].toTime();
                              // var formattedDate = DateFormat.MMMd().format(date);
                              //var formattedDate1 = DateFormat.Hm().format(date);

                              return Column(
                                children: <Widget>[
                                  SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        Dismissible(
                                          key: ValueKey(documents[i]['id']),
                                          background: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              color:
                                                  Theme.of(context).errorColor,
                                            ),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.only(right: 20),
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 4,
                                            ),
                                          ),
                                          direction:
                                              DismissDirection.endToStart,
                                          confirmDismiss: (direction) {
                                            return showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: Text('Are you sure?'),
                                                content: Text(
                                                  'Do you want to remove the item from the cart?',
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    child: Text('No'),
                                                    onPressed: () {
                                                      Navigator.of(ctx)
                                                          .pop(false);
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: Text('Yes'),
                                                    onPressed: () {
                                                      Firestore.instance
                                                          .collection('orders')
                                                          .document(documents[i]
                                                              ['id'])
                                                          .delete();
                                                      Firestore.instance
                                                          .collection('donors')
                                                          .document(snapshot1
                                                              .data.uid)
                                                          .collection('orders')
                                                          .document(documents[i]
                                                              ['id'])
                                                          .delete();
                                                      Navigator.of(ctx)
                                                          .pop(true);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          onDismissed: (direction) {},
                                          child: Card(
                                              //elevation: 40,
                                              // borderOnForeground: true,
                                              color: Colors.amber[50],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  side: new BorderSide(
                                                      color: Colors.black,
                                                      width: 0.0)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Date: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Serves: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Category: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      leading: Text(
                                                        'Description:',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                    Divider(
                                                        color: Colors.black),
                                                    ListTile(
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      leading: Text(
                                                        'Order Confirmed by:',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      title: Container(
                                                        width: MediaQuery.of(
                                                                    context)
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
                                        ),
                                        // ),
                                        // ),
                                        SizedBox(height: 5)
                                      ],
                                    ),
                                  )
                                ],
                              );
                            });
                  });
            }),
      ),
    );
  }
}
