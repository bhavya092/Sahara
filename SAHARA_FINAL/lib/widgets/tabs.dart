import 'package:flutter/material.dart';
import '../screens/pastorders.dart';
import '../screens/ongoing_orders.dart';
class Tabs extends StatefulWidget {
  static const routeName='tabs';
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,//selects the default tab when the app opens
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Your Orders',style: TextStyle(color: Colors.white),),
            bottom: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.donut_large),
                text: 'Current',
              ),
              Tab(
                icon: Icon(Icons.done_all),
                text: 'Past',
              )
            ]),
          ),
          body: TabBarView(children: [
         PastOrdersScreen(), OngoingOrders(),
          ]),
        ));
  }
}