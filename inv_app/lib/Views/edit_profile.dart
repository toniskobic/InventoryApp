import 'package:flutter/material.dart';
import 'package:inv_app/Views/Forms/registration.dart';
import 'package:inv_app/Views/modules.dart';
import 'package:inv_app/api/loginService.dart';
import 'package:inv_app/Classes/user.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({Key? key}) : super(key: key);
  @override
  EditProfileFormState createState() {
    return EditProfileFormState();
  }
}

class EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();

  bool passwordHidden = true;

  User user = User();
  void _logIn() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      LoginRequest(user, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Tekst First name
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('FIRST NAME:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),

          //TextBox za first name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),

          //Tekst Last name
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('LAST NAME:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),

          //TextBox za last name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),

          //Tekst email
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('EMAIL:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),

          //TextBox za email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),

          //Tekst Password
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('PASSWORD:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          //TextBox za lozinku
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              onSaved: (val) => user.password = val,
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
                  return 'Enter your password';
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
                    _logIn();
                    /*
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Modules()));
                    */
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

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //Varijable
  bool passwordHidden = true;
  var lozinka = "";
  var email = "";

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
            const EditProfileForm(),
          ],
        ),
      ),
    );
  }
}
