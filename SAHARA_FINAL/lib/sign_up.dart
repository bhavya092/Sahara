import 'package:flutter/material.dart';
//import 'package:flutter_signin_button/flutter_signin_button.dart';
//import 'package:flutter_signin_button/button_view.dart';
import './tcpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  bool _showPwd = true;
  final pwd = TextEditingController();
  final cnfrmpwd = TextEditingController();
  bool hasUppercase;
  bool hasDigits;
  bool hasLowercase;
  bool hasSpecialCharacters;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var _userName = '';
  var _userEmail = '';
  var _userPasswrod = '';
  bool isDonor;
  int count = 0;
  bool isResto = false;
  bool isCaterer = false;
  bool isIndividual = false;
  //String restoAddress = '';
  String restoName = '';
  //String catererAddress = '';
  String catererName = '';
  String indiName = '';
  bool right = false;
  bool _showCnfrmPwd = true;

  // final   _auth=FirebaseAuth.instance;

  void password() {
    setState(() {
      _showPwd = !_showPwd;
    });
  }

  void passwordC() {
    setState(() {
      _showCnfrmPwd = !_showCnfrmPwd;
    });
  }

  void validation() {
    hasUppercase = (pwd.text).contains(new RegExp(r'[A-Z]'));
    hasDigits = (pwd.text).contains(new RegExp(r'[0-9]'));
    hasLowercase = (pwd.text).contains(new RegExp(r'[a-z]'));
    hasSpecialCharacters =
        (pwd.text).contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    if (hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters) {
      setState(() {
        right = true;
      });

      return null;
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              elevation: 10,
              content: FittedBox(
                  child: Column(
                children: <Widget>[
                  Text('  Passwords must have :',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('   1. Atleast one Uppercase letter ',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5),
                  Text('    2. Atleast one Lowercase letter ',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5),
                  Text('    3. Atleast one Special character',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5),
                  Text('    4. Atleast one number from 0-9!',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              )),
            );
          });
    }
  }

  void saveAll() async {
    AuthResult authResult;
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();

      try {
        setState(() {
          isLoading = true;
        });
        authResult = await _auth.createUserWithEmailAndPassword(
            email: _userEmail, password: _userPasswrod);
        if (isDonor) {
          if (isResto) {
            await Firestore.instance
                .collection('donors')
                .document(authResult.user.uid)
                .setData({
              'username': _userName.trim(),
              'email': _userEmail.trim(),
              'type of donor': 'Restaurant',
              'address': " ",
              'reportCount': 0,
            });
          }
          if (isCaterer) {
            await Firestore.instance
                .collection('donors')
                .document(authResult.user.uid)
                .setData({
              'username': _userName.trim(),
              'email': _userEmail.trim(),
              'type of donor': 'Caterer',
              'address': " ",
              'reportCount': 0,
            });
          }
          if (isIndividual) {
            await Firestore.instance
                .collection('donors')
                .document(authResult.user.uid)
                .setData({
              'username': _userName.trim(),
              'email': _userEmail.trim(),
              'type of donor': 'Individual',
              'address': " ",
              'reportCount': 0,
            });
          }
        } else {
          await Firestore.instance
              .collection('receiver')
              .document(authResult.user.uid)
              .setData({
            'username': _userName.trim(),
            'email': _userEmail.trim(),
            'passwrod': _userPasswrod.trim(),
          });
        }
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({'Donor': isDonor});
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => TCpage(isDonor)));
      } on PlatformException catch (err) {
        var message = 'An error occurred, pelase check your credentials!';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("image/auth.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(25),
            color: Colors.white70,
            child: SingleChildScrollView(
              // child: Expanded
              //(

              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    TextFormField(
                      initialValue: null,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                           prefixIcon: Icon(Icons.email,color: Colors.black,),
                         
                          ),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Invalid Email.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        _userEmail = value;
                        FocusScope.of(context).unfocus();
                      },
                      onSaved: (value) {
                        _userEmail = value;
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    TextFormField(
                      initialValue: null,
                      controller: pwd,
                      
                      decoration: InputDecoration(
                          labelText: 'Password',

                          //labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                          //fillColor: Colors.black,
                           prefixIcon: Icon(Icons.lock,color: Colors.black,),
                          suffixIcon: IconButton(
                            icon: _showPwd
                                ? Icon(Icons.visibility_off,
                                    color: Colors.black)
                                : Icon(Icons.visibility, color: Colors.black),
                            onPressed: () => password(),
                          )),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      obscureText: _showPwd,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        // validation();
                        _userPasswrod = value;
                        FocusScope.of(context).unfocus();
                      },
                      onSaved: (value) {
                        // validation();
                        _userPasswrod = value;
                      },
                    ),
                    TextFormField(
                      initialValue: null,
                      controller: cnfrmpwd,
                      decoration: InputDecoration(
                          labelText: '*Confirm Password',
                          suffixIcon: IconButton(
                            icon: _showCnfrmPwd
                                ? Icon(Icons.visibility_off,
                                    color: Colors.black)
                                : Icon(Icons.visibility, color: Colors.black),
                            onPressed: () => passwordC(),
                          )),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      obscureText: _showCnfrmPwd,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        if (value != pwd.text) {
                          return 'Passwrods do not match!';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      onSaved: (value) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    count == 1
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'What are you?',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              CheckboxListTile(
                                title: Text("Restaurant",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                value: isResto,
                                onChanged: (newValue) {
                                  setState(() {
                                    isResto = !isResto;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              CheckboxListTile(
                                title: Text("Caterer",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                value: isCaterer,
                                onChanged: (newValue) {
                                  setState(() {
                                    isCaterer = !isCaterer;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              CheckboxListTile(
                                title: Text('Individual',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                value: isIndividual,
                                onChanged: (newValue) {
                                  setState(() {
                                    isIndividual = !isIndividual;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                              isResto
                                  ? TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Restaurant name',
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      onFieldSubmitted: (value) {
                                        _userName = value;
                                        FocusScope.of(context).unfocus();
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'enter a vaild name';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _userName = value;
                                      },
                                    )
                                  : Text(''),
                              isIndividual
                                  ? TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Your name',
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      onFieldSubmitted: (value) {
                                        _userName = value;
                                        FocusScope.of(context).unfocus();
                                      },
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return ' Enter a valid name';
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _userName = value;
                                      },
                                    )
                                  : Text(''),
                              isCaterer
                                  ? TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Caterer name',
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      onFieldSubmitted: (value) {
                                        _userName = value;
                                        FocusScope.of(context).unfocus();
                                      },
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return ' Enter a valid name';
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _userName = value;
                                      },
                                    )
                                  : Text(''),
                            ],
                          )
                        : Text(''),
                    count == -1
                        ? TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Your name',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            onFieldSubmitted: (value) {
                              _userName = value;
                              FocusScope.of(context).unfocus();
                            },
                            validator: (value) {
                              if (value.isEmpty) return ' Enter a valid name';
                              return null;
                            },
                            onSaved: (value) {
                              _userName = value;
                            },
                          )
                        : Text(''),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        if (count == 0)
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                            child: FlatButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                _formKey.currentState.validate();

                                setState(() {
                                  isDonor = false;
                                  count = -1;
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Text('Sign Up',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                  Text(
                                    'Start Recieving..',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (count == 0)
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                            child: FlatButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                _formKey.currentState.validate();
                                setState(() {
                                  isDonor = true;
                                  count = 1;
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Text('Sign Up',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                  Text(
                                    'Start Donating..',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        isLoading
                            ? Container(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.black,
                                ),
                                alignment: Alignment.center,
                              )
                            : count != 0
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    child: FlatButton(
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        _formKey.currentState.validate()
                                            ? validation()
                                            : print('');

                                        right ? saveAll() : print('');
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Text('Sign Up',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                          /* Text(
                                            'Start helping..',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          )*/
                                        ],
                                      ),
                                    ),
                                  )
                                : Text("")
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*SizedBox(height:20),

                              
                               Container
                              (
                                width:MediaQuery.of(context).size.width*0.35 ,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black),
                               // padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.25),
                                child: isLoading?
                                Center(child: CircularProgressIndicator(),)
                                :FlatButton
                                (
                                  onPressed: () 
                                  {
                                    FocusScope.of(context).unfocus();
                                    validation();
                                    
                                 right? saveAll():print('');
                                  },
                                  child: Column
                                  (
                                    children: <Widget>
                                    [
                                      Text
                                      (
                                        'Sign Up',
                                        textAlign: TextAlign.center,
                                        style:TextStyle(fontSize:20,fontWeight: FontWeight.w500,color:Colors.white)
                                      ),
                                      Text
                                      (
                                        'Start helping..',
                                        textAlign: TextAlign.center,
                                        style:TextStyle(fontSize: 12,color:Colors.white,),
                                      )  
                                    ],
                                  ),
                                ),
                              ),

                     

                           SizedBox
                          (
                            height: 10,
                          ),


                         /* Row(
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
                          ), */
                      ],
            ),
                        ),
                   // ),
                ),
              ),
     // ),
        
        ),
          ),
    );
      
  
  }
}*/
