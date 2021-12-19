import 'package:flutter/material.dart';
import 'package:inv_app/Views/general.dart';

class Modules extends StatefulWidget {
  const Modules({Key? key}) : super(key: key);
  @override
  _ModulesState createState() => _ModulesState();
}

class _ModulesState extends State<Modules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modules'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 80,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GeneralStatefulWidget()));
            },
            child: const Text(
              'Enter',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
