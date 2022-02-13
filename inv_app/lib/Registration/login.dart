import 'package:flutter/material.dart';
import 'package:inv_app/Registration/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Varijable
  bool passwordHidden = true;

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
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const Registration()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
      ),
  
      //Tijelo LogIn-a
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Slika loga
            const Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 50),
              child: Center(
                  child: Image(image: AssetImage('asset/images/logo.png'))),
            ),

            //Tekst Email
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('EMAIL:',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ),
            ),

            //TextBox za email
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'name@email.com',
                    prefixIcon: Icon(Icons.email)),
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
              child: TextField(
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
              ),
            ),

            //LogIn Button
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),

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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const Registration()));
                  },
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),

            //OR
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 10, bottom: 0),
              child: Text(
                'OR',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),

            //LogIn Google
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      passwordHidden = !passwordHidden;
    });
  }
}
