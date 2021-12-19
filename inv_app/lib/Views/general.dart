import 'package:flutter/material.dart';
import 'package:inv_app/Views/Home/homepage.dart';

class GeneralStatefulWidget extends StatefulWidget {
  const GeneralStatefulWidget({Key? key}) : super(key: key);

  @override
  State<GeneralStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<GeneralStatefulWidget> {
  int _selectedIndex = 1;
  PageController pageController = new PageController();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: QR code scanner',
      style: optionStyle,
    ),
    Homepage(),
    Text(
      'Index 2: My profile',
      style: optionStyle,
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
        appBar: AppBar(title: Text('Inventory App'), centerTitle: true),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner_rounded),
                title: Text('QR code scanner')),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('My profile')),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
        ));
  }
}
