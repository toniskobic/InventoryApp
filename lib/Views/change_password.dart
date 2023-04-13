import 'package:flutter/material.dart';
import 'package:inv_app/Views/Forms/registration.dart';
import 'package:inv_app/Views/modules.dart';
import 'package:inv_app/api/newPasswordService.dart';
import 'package:inv_app/Classes/user.dart';
import 'package:inv_app/api/resourceService.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);
  @override
  ChangePasswordFormState createState() {
    return ChangePasswordFormState();
  }
}

class ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();

  bool passwordHidden = true;

  String currentPass = "";
  String newPass = "";
  String confirmPass = "";

  void _saveNewPassword() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      newPasswordRequest(context, currentPass, newPass, confirmPass);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Tekst current password
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('CURRENT PASSWORD:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          //TextBox CURRENT PASSWORD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              onSaved: (val) => currentPass = val!,
              obscureText: !passwordHidden,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: '********',
                  prefixIcon: const Icon(Icons.lock),
                  suffix: InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(passwordHidden
                        ? Icons.visibility
                        : Icons.visibility_off),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your current password';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 40,
          ),

          //Tekst new Password
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('NEW PASSWORD:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          //TextBox za lozinku
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              onSaved: (val) => newPass = val!,
              obscureText: !passwordHidden,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: '********',
                  prefixIcon: const Icon(Icons.lock),
                  suffix: InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(passwordHidden
                        ? Icons.visibility
                        : Icons.visibility_off),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your new password';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 40,
          ),

          //Tekst confirm password
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('CONFIRM PASSWORD:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          //TextBox za confirm password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              onSaved: (val) => confirmPass = val!,
              obscureText: !passwordHidden,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: '********',
                  prefixIcon: const Icon(Icons.lock),
                  suffix: InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(passwordHidden
                        ? Icons.visibility
                        : Icons.visibility_off),
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Confirm your new password';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 40,
          ),

          //Save changes Button
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 0, bottom: 0),
            child: Center(
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    _saveNewPassword();
                  },
                  child: const Text(
                    'SAVE CHANGES',
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

  //Funkcije
  //Prikaz/Sakrivanje lozinke
  void _togglePasswordView() {
    setState(() {
      passwordHidden = !passwordHidden;
    });
  }
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  //Varijable
  bool passwordHidden = true;
  var current_password = "";
  var new_password = "";

  @override
  Widget build(BuildContext context) {
    //Dizajn
    return Scaffold(
      backgroundColor: Colors.white,

      //App bar
      appBar: AppBar(
        title: const Text(
          "Edit profile",
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
              padding: EdgeInsets.only(top: 10.0, bottom: 10),
              child: Center(
                  child: Image(image: AssetImage('asset/images/profilna.png'))),
            ),

            //LogIn Obrazac
            const ChangePasswordForm(),
          ],
        ),
      ),
    );
  }
}
