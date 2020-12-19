import 'package:flutter/material.dart';
//import 'package:carousel_slider/carousel_slider.dart';

import './add_order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/order_list.dart';
import '../models/orders.dart';
import 'package:carousel_pro/carousel_pro.dart';

import '../widgets/drawer2.dart';

class DonorMain extends StatefulWidget {
  static const routeName = '/donor-main';

  @override
  _DonorMainState createState() => _DonorMainState();
}

class _DonorMainState extends State<DonorMain> {
  int value = 0;
  AuthResult authResult;
  final List<Orders> _loadedOrders = [
    Orders(
      range: 2,
      isVeg: true,
      description: 'Roti',
    )
  ];

  @override
  Widget build(BuildContext context) {
    /* Widget testBGCarousel =  Container(
height: MediaQuery.of(context).size.width*0.25,
width: MediaQuery.of(context).size.width*0.25,
    child: new Carousel(
      images: [
        AssetImage('image/bg1.jpg'),
        AssetImage("image/auth.jpg"),
      
      ].map((bgImg) => new Image(image: bgImg, width: MediaQuery.of(context).size.width*0.2, height: MediaQuery.of(context).size.width*0.2, fit: BoxFit.cover)).toList(),
      boxFit: BoxFit.cover,
      autoplay: true,
      autoplayDuration: Duration(seconds:5),dotSize: 0,dotBgColor: null,showIndicator: false,
    ),
  );*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Sahara',
          style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        // ),
      ),
      drawer: MainDrawer1(),
      /*Drawer(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 120,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Options',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 25
                  ),
                  title: Text(
                    'Profile',
                  style: TextStyle(
                    fontSize: 20,
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).pushNamed(ProfileScreen.routeName);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.info,
                    size: 25
                  ),
                  title: Text(
                    'About us',
                  style: TextStyle(
                    fontSize: 20,
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).pushNamed(AboutUs.routeName);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: 25
                  ),
                  title: Text(
                    'Settings',
                  style: TextStyle(
                    fontSize: 20,
                    ),
                  ),
                  onTap: (){},
                ),
                SizedBox(height: 170,),
                ListTile(
                  key:ValueKey('logout'),
                  leading: Icon(
                    Icons.exit_to_app,
                    size: 25,
                  ),
                  title: Text(
                    'Logout',
                  style: TextStyle(
                    fontSize: 20,
                    ),
                  ),
                onTap: (){
                  value=1;
                  if(value==1)
                  {
                      FirebaseAuth.instance.signOut();
                  }
                  //FirebaseAuth.instance.signOut();
                  // Navigator.of(context).pushNamed(SplashScreen.routeName);
                },
                ),
              ],
            ),
          ),
        ),*/
      body: Container(
        // color:Colors.black54,
        //child: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Container(
              // height: MediaQuery.of(context).size.width*0.5,
              // child:
              new SizedBox(
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.63,
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
                              /* width: MediaQuery.of(context).size.width*0.2, height: MediaQuery.of(context).size.height*0.6,*/ fit:
                                  BoxFit.fitWidth,
                            ))
                        .toList(),
                    boxFit: BoxFit.cover,
                    autoplay: true,
                    autoplayDuration: Duration(seconds: 5),
                    dotSize: 4,
                    dotHorizontalPadding: 0,
                    dotSpacing: 40,
                  ),
                ),
              ),
              //  ),

              Container(
                color: Colors.white,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      ' Your Donations: ',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Divider(color: Colors.black),
              OrdersList(_loadedOrders),
              /* Container(
                   // height: MediaQuery.of(context).size.height*0.065,
                    width:MediaQuery.of(context).size.width,
                    child: FlatButton(color: Colors.black,
          onPressed: () {
            Navigator.of(context).pushNamed(AddOrder.routeName);
          },
          child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text("Donate Now",style: TextStyle(fontSize:18,color: Colors.white),)
            ],
          ),
                    ),
                  )*/
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
            color: Colors.black,
            child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddOrder.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                    Text(
                      'Donate Now',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ))),
      ),
      /* floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FlatButton(
         
          child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              Icon(
                Icons.people,
              ),
              Text("Donate")
            ],
          ),
          
          onPressed: () {
            Navigator.of(context).pushNamed(AddOrder.routeName);
          },
        ),*/
    );
  }
}
