import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<dynamic> pages = [
    Container(
      width: double.infinity,
      child: Center(child: Text('Home 1')),
    ),
    Container(
      child: Center(child: Text('Home 2')),
    ),
    Container(
      child: Center(child: Text('Home 3')),
    ),
    Container(
      child: Center(child: Text('Home 4')),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: CusBottomNavBar()
    );
  }

  // ignore: non_constant_identifier_names
  BottomNavigationBar CusBottomNavBar() {
    return  BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Color(0xFF57b0fd),
        showUnselectedLabels: true,
        selectedItemColor: Colors.amber[800],
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        }
    );
  }
}
