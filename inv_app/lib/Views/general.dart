import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:inv_app/Assets/custom.dart';
import 'package:inv_app/Model/userStorage.dart';
import 'package:inv_app/State/filterState.dart';
import 'package:inv_app/Views/Home/homepage.dart';
import 'package:inv_app/boxes.dart';
import 'package:provider/provider.dart';

class GeneralStatefulWidget extends StatefulWidget {
  const GeneralStatefulWidget({Key? key}) : super(key: key);

  @override
  State<GeneralStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<GeneralStatefulWidget> {
  int _selectedIndex = 1;
  PageController pageController = new PageController();

  /* @override
  void initState() {
    super.initState();

    Box box = Hive.box<UserStorage>('users');
    UserStorage userId = box.getAt(0);

    print(userId.userId);
  } */

  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: QR code scanner',
      style: navBarStyle(),
    ),
    Homepage(),
    Text(
      'Index 2: My profile',
      style: navBarStyle(),
    ),
  ];

  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
    if (pageController.hasClients) {
      pageController.animateToPage(index,
          duration: Duration(seconds: 1), curve: Curves.decelerate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Inventory App'),
            centerTitle: true,
            backgroundColor: Colors.white70,
            foregroundColor: Colors.black),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner_rounded),
                label: 'QR code scanner'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'My profile'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
        ));
  }
}
