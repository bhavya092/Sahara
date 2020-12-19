import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './donation_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:auto_size_text/auto_size_text.dart';

import './confirm_order_screen.dart';
import './feedback_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FiltersScreen extends StatefulWidget {
  List filterKeys;
  List rangeKeys;

  FiltersScreen(this.filterKeys, this.rangeKeys);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

enum problems { badqualityfood, badservice, latedeliveries }

class _FiltersScreenState extends State<FiltersScreen> {
  problems selectedButton = problems.badqualityfood;
  var rangenumber;
  var reportCount=0;
  bool isConfirm = false;
  bool isLoading = false;
  var count = 0;

  Future orderConfirm(BuildContext context, var documents, var i) {
    if (isLoading)
     {
       return null;
    } else {
      return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                content: Text('Are you sure?'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          final user =
                              await FirebaseAuth.instance.currentUser();
                          var user11 = await Firestore.instance
                              .collection('receiver')
                              .document(user.uid)
                              .get();
                          String username1 = user11['username'];
                          await Firestore.instance
                              .collection('receiver')
                              .document(user.uid)
                              .collection('past orders')
                              .document(documents[i]['id'])
                              .setData({
                            'username': documents[i]['username'],
                            'address': documents[i]['address'],
                            'typeofdonor': documents[i]['typeofdonor'],
                            'isVeg': documents[i]['isVeg'],
                            'range': documents[i]['range'],
                            'foodDescription': documents[i]['description'],
                            'donorName': documents[i]['donorName'],
                            'contact': documents[i]['contact'],
                            'email': documents[i]['email'],
                            'date':documents[i]['date'],
                            'time':DateTime.now(),
                             'finished':false,
                            
                                'id': documents[i]['id'],
                            'userId':documents[i]['userId']
                          });

                          Navigator.of(context)
                              .pushNamed(ConfirmOrderScreen.routeName,arguments: {
                                 'status': documents[i]['status'],
                                'id': documents[i]['id'],
                                'userId': documents[i]['userId'],
                                'receiverId':user.uid
                              });
                          await Firestore.instance
                              .collection('donors')
                              .document(documents[i]['userId'])
                              .collection('orders')
                              .document(documents[i]['id'])
                              .updateData({
                            'status': true,
                            'orderconfirmed': username1,
                          });
                          await Firestore.instance
                              .collection('orders')
                              .document(documents[i]['id'])
                              .updateData({
                            'status': true,
                          }).then((_) {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        } on PlatformException catch (err) {
                          var message =
                              'An error occurred, pelase check your credentials!';

                          if (err.message != null) {
                            message = err.message;
                          }
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                    title: Text("Oops something went wrong"),
                                    content: FittedBox(
                                        child: Column(children: <Widget>[
                                      Text(err.message == null
                                          ? "sorry for incovinience"
                                          : message),
                                      IconButton(
                                          icon: Icon(Icons.arrow_back),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          })
                                    ])));
                              });

                          setState(() {
                            isLoading = false;
                          });
                          print(err.message);
                        } catch (err) {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                    title: Text("Oops something went wrong"),
                                    content: FittedBox(
                                        child: Column(children: <Widget>[
                                      Text("sorry for incovinience"),
                                      IconButton(
                                          icon: Icon(Icons.arrow_back),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          })
                                    ])));
                              });

                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.black),
                      )),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ));
    }
  }

  Widget getDonorTile(int i, final documents) {
    final rangenumber = documents[i]['range'];
    DateTime date = documents[i]['date'].toDate();
    var formattedDate = DateFormat.MMMd().format(date);
    var formattedDate1 = DateFormat.Hm().format(date);
    if (documents[i]['status'] == true) {
      return Container(height: 0, width: 0);
    }
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DonationDetailScreen.routeName, arguments: {
         'isConfirm': isConfirm,
            'username': documents[i]['username'],
            'address': documents[i]['address'],
            'typeofdonor': documents[i]['typeofdonor'],
            'isVeg': documents[i]['isVeg'],
            'range': documents[i]['range'],
            'foodDescription': documents[i]['description'],
            'donorName': documents[i]['donorName'],
            'contact': documents[i]['contact'],
            'email': documents[i]['email'],
            'status': documents[i]['status'],
            'id': documents[i]['id'],
            'userId': documents[i]['userId'],
            'date': documents[i]['date'],
            'time1': documents[i]['time1'],
            
        });
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
                Container(
                  // width:MediaQuery.of(context).size.width*0.26,
                  child: Expanded(
                                      child: Text(
                      documents[i]['username'],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      items: [
                        DropdownMenuItem(
                            value: 'inappropriate',
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.report),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text('Inappropriate'),
                                ],
                              ),
                            )),
                        DropdownMenuItem(
                            value: 'feedback',
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.feedback),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text('Feedback'),
                                ],
                              ),
                            )),
                      ],
                     onChanged: (value) {
                                    if (value == 'feedback') {
                                      print('in here');
                                      Navigator.of(context)
                                          .pushNamed(FeedbackScreen.routeName);
                                    }
                                    if (value == 'inappropriate') {
                                      print('hi');
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter setState) {
                                              return Container(
                                                color: Colors.black,
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      width: double.infinity,
                                                      // height: 40,
                                                      color: Colors.white,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons
                                                                .account_circle,
                                                            color: Colors.black,
                                                            size: 40,
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.6,
                                                            child: Text(
                                                              documents[i]
                                                                  ['username'],
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    ListTile(
                                                      leading: Icon(
                                                        Icons.flag,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                      title: Text(
                                                        'Reason why you find it objectionable:',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    Divider(
                                                      color: Colors.white,
                                                    ),
                                                    RadioListTile(
                                                        selected: false,
                                                        activeColor:
                                                            Colors.white,
                                                        title: Text(
                                                            'Bad Quality Food',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        value: problems
                                                            .badqualityfood,
                                                        groupValue:
                                                            selectedButton,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedButton =
                                                                value;
                                                          });
                                                        }),
                                                    RadioListTile(
                                                        activeColor:
                                                            Colors.white,
                                                        title: Text(
                                                            'Bad Service',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        value:
                                                            problems.badservice,
                                                        groupValue:
                                                            selectedButton,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedButton =
                                                                value;
                                                          });
                                                        }),
                                                    RadioListTile(
                                                        activeColor:
                                                            Colors.white,
                                                        title: Text(
                                                            'Late deliveries',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        value: problems
                                                            .latedeliveries,
                                                        groupValue:
                                                            selectedButton,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedButton =
                                                                value;
                                                          });
                                                        }),
                                                    Expanded(
                                                      child: Container(
                                                        color: Colors.black,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Text(
                                                              'Report User?',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18),
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: <
                                                                  Widget>[
                                                                IconButton(
                                                                    icon: Icon(
                                                                      Icons
                                                                          .cancel,
                                                                      color: Colors
                                                                          .red,
                                                                      size: 40,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                IconButton(
                                                                    icon: Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .green,
                                                                      size: 40,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      // Scaffold.of(context).showSnackBar(SnackBar(
                                                                      //  content: Text(
                                                                      //'DONE',
                                                                      //style: TextStyle(color: Colors.white),
                                                                      //  )));
                                                                      var donorData = await Firestore
                                                                          .instance
                                                                          .collection(
                                                                              'donors')
                                                                          .document(documents[i]
                                                                              [
                                                                              'userId'])
                                                                          .get();
                                                                      var countUpdate =
                                                                          donorData['reportCount'] +
                                                                              1;
                                                                      await Firestore
                                                                          .instance
                                                                          .collection(
                                                                              'donors')
                                                                          .document(documents[i]
                                                                              [
                                                                              'userId'])
                                                                          .updateData({
                                                                        'reportCount':
                                                                            countUpdate
                                                                      });
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    })
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                          });
                                    }
                                  }),
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
                Text(documents[i]['typeofdonor'],
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
              SizedBox(width: MediaQuery.of(context).size.width * 0.6),
              documents[i]['isVeg']
                  ? CircleAvatar(backgroundColor: Colors.green[900],radius: 8,)
                              :CircleAvatar(backgroundColor: Colors.red,radius: 8,)
            ]),
            Row(children: [
              Icon(
                Icons.watch,
                size: 15,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Available for pickup uptil $formattedDate,$formattedDate1',
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton.icon(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  color: Colors.green,
                  onPressed: () {
                    orderConfirm(context, documents, i);
                  },
                  label: Text(
                    'Confirm Order',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('orders').snapshots(),
      builder: (ctx, streamSnapshot) {
       if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        }
      

        final documents = streamSnapshot.data.documents;

        return Container(
          child: ListView.builder(
              itemBuilder: (ctx, i) {
                rangenumber = documents[i]['range'];
                DateTime date2 = documents[i]['date'].toDate();
                if (date2.isBefore(DateTime.now())) {
                  Firestore.instance
                      .collection('orders')
                      .document(documents[i]['id'])
                      .delete();
                  return Container(height: 0, width: 0);
                }
                if (documents[i]['status'] == true) {
                 
                  return Container(height: 0, width: 0);
                }

            
/***************************MAIN*/ if (widget.filterKeys.isNotEmpty &&
                    widget.rangeKeys.isEmpty) {
/****************************SUB MAIN*/ if (documents[i]
                      [widget.filterKeys[0]]) {
                    return getDonorTile(i, documents);
                  } else {
                    return Container(
                      height: 0,width: 0,
                    );
                  }
                }
/*****************************MAIN*/ if (widget.filterKeys.isEmpty &&
                    widget.rangeKeys.isNotEmpty) {
/*************SUB MAIN */ if (widget.rangeKeys[0] == 2) {
                    if (documents[i]['range'] >= 4 &&
                        documents[i]['range'] <= 6) {
                      return getDonorTile(i, documents);
                    } else {
                      return Container(
                        height: 0,width: 0,
                      );
                    }
                  }
                  /*************SUB MAIN */ if (widget.rangeKeys[0] == 1) {
                    if (documents[i]['range'] >= 1 &&
                        documents[i]['range'] <= 3) {
                      return getDonorTile(i, documents);
                    } else {
                      return Container(
                        height: 0,width: 0,
                      );
                    }
                  }
                  /*************SUB MAIN */ if (widget.rangeKeys[0] == 3) {
                    if (documents[i]['range'] > 6) {
                      return getDonorTile(i, documents);
                    } else {
                      return Container(
                        height: 0,width: 0,
                      );
                    }
                  }
                }
                //filter ke andar filter
                else {
                  if (widget.rangeKeys[0] == 2) {
                    if (documents[i]['isVeg'] &&
                        documents[i]['range'] >= 4 &&
                        documents[i]['range'] <= 6) {
                      return getDonorTile(i, documents);
                    } else {
                      return Container(
                        height: 0,width: 0,
                      );
                    }
                  }
                  if (widget.rangeKeys[0] == 1) {
                    print(widget.rangeKeys[0]);
                    if (documents[i]['isVeg'] &&
                        documents[i]['range'] >= 1 &&
                        documents[i]['range'] <= 3) {
                      return getDonorTile(i, documents);
                    } else {
                      return Container(
                        height: 0,width: 0,
                      );
                    }
                  }
                  //...........................
                  if (widget.rangeKeys[0] == 0) {
                    print(widget.rangeKeys[0]);
                    if (documents[i]['isVeg']) {
                      return getDonorTile(i, documents);
                    } else {
                      return Container(
                        height: 0,width: 0,
                      );
                    }
                  }
                  if (widget.rangeKeys[0] == 3) {
                    print(widget.rangeKeys[0]);
                    if (documents[i]['isVeg'] && documents[i]['range'] > 6) {
                      return getDonorTile(i, documents);
                    } else {
                      return Container(
                        height: 0,width: 0,
                      );
                    }
                  }
                }
              },
              itemCount: documents.length),
        );
      },
    );
  }
}
