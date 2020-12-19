import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import './feedback_screen.dart';

import './confirm_order_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/donation_detail_screen.dart';
import 'package:intl/intl.dart';
import './filters_screen.dart';

class ReceiverHomeScreen extends StatefulWidget {
  static const routeName = 'receiver-home-screen';
  @override
  _ReceiverHomeScreenState createState() => _ReceiverHomeScreenState();
}

enum problems { badqualityfood, badservice, latedeliveries }

class _ReceiverHomeScreenState extends State<ReceiverHomeScreen> {
  void initState() {
    count = 0;
    super.initState();
  }

  problems selectedButton = problems.badqualityfood;
  List<String> filterKeys = [];
  List<int> rangeKeys = [];
  bool isRange0 = false;
  bool isRange1 = false;
  bool isRange2 = false;
  bool isRange3 = false;
  bool isLoading = false;
  bool vegIsChecked = false;
  bool status = false;
  bool isConfirm = false;
  int count;

  Widget getDonorTile(int i, final documents) {
    final rangenumber = documents[i]['range'];
    DateTime date = documents[i]['date'].toDate();

    // DateTime date1=documents[i]['date'].toTime();
    var formattedDate = DateFormat.MMMd().format(date);
    var formattedDate1 = DateFormat.Hm().format(date);

    // var date1 = new DateTime.fromMicrosecondsSinceEpoch(documents[i]['date']);
    /*if(count==documents.length)
    {
       return Container(child: Text('No orders yet',style: TextStyle(color: Colors.green),),);
    }*/

    return Container(
      width: MediaQuery.of(context).size.width,
      child: InkWell(
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
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Card(
                  elevation: 2.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.all(3),
                  color: Colors.white,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
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
                                              Icon(Icons.flag),
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
                                          // isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter setState) {
                                              return Container(
                                                color: Colors.black,
                                                child: ListView(
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
                                                          ),
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
                                                    Container(
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
                                                            children: <Widget>[
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
                                                                    Icons.check,
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
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic)),
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
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6),
                          documents[i]['isVeg']
                              ? CircleAvatar(
                                  backgroundColor: Colors.green[900],
                                  radius: 8,
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 8,
                                )
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
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic),
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
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.020)
            ],
          ),
        ),
      ),
    );
  }

  Future orderConfirm(BuildContext context, var documents, var i) {
    if (isLoading) {
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
                            'date': documents[i]['date'],
                            'time': DateTime.now(),
                            'finished': false,
                            'id': documents[i]['id'],
                            'userId': documents[i]['userId']
                          });

                          Navigator.of(context).pushNamed(
                              ConfirmOrderScreen.routeName,
                              arguments: {
                                'status': documents[i]['status'],
                                'id': documents[i]['id'],
                                'userId': documents[i]['userId'],
                                'receiverId': user.uid
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
                                    content: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.129,
                                        child: Column(children: <Widget>[
                                          Text(
                                            err.message == null
                                                ? "sorry for incovinience"
                                                : message,
                                            style: TextStyle(fontSize: 15),
                                          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Colors.black,
          title: Text('Sahara'),
          actions: <Widget>[
            DropdownButtonHideUnderline(
              child: DropdownButton(
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                  items: [
                    DropdownMenuItem(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Filters',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                    DropdownMenuItem(
                        child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Checkbox(
                                  activeColor: Colors.black,
                                  checkColor: Colors.white,
                                  value: vegIsChecked,
                                  onChanged: (bool value) {
                                    // FocusScope.of(context).unfocus();

                                    vegIsChecked = value;
                                    if (vegIsChecked) {
                                      setState(() {
                                        filterKeys.add('isVeg');
                                        // FiltersScreen(filterKeys, rangeKeys);
                                      });
                                    } else {
                                      setState(() {
                                        // FocusScope.of(context).unfocus();
                                        filterKeys.remove('isVeg');
                                      });
                                    }
                                  }),
                              Text(
                                'Veg Only',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                    DropdownMenuItem(
                      child: Container(
                          child: Row(
                        children: <Widget>[
                          Text('Range:'),
                          SizedBox(
                            width: 20,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(items: [
                              DropdownMenuItem(
                                  onTap: () {
                                    setState(() {
                                      isRange1 = false;
                                      isRange2 = false;
                                      isRange3 = false;
                                      isRange0 = !isRange0;
                                      // FocusScope.of(context).unfocus();
                                    });
                                    if (isRange0) {
                                      if (rangeKeys.isNotEmpty) {
                                        setState(() {
                                          rangeKeys.removeLast();
                                          //  FocusScope.of(context).unfocus();
                                        });
                                      }
                                      setState(() {
                                        rangeKeys.add(0);
                                        // FocusScope.of(context).unfocus();
                                        //FiltersScreen(filterKeys, rangeKeys);
                                      });
                                    } else {
                                      setState(() {
                                        rangeKeys.removeLast();
                                        // FocusScope.of(context).unfocus();
                                      });
                                    }
                                  },
                                  child: Text(
                                    'All',
                                    style: TextStyle(
                                        fontWeight: isRange0
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                                  )),
                              DropdownMenuItem(
                                onTap: () {
                                  setState(() {
                                    isRange0 = false;
                                    isRange2 = false;
                                    isRange3 = false;
                                    isRange1 = !isRange1;
                                    // FocusScope.of(context).unfocus();
                                    if (isRange1) {
                                      if (rangeKeys.isNotEmpty) {
                                        setState(() {
                                          rangeKeys.removeLast();
                                          // FocusScope.of(context).unfocus();
                                        });
                                      }
                                      setState(() {
                                        rangeKeys.add(1);
                                        // FocusScope.of(context).unfocus();
                                        // FiltersScreen(filterKeys, rangeKeys);
                                      });
                                    } else {
                                      setState(() {
                                        rangeKeys.removeLast();
                                        // FocusScope.of(context).unfocus();
                                      });
                                    }
                                  });
                                },
                                child: Text(
                                  '1-3',
                                  style: TextStyle(
                                      fontWeight: isRange1
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ),
                              DropdownMenuItem(
                                  onTap: () {
                                    setState(() {
                                      isRange0 = false;
                                      isRange1 = false;
                                      isRange3 = false;
                                      isRange2 = !isRange2;
                                      //FocusScope.of(context).unfocus();
                                    });
                                    if (isRange2) {
                                      if (rangeKeys.isNotEmpty) {
                                        setState(() {
                                          rangeKeys.removeLast();
                                          // FocusScope.of(context).unfocus();
                                        });
                                      }
                                      setState(() {
                                        rangeKeys.add(2);
                                        //FocusScope.of(context).unfocus();
                                        // FiltersScreen(filterKeys, rangeKeys);
                                      });
                                    } else {
                                      setState(() {
                                        rangeKeys.removeLast();
                                        // FocusScope.of(context).unfocus();
                                      });
                                    }
                                  },
                                  child: Text(
                                    '4-6',
                                    style: TextStyle(
                                        fontWeight: isRange2
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                                  )),
                              DropdownMenuItem(
                                  onTap: () {
                                    setState(() {
                                      isRange1 = false;
                                      isRange2 = false;
                                      isRange0 = false;
                                      isRange3 = !isRange3;
                                      //FocusScope.of(context).unfocus();
                                    });
                                    if (isRange3) {
                                      if (rangeKeys.isNotEmpty) {
                                        setState(() {
                                          rangeKeys.removeLast();
                                          // FocusScope.of(context).unfocus();
                                        });
                                      }
                                      setState(() {
                                        rangeKeys.add(3);
                                        // FocusScope.of(context).unfocus();
                                        // FiltersScreen(filterKeys, rangeKeys);
                                      });
                                    } else {
                                      setState(() {
                                        rangeKeys.removeLast();
                                        // FocusScope.of(context).unfocus();
                                      });
                                    }
                                  },
                                  child: Text(
                                    '>6',
                                    style: TextStyle(
                                        fontWeight: isRange3
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                                  ))
                            ], onChanged: (value) {}),
                          )
                        ],
                      )),
                    )
                  ],
                  onChanged: (_) {}),
            )
          ],
        ),
        //****************************************************************************************************** */
        body: Container(
          child: SingleChildScrollView(
            //physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width * 0.64,
                  child: new SizedBox(
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.25,
                      width: double.infinity,
                      child: new Carousel(
                        images: [
                          AssetImage('image/bg1.jpg'),
                          AssetImage("image/download (2).jpg"),
                          AssetImage("image/street-children-11.jpg"),
                          AssetImage("image/OIP (1).jpg"),
                          AssetImage("image/download.jpg"),
                          AssetImage("image/auth.jpg"),
                        ]
                            .map((bgImg) => new Image(
                                image: bgImg,
                                // width: MediaQuery.of(context).size.width * 0.25,
                                // height:
                                //  MediaQuery.of(context).size.width * 0.25,
                                fit: BoxFit.cover))
                            .toList(),
                        boxFit: BoxFit.cover,
                        autoplay: true,
                        autoplayDuration: Duration(seconds: 10),
                        dotSize: 5,
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                   
                      Positioned(
                          top: 50,
                          left: 60,
                          child: Center(
                            child: Text('No donations available!',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                          )),
                    
                    Container(
                      height: MediaQuery.of(context).size.height * 0.58,
                      width: double.infinity,
                      child: (filterKeys.isEmpty &&
                              (rangeKeys.isEmpty || rangeKeys.contains(0)))
                          ? StreamBuilder(
                              stream: Firestore.instance
                                  .collection('orders')
                                  .orderBy('time', descending: true)
                                  .snapshots(),
                              builder: (ctx, streamSnapshot) {
                                if (streamSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.black,
                                    ),
                                  );
                                }

                                final documents = streamSnapshot.data.documents;
                                /* if (documents.length==0) {
                                 return Center(
                                    child: Container(
                                      
                                            child: Text(
                                          "NO ORDERS AVAILABLE!",
                                          style: TextStyle(fontSize: 18,color: Colors.black),
                                        )),
                                  );
                                }*/

                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(
                                                backgroundColor: Colors.black),
                                          )
                                        : Container(
                                            child: ListView.builder(

                                                //shrinkWrap: true,
                                                itemBuilder: (ctx, i) {
                                                  DateTime date2 = documents[i]
                                                          ['date']
                                                      .toDate();

                                                  if (date2.isBefore(
                                                      DateTime.now())) {
                                                    Firestore.instance
                                                        .collection('orders')
                                                        .document(
                                                            documents[i]['id'])
                                                        .delete();
                                                  }
                                                  if (documents[i]['status'] ==
                                                      true) {
                                                    //    count = count + 1;
                                                    //   print(count);
                                                    /* if (count == documents.length) {
                                                      return Center(
                                                        child: Container(
                                                          
                                                            child: Text(
                                                              "NO ORDERS AVAILABLE!",
                                                              style: TextStyle(
                                                                  fontSize: 16,color: Colors.black),
                                                            )),
                                                      );
                                                    }*/

                                                    return Container(
                                                        height: 0, width: 0);
                                                  }

                                                  return getDonorTile(
                                                      i, documents);
                                                },
                                                itemCount: documents.length),
                                          ),
                                  ),
                                );
                              },
                            )
                          : FiltersScreen(filterKeys, rangeKeys),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
