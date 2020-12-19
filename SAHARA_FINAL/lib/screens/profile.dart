import 'package:flutter/material.dart';
import './donor_main.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushNamed(DonorMain.routeName);
          },
        ),
        title: Text('Profile'),
      ),
      body: Column(
        children: <Widget>[
          Text('Name: '),
          SizedBox(height: 20,),
          Text('Registered Email: '),
          SizedBox(height: 20,),
          Text('Category: '),
          SizedBox(height: 20,),
          Text('Pick Up Address: '),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}