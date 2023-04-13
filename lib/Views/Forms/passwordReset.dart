import 'package:flutter/material.dart';
import 'package:inv_app/api/passwordResetService.dart';
import 'package:inv_app/Classes/user.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);
  @override
  PasswordResetState createState() {
    return PasswordResetState();
  }
}

class PasswordResetState extends State<PasswordReset> {
  final _formKey = GlobalKey<FormState>();

  bool passwordHidden = true;

  User user = User();
  void _newPasswordRequest() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      NewPasswordRequest(user, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Tekst Email
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  'Please enter your email so that we can send you a new password for your account.',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),

          //TextBox za email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              onSaved: (val) => user.email = val,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'name@email.com',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your email.';
                }
                return null;
              },
            ),
          ),

          //Send Button
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
                    _newPasswordRequest();
                  },
                  child: const Text(
                    'SEND',
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

class PassReset extends StatefulWidget {
  const PassReset({Key? key}) : super(key: key);
  @override
  _PassResetState createState() => _PassResetState();
}

class _PassResetState extends State<PassReset> {
  //Varijable
  var email = "";

  @override
  Widget build(BuildContext context) {
    //Dizajn
    return Scaffold(
      backgroundColor: Colors.white,

      //App bar
      appBar: AppBar(
        title: const Text(
          "New password",
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
            const Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 40),
              child: Center(
                  child: Image(image: AssetImage('asset/images/logo.png'))),
            ),

            //New password form
            const PasswordReset(),
          ],
        ),
      ),
    );
  }
}
