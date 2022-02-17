import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:inv_app/Assets/custom.dart';
import 'package:inv_app/State/filterState.dart';
import 'package:inv_app/Views/Home/ar.dart';
import 'package:inv_app/Views/Home/homepage.dart';
import 'package:provider/provider.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../Classes/resourceArguments.dart';
import 'Home/resource_details.dart';

class GeneralStatefulWidget extends StatefulWidget {
  const GeneralStatefulWidget({Key? key}) : super(key: key);

  @override
  State<GeneralStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<GeneralStatefulWidget> {
  int _selectedIndex = 1;
  PageController pageController = new PageController();

  @override
  void initState() {
    super.initState();
    _nfcDialog();
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        Map tagData = tag.data;
        Map tagNdef = tagData['ndef'];
        Map cachedMessage = tagNdef['cachedMessage'];
        Map records = cachedMessage['records'][0];
        String payloadAsString = utf8.decode(records['payload']);
        if (payloadAsString.contains('invapp://app/resources?id=')) {
          int id = int.parse(payloadAsString.substring(27));
          Navigator.pushNamed(
            context,
            ResourceDetails.routeName,
            arguments: ResourceArguments(id),
          );
        }
      },
    );
  }

  _nfcDialog() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text(
                        'NFC may not be supported or may be temporarily turned off.'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('GOT IT'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  static List<Widget> _widgetOptions = <Widget>[
    ARwayKitUnityScreen(),
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
      NfcManager.instance.stopSession();

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
                icon: Icon(FluentIcons.scan_object_24_filled), label: 'AR'),
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
