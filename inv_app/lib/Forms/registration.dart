import 'package:flutter/material.dart';
import 'package:inv_app/Forms/login.dart';
import 'package:inv_app/api/registracijaService.dart';
import 'package:inv_app/users.dart';
import 'package:get/get.dart';

/* class MyForm extends StatefulWidget {
  int id;
  MyForm(this.id);
  @override
  _MyFormState createState() => _MyFormState(this.id);
}
 */

const _fontFamily = 'Mulish';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  //Varijable
  final formKey = GlobalKey<FormState>();
  bool passwordHidden = true;

  User user = User();

  void _signUp() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      signUp(user).then((response) => {print(response)}).catchError((e) {
        Get.snackbar('Error', '$e',
            duration: Duration(seconds: 3), backgroundColor: Colors.red[100]);
        print('$e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Registration",
          style: TextStyle(
            color: Colors.white,
            fontFamily: _fontFamily,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                // Logo
                /* const Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 50),
              child: Center(
                  child: Image(image: AssetImage('asset/images/logo.png'))),
            ), */

                //Name
                const Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('FIRST NAME:',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: _fontFamily,
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    onSaved: (val) => user.name = val,
                    validator: (val) => val!.length < 6
                        ? 'Minimum characters requiered 6'
                        : null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'John',
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),

                //Last Name
                const Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('LAST NAME:',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: _fontFamily,
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    onSaved: (val) => user.surname = val,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Hemingway',
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),

                //Username
                const Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('USERNAME:',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: _fontFamily,
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    onSaved: (val) => user.username = val,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'jhemingway',
                        prefixIcon: Icon(Icons.account_circle_outlined)),
                  ),
                ),

                //Email
                const Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15.0, bottom: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('EMAIL:',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: _fontFamily,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    onSaved: (val) => user.email = val,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'name@email.com',
                        prefixIcon: Icon(Icons.email)),
                  ),
                ),

                //Password
                const Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('PASSWORD:',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                  ),
                ),
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
                  ),
                ),

                //LogIn Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Container(
                      height: 40,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50)),
                      child: ElevatedButton(
                          child: const Text(
                            'SIGN UP',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          onPressed: _signUp)),
                ),

                //Don't have an account
                const SizedBox(
                  height: 40,
                ),
                const Text("Already have an account?"),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: Container(
                      height: 40,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                          child: const Text("Login"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          })
                      /* child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Modules()));
                  },
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ), */
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
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: const Text(
                        'Sign up with Google',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
