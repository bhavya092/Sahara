import 'package:flutter/material.dart';
import './screens/donor_main.dart';
import './screens/receiver_home_screen.dart';

class TCpage extends StatefulWidget {
  bool isDonor;
  TCpage(this.isDonor);
  @override
  _TCpageState createState() => _TCpageState();
}

class _TCpageState extends State<TCpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 20,
        backgroundColor: Colors.pink,
        title: Text('Terms and Conditions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        color: Colors.amber[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              // color:Colors.amber[200],
              child: Expanded(
                  child: Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('1.Terms of Use',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      ),
                      Text(
                          'This Terms and Conditions Agreement sets forth the standards of use of the Food Donation service, (“Sahara Pvt.Ltd”) Online Service. By using the Sahara app, you (the ”User”) agree to these terms and conditions. If you do not agree to the terms and conditions of this Agreement, you should immediately cease all usage of this application. We reserve the right, at any time, to modify, alter, or update the terms and conditions of this agreement without prior notice. Modifications shall become effective immediately upon being posted at Sahara Application. Your continued use of the Service after amendments are posted constitutes acknowledgement and acceptance of the Agreement and its modifications. Except as provided in this paragraph, this Agreement may not be amended.'),
                      Divider(color: Colors.black),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('2. Services',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      ),
                      Text(
                          '2.1.   We are a food donation service provider providing you an online platform to (a) donate food online to whomever needs it and (b) receive food online from the list of restaurant donors and home food makers available on the Services.'),
                      Text(
                          '2.2.   We do not own, sell, resell, furnish, provide, prepare, manage and/or control the Vendors or the related services provided in connection thereof.'),
                      Text(
                          '2.3.   Our responsibilities are limited to: (i) facilitating the availability of the Donor Services; and (ii) serving as the limited agent of each receiver for the purpose of accepting order from the list of donors.'),
                      Divider(color: Colors.black),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('3.Registration',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      ),
                      Text(
                          '3.1 By signing up to our application you are agreeing to the terms and conditions of sale which apply.'),
                      Text(
                          'Signing up to the service means we must have the following information:'),
                      Text('  •	Your address, including the postcode.'),
                      Text(
                          '   • Your home telephone number or mobile telephone number.'),
                      Text(
                          '   • Your email address, so we can supply you with important information such as your order confirmation and pick up details'),
                      Text(
                          '3.2.   You may access the Services either by (a) registering to create an account and become a member.'),
                      Text(
                          '3.3.   You agree to provide accurate, current and complete information during the registration process and to update such information to keep it accurate, current and complete.'),
                      Text(
                          '3.5.   We reserve the right to suspend or terminate your Sahara Application Account and your access to the Services if any information provided during the registration process or thereafter provided is inaccurate, not current or incomplete.'),
                      Divider(color: Colors.black),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('4.Ordering',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      ),
                      Text(
                          '4.1.   Any contract for the supply of Food Pick Up from this application is between you and the Participating Donor. You agree to take particular care when providing us with your details and warrant that these details are accurate and complete at the time of ordering. '),
                      Text(
                          '4.2.   Any order that you place with us is subject to product availability, pick up capacity and acceptance by us and the Participating Donor. When you place your order online, we will send you a message to confirm that we have received it. You must inform us immediately if any details are incorrect.'),
                      Text(
                          '4.3.   Once the ordered food is ready to pick up, The confirmation message will specify pick up details including the approximate pick up time and the name of donor.'),
                      Divider(color: Colors.black),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('5.Pick Up',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      ),
                      Text(
                          '5.1.   Pick Up period quoted at the time of ordering are approximate only and may vary. Food has to be picked up from the address as informed to you while ordering.'),
                      Text(
                          '5.2.   If you fail to pick up the Food at the time they are ready for pick up then all risk and responsibility in relation to such Food shall pass to you. And you shall be removed from Sahara in the future.'),
                      Text(
                          '5.3.   Once you have succeeded in picking up the food, it is your responsibility to click on the ‘Order Received’ button on the Application to avoid mistakes.'),
                      Divider(color: Colors.black),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('6.Limitation of Liability',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      ),
                      Text(
                          '6.1.   Great care has been taken to ensure that the information available on this App is correct and error free. We apologize for any errors or omissions that may have occurred. We cannot warrant that use of the App will be error free or fit for purpose, timely, that defects will be corrected, or that the site or the server that makes it available are free of viruses or bugs or represents the full functionality, accuracy, reliability of the App and we do not make any warranty whatsoever, whether express or implied, relating to fitness for purpose, or accuracy.'),
                      Text(
                          '6.2.   By accepting these Terms of Use you agree to relieve us from any liability whatsoever arising from your use of information, or your consumption of any food from a Participating Donor.'),
                      Text(
                          '6.3.   We shall not be held liable for any failure or delay in picking up the Food where such failure arises as a result of any act or omission, which is outside our reasonable control such as all overwhelming and unpreventable events caused directly and exclusively by the forces of nature that can be neither anticipated, nor controlled, nor prevented by the exercise of prudence, diligence, and care, including but not limited to: war, riot, civil commotion; compliance with any law or governmental order, rule, regulation or direction and acts of third parties.'),
                      Text(
                          '6.4.   We have taken all reasonable steps to prevent Internet fraud and ensure any data collected from you is stored as securely and safely as possible. However, we cannot be held liable in the extremely unlikely event of a breach in our secure servers.'),
                      Divider(color: Colors.black),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('7.General',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      ),
                      Text(
                          '7.1.   We may subcontract any part or parts of the Services that we provide to you from time to time and we may assign or novate any part or parts of our rights under these Terms and Conditions without your consent or any requirement to notify you.'),
                      Text(
                          '7.2.   We may alter or vary the Terms and Conditions at any time without notice to you.'),
                      Text(
                          '7.3.   Do not collect or harvest any personally identifiable information on the application.'),
                      Text(
                          '7.4.   The Terms and Conditions together with the Privacy Policy, any order form constitute the entire agreement between you and us. No other terms whether expressed or implied shall form part of this Agreement. In the event of any conflict between these Terms and Conditions and any other term or provision on the application, these Terms and Conditions shall prevail.'),
                      Text(
                          '7.5.   These Terms and Conditions and our Agreement shall be governed by and construed in accordance with the laws of India. The parties hereto submit to the exclusive jurisdiction of the courts of India.'),
                      Divider(color: Colors.black),
                    ],
                  ),
                ),
              )),
            ),
            Container(
              width: double.infinity,
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                      'I agree with all the above mentioned Terms and Conditions.',
                      style: TextStyle(color: Colors.white)),
                  SizedBox(
                    height: 15,
                  ),
                  FlatButton.icon(
                      color: Colors.white,
                      splashColor: Colors.pink,
                      icon: Icon(Icons.check_circle_outline),
                      onPressed: () {
                        if (widget.isDonor) {
                          Navigator.of(context)
                              .popAndPushNamed(DonorMain.routeName);
                        } else {
                          Navigator.of(context)
                              .popAndPushNamed(ReceiverHomeScreen.routeName);
                        }
                      },
                      label: Text('I  Agree.',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700))),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
