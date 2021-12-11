import 'package:flutter/material.dart';
import 'package:inv_app/Views/Forms/registration.dart';
import 'package:inv_app/Views/modules.dart';
import 'package:inv_app/api/loginService.dart';
import 'package:inv_app/Classes/user.dart';

class NotificationsForm extends StatefulWidget {
  const NotificationsForm({Key? key}) : super(key: key);
  @override
  NotificationsFormState createState() {
    return NotificationsFormState();
  }
}

class NotificationsFormState extends State<NotificationsForm> {
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const SizedBox(
              height: 40,
            ),

          
        ],
      ),
    );
  }

}

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  @override
  Widget build(BuildContext context) {
    //Dizajn
    return Scaffold(
      backgroundColor: Colors.white,

      //App bar
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
              color: Colors.white, fontFamily: 'Mulish', fontSize: 20),
        ),
        centerTitle: true,
      ),

      //Tijelo
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Slika loga
            
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
    );
  }
}