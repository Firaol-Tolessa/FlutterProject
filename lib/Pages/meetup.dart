import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meetup/Pages/Order.dart';
import 'package:meetup/Pages/home.dart';
import 'package:meetup/authServices/service.dart';

import 'myOrders.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Authservices _auth = new Authservices();

  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Screen(),
    order(),
    myOrders(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff3b7a3e),
          centerTitle: true,
          title: Text("MeetUP",
              style: TextStyle(
                  letterSpacing: 5, fontSize: 20, fontWeight: FontWeight.bold)),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      _auth.signOut();
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/login");
                    },
                    child: Icon(
                      Icons.logout,
                      size: 26.0,
                    ),
                  ),
                ]))
          ],
        ),
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ) //New
        ,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'MyOrders',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Order',
              backgroundColor: Colors.green,
            ),
          ],
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
