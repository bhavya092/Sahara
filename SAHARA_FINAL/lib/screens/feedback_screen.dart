import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  static const routeName = 'feedback-screen';
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Give Feedback'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Rate our Donor:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                
                RatingBar(
                    itemBuilder: (context, _) {
                      return Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                    minRating: 1,
                    allowHalfRating: true,
                    direction: Axis.horizontal,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4),
                    itemCount: 5,
                    initialRating: 2,
                    onRatingUpdate: (rating) {
                      print(rating);
                    }),
                    SizedBox(height: 10,),
                Text(
                  'Let the donor know if you have some suggestions',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: TextField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: 'Give Feedback',
                      labelStyle: TextStyle(color: Colors.black45,letterSpacing: 12)
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                RaisedButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
