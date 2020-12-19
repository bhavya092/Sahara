import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahara/screens/ongoing_orders.dart';
//import 'package:flutter/services.dart';
import 'package:sahara/screens/timer.dart';
//import './confirm_order_screen.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import './receiver_home_screen.dart';

//import './confirm_order_screen.dart';
class PastOrderDetailScreen extends StatefulWidget {
  static const routeName = 'pastorders-detail-screen';

  @override
  _PastOrderDetailScreenState createState() => _PastOrderDetailScreenState();
}

class _PastOrderDetailScreenState extends State<PastOrderDetailScreen> {
  Map userData = {};
  bool isLoading = false;
  var hasTimerStopped = false;


  @override
  Widget build(BuildContext context) {
    userData = ModalRoute.of(context).settings.arguments;
    final rangeNumber = userData['range'].toString();
    DateTime time1 = userData['date'].toDate();

    var date2 = time1.difference(DateTime.now()).inSeconds;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: BottomAppBar(
      
          child: Container(
              // color:userData['isConfirm']?Colors.grey:Colors.green,
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.5,
                    color: Colors.red,
                    child: FlatButton(
                        onPressed: () {
                      return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                content: Text('Are you sure?'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () async {
                        try
                          {
                            final user=await FirebaseAuth.instance.currentUser();
                             await Firestore.instance
                              .collection('donors')
                              .document(userData['userId'])
                              .collection('orders')
                              .document(userData['id'])
                              .updateData({
                            'status':false,
                            'orderconfirmed':"Not yet Confirmed",
                          });
                                 await Firestore.instance.collection('receiver').document(user.uid).collection('past orders').document(userData['id']).delete();
                                await Firestore.instance.collection('orders').document(userData['id']).updateData({
                                     'status': false,
                                 });
                                 Navigator.of(context).popAndPushNamed(ReceiverHomeScreen.routeName);
                                 
                          }
                          on PlatformException catch (err) {
        var message = 'An error occurred, pelase check your credentials!';

        if (err.message != null) {
          message = err.message;
        }
          showDialog(
        context: context,
        builder: (ctx) {

          return AlertDialog(title:Text("Oops something went wrong"),content: FittedBox(
                child: Column(
              children: <Widget>[
                Text(err.message==null?"sorry for incovinience":message),IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })])));});
        

      
        print(err.message);
      } catch (err) {
          showDialog(
        context: context,
        builder: (ctx) {

          return AlertDialog(title:Text("Oops something went wrong"),content: FittedBox(
                child: Column(
              children: <Widget>[
                Text("Sorry for the inconvinience"),IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })])));});
        
    
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
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.cancel,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              'CANCEL',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        )),
                  ),
                  
                      Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        color: Colors.green,
                        child: FlatButton(
                        onPressed: ()async {
                          try{

                         final user=await FirebaseAuth.instance.currentUser();
                         await Firestore.instance.collection('receiver').document(user.uid).collection('past orders').document(userData['id']).updateData({
                           'finished':true,
                          'date':DateTime.now(),
                         });
                          showDialog(context:context,builder:(ctx){
                       return AlertDialog(title:Text('Thank You!'),content:FittedBox(
                                                child: Column(children: <Widget>[
                           Text("Thank you for helping us!"),
                           IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(ReceiverHomeScreen.routeName);
                    })
                         ],),
                       ) ,);
                           } );
                          }on PlatformException catch (err) {
        var message = 'An error occurred, pelase check your credentials!';

        if (err.message != null) {
          message = err.message;
        }
          showDialog(
        context: context,
        builder: (ctx) {

          return AlertDialog(title:Text("Oops something went wrong"),content: FittedBox(
                child: Column(
              children: <Widget>[
                Text(err.message==null?"sorry for incovinience":message),IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })])));});
        

        print(err.message);
      } catch (err) {
          showDialog(
        context: context,
        builder: (ctx) {

          return AlertDialog(title:Text("Oops something went wrong"),content: FittedBox(
                child: Column(
              children: <Widget>[
                Text("Sorry for the inconvinience"),IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })])));});
        
       
      }

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              'RECEIVED',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        )),
                      ),
                ],
              )),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.black,
                child: ListTile(
                  title: Text(userData['donorName'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)),
                  subtitle: Text(userData['typeofdonor'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic)),
                ),
              ),
              //Divider(color: Colors.black,),
              Container(
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(userData['email'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          //fontStyle: FontStyle.italic
                        )),
                    SizedBox(
                      height: 2,
                    ),
                    Text(userData['contact'].toString(),
                        style: TextStyle(
                          textBaseline: TextBaseline.alphabetic,
                          color: Colors.white,
                          fontSize: 20,
                          //fontStyle: FontStyle.italic
                        ))
                  ],
                ),
              ),
              Container(
                child: ListTile(
                  title: Text(
                    'Type:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    userData['isVeg'] ? 'Vegetarian' : 'Non-Vegetarian',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Divider(
                thickness: 4,
              ),
              Container(
                child: ListTile(
                  title: Text('Range:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  subtitle: Text('Serves nearly $rangeNumber ',
                      style: TextStyle(fontSize: 20)),
                ),
              ),
              Divider(
                thickness: 4,
              ),
              Container(
                child: ListTile(
                  title: Text('Food Description:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  subtitle: Text(userData['foodDescription'],
                      style: TextStyle(fontSize: 20)),
                ),
              ),
              Divider(
                thickness: 4,
              ),
              Container(
                child: ListTile(
                  title: Text('Address:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  subtitle:
                      Text(userData['address'], style: TextStyle(fontSize: 20)),
                ),
              ),
              Divider(
                thickness: 4,
              ),
              Container(
                // width: 60.0,
                //padding: EdgeInsets.only(top: 3.0, right: 4.0),
                child: ListTile(
                  title: Text('Time until the order expires:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  subtitle: Align(
                    alignment: Alignment.bottomLeft,
                    child: CountDownTimer(
                      secondsRemaining: date2,
                      whenTimeExpires: () {
                        setState(() {
                          hasTimerStopped = true;
                        });
                      },
                      countDownStyle: TextStyle(
                          color: Colors.green, fontSize: 150.0, height: 100),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
    