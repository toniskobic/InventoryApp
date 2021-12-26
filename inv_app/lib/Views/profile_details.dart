import 'package:flutter/material.dart';
import 'package:inv_app/Views/Forms/registration.dart';
import 'package:inv_app/Views/change_password.dart';
import 'package:inv_app/Views/edit_profile.dart';
import 'package:inv_app/Views/modules.dart';
import 'package:inv_app/Views/notifications.dart';
import 'package:inv_app/api/loginService.dart';
import 'package:inv_app/Classes/user.dart';

import 'Forms/login.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({Key? key}) : super(key: key);
  @override
  HomeFormState createState() {
    return HomeFormState();
  }
}

class HomeFormState extends State<HomeForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           
          //EditProfile Button
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: Center(
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditProfile()));
                   
                  },
                  child: const Text(
                    'EDIT PROFILE',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          //ChangePassword button
           Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: Center(
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ChangePassword()));
                   
                  },
                  child: const Text(
                    'CHANGE PASSWORD',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          //notifications button
           Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: Center(
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Notifications()));
                   
                  },
                  child: const Text(
                    'NOTIFICATIONS',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          //log out
           Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: Center(
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () { 
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                  child: const Text(
                    'LOG OUT',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                   
                  ),
                  
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileDetails> {
 
  @override
  Widget build(BuildContext context) {
    //Dizajn
    return Scaffold(
      backgroundColor: Colors.white,

      //App bar
      appBar: AppBar(
        title: const Text(
          "Profile details",
          style: TextStyle(
              color: Colors.white, fontFamily: 'Mulish', fontSize: 20),
        ),
        centerTitle: true,
      ),

      //Tijelo
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Slika profila
            const Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 20),
              child: Center(
                  child: Image(image: AssetImage('asset/images/profilna.png'))),
                  
            ),
              
          const HomeForm(),
            //LogIn Obrazac
           
            const SizedBox(
              height: 40,
            ),
        

       
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
  