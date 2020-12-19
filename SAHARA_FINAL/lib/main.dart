//import 'package:app1/welcome_page.dart';

import 'package:flutter/material.dart';
import 'package:sahara/screens/ongoing_orders.dart';
import './screens/past_orders_details.dart';
import 'package:sahara/screens/about.dart';
import 'package:sahara/screens/profile.dart';
import 'package:sahara/screens/yourorder.dart';
import 'package:sahara/sign_in.dart';
import 'package:sahara/spashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahara/splash_screen.dart';
import './screens/add_order.dart';
import './screens/donor_main.dart';
import './screens/tick.dart';
import './screens/receiver_home_screen.dart';
import './screens/donation_detail_screen.dart';
import './screens/confirm_order_screen.dart';
import './screens/pastorders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './screens/feedback_screen.dart';
import './screens/about1.dart';
import './widgets/tabs.dart';
//import './sign_up.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
bool isDonor;
  bool isLoading=false;

 /* Future<void> check1() async {
    final user = await
     setState(() {
       isLoading=true;
     });
      final user=await FirebaseAuth.instance.currentUser();
    var userData =
        await Firestore.instance.collection('users').document(user.uid).get().then((value) {
          setState(() {
             isDonor=value['Donor'];
          });
         
        }).whenComplete(() {
           setState(() {
             print(isDonor);
       isLoading=false;
     });
        });
    
    
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sahara',
      theme: ThemeData(
        fontFamily: 'Raleway',
      ),
      home: 
              StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,builder:(ctx,snapshot){
         
          if(snapshot.hasData)
          {
            return FutureBuilder(future: FirebaseAuth.instance.currentUser(),builder:(ctx,futuresnapshot){
              
                 if(futuresnapshot.connectionState==ConnectionState.done)
                 {
                   return FutureBuilder(future:Firestore.instance.collection('users').document(futuresnapshot.data.uid).get() ,builder: (ctx,future1){
                      if(future1.connectionState==ConnectionState.done)
                      {
                        if(future1.data['Donor'])
                        {
                            return DonorMain();
                        }
                        else
                        {
                          return ReceiverHomeScreen();
                        }
                      }
                      if(future1.connectionState==ConnectionState.waiting)
                      {
                        return SplashScreen();
                      }
                      
                   });
                 }
                 if(futuresnapshot.connectionState==ConnectionState.waiting)
                 {
                   return SplashScreen();
                 }
            }, );
          }
        return SignIn();
          }),
      
      
      routes: {
        PastOrdersScreen.routeName:(ctx)=>PastOrdersScreen(),
        ProfileScreen.routeName:(ctx)=>ProfileScreen(),
        AboutUs.routeName:(ctx)=>AboutUs(),
        AboutUs1.routeName:(ctx)=>AboutUs1(),
        SplashScreen1.routeName: (ctx) => SplashScreen1(),
        SplashScreen.routeName: (ctx) => SplashScreen(),
        SignIn.routeName: (ctx) => SignIn(),
        AddOrder.routeName: (ctx) => AddOrder(),
        DonorMain.routeName: (ctx) => DonorMain(),
        TickPage.routeName: (ctx) => TickPage(),
        DonationDetailScreen.routeName: (ctx) => DonationDetailScreen(),
        ConfirmOrderScreen.routeName: (ctx) => ConfirmOrderScreen(),
        ReceiverHomeScreen.routeName: (ctx) => ReceiverHomeScreen(),
        FeedbackScreen.routeName: (ctx) => FeedbackScreen(),
        MyOrders.routeName:(ctx)=>MyOrders(),
        Tabs.routeName:(ctx)=>Tabs(),
      PastOrderDetailScreen.routeName:(ctx)=>PastOrderDetailScreen(),
      OngoingOrders.routeName:(ctx)=>OngoingOrders(),
      },
    );
  }
}
