import 'package:flutter/material.dart';
import '../modules.dart';
import 'package:http/http.dart' as http;
import 'package:inv_app/api/loginService.dart';
import '../Assets/constants.dart' as Constants;
import 'package:inv_app/users.dart';
import 'dart:async';
import 'dart:convert';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  bool passwordHidden = true;

  User user = User(email: "", password: "");
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
          //Tekst Email
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('EMAIL/USERNAME:',
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
                  return 'Enter your email or username';
                }
                return null;
              },
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

          //LogIn Button
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
                    'LOGIN',
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

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          "LogIn",
          style: TextStyle(
              color: Colors.white, fontFamily: 'Mulish', fontSize: 20),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const Modules()));
          },
          icon: const Icon(Icons.arrow_back),
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

            //LogIn Obrazac
            const LoginForm(),

            //Forgot password Button
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text('New password request'),
                          content: const Text(
                              'New password will be send to your email address. Are you sure you want to continue?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Continue'),
                            ),
                          ],
                        );
                      }).then((exit) {
                    if (exit == null) return;

                    if (exit) {
                      // user pressed Continue button
                    } else {
                      // user pressed Cancel button
                    }
                  });
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ),

            //Don't have an account
            const SizedBox(
              height: 40,
            ),
            const Text("Don't have an account?"),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Modules()));
                  },
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),

            //LogIn Google
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Modules()));
                  },
                  child: const Text(
                    'Login with Google',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
