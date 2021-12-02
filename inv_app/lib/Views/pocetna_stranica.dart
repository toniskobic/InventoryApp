import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inv_app/api/resourceService.dart';

class HomepageWidget extends StatelessWidget {
  const HomepageWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator HomepageWidget - FRAME

    /* Widget returnText() {
      var text;
      getResources()
          .then((response) => {
                text = Text(
                  '$response',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(50, 63, 75, 1),
                      fontFamily: 'Mulish',
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1.5),
                ),
              })
          .catchError((e) {
        Get.snackbar('Error', '$e',
            duration: Duration(seconds: 2), backgroundColor: Colors.red[100]);
        print('$e');
      });
      return text;
    } */

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Repository',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(50, 63, 75, 1),
                  fontFamily: 'Mulish',
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1.5),
            ),
            SizedBox(height: 10),

            Text(
              'Borrowed',
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Color.fromRGBO(123, 135, 148, 1),
                  fontFamily: 'Mulish',
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1.5),
            ),
            SizedBox(height: 30),
            //sad ide search
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, size: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Search',
              ),
            ),
            SizedBox(height: 10, width: 50),
            new SizedBox(
                height: 20.0,
                width: 20.0,
                child: new IconButton(
                  onPressed: () {},
                  iconSize: 20.0,
                  icon: Icon(Icons.filter_alt),
                  alignment: Alignment.bottomLeft,
                )),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner_rounded),
              title: Text('QR code scanner'),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              title: Text('Home'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('My profile'),
              backgroundColor: Colors.black),
        ],
      ),
      appBar: AppBar(title: Text('Inventory App'), centerTitle: true),
    );
  }
}
