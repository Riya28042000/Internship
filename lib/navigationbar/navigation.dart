import 'package:flutter/material.dart';
import 'package:regis_login/navigationbar/account.dart';
import 'package:regis_login/navigationbar/message.dart';
import 'package:regis_login/navigationbar/payment.dart';
import 'package:regis_login/pages/dashboard.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
   final List<Widget> _children = [
  DashBoard(),
  Message(),
  Payment(),
  Account()
  ];
  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
   bottomNavigationBar: BottomNavigationBar(
     backgroundColor: Colors.white,
     selectedItemColor: Colors.grey,
     unselectedItemColor: Colors.grey,
     
onTap: onTabTapped,
     items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.home,color: Colors.grey,),
           title: new Text('Home',style: TextStyle(color:Colors.grey),),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.mail,color: Colors.grey,),
           title: new Text('Message',style: TextStyle(color:Colors.grey),),
         ),
           BottomNavigationBarItem(
           icon: Icon(Icons.payment,color: Colors.grey,),
           title: Text('Payment',style: TextStyle(color:Colors.grey),)
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person,color: Colors.grey,),
           title: Text('Account',style: TextStyle(color:Colors.grey),)
         )
       ],
   ),
    );
  }
}