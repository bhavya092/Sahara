import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
class SignInButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>
                            [
                              Container
                              (
                                 child: Text
                                 (
                                  'Try Other Options',
                                   style:TextStyle(color:Colors.black,fontSize: 16,fontWeight: FontWeight.bold), 
                                 ),
                              ),

                             SignInButton
                             (
                               Buttons.AppleDark,
                               mini:true,
                               onPressed: () {},
                             ), 

                             SignInButton
                             (
                               Buttons.Facebook,
                               mini:true,
                               onPressed: () {},
                             ),

                             SignInButton
                             (
                               
                               Buttons.Twitter,
                               mini: true,
                               onPressed: () {},
                             ), 
                            ],
                          );
  }
}