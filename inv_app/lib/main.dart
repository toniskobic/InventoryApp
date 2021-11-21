import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: 'Inventory App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner:false,
      home: HomepageWidget(),
        );
  }
}


class HomepageWidget extends StatelessWidget {
          @override
          Widget build(BuildContext context) {
          // Figma Flutter Generator HomepageWidget - FRAME
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[Text('Repository', textAlign: TextAlign.left, style: TextStyle(
                  color: Color.fromRGBO(50, 63, 75, 1),
                  fontFamily: 'Mulish',
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1.5 
                ),), SizedBox(height : 10),
                
                     Text('Borrowed', textAlign: TextAlign.right, style: TextStyle(
                    color: Color.fromRGBO(123, 135, 148, 1),
                    fontFamily: 'Mulish',
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1.5 
                  ),), SizedBox(height : 30),
                   //sad ide search
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, size:18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Search',
                  ),),
                  SizedBox(height:10),
                  IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt)),
                    SizedBox(height: 37),
                    

                  ],
                ),
              ),
              
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.qr_code_scanner_rounded),
                    title: Text('QR code scanner'),
                    backgroundColor: Colors.blue
                    ),
                    BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    title: Text('Home'),
                    backgroundColor: Colors.blue
                    ),
                    BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    title: Text('My profile'),
                    backgroundColor: Colors.blue
                    ),
                ],
              ),
              appBar: AppBar(
                title: Text('Inventory App'),
                centerTitle: true
              
              ),
              
            );
}
}


//-----------
