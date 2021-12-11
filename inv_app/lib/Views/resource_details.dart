import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inv_app/Views/Forms/registration.dart';
import 'package:inv_app/Views/modules.dart';
import 'package:inv_app/api/loginService.dart';
import 'package:inv_app/Classes/user.dart';

class ResourceDetailsForm extends StatefulWidget {
  const ResourceDetailsForm({Key? key}) : super(key: key);
  @override
  ResourceDetailsFormState createState() {
    return ResourceDetailsFormState();
  }
}

class ResourceDetailsFormState extends State<ResourceDetailsForm> {
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

class ResourceDetails extends StatefulWidget {
  const ResourceDetails({Key? key}) : super(key: key);
  @override
  _ResourceDetailsState createState() => _ResourceDetailsState();
}

class _ResourceDetailsState extends State<ResourceDetails> {

  @override
  Widget build(BuildContext context) {
    //Dizajn
    return Scaffold(
      backgroundColor: Colors.white,

      //App bar
      appBar: AppBar(
        title: const Text(
          "Resource name",
          style: TextStyle(
              color: Colors.white, fontFamily: 'Mulish', fontSize: 20),
        ),
        centerTitle: true,
      ),
      
      //Tijelo
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
             //Slika resursa
            const Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 20),
              child: Center(
                  child: Image(image: AssetImage('asset/images/resource_pic.png'))),
                  
            ),
            const SizedBox(
              height: 20,
            ),

            //tekst resource description
            const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Resource description:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 20)),
            ),
          ),
        Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey,
          indent:20,
          endIndent: 20,
        ),

         //datum VRATITI SE OVJDE 
            const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Loan date      ->      Expected return date',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 20)),
                  
            ),
            
          ),
           const Padding(
            padding:
                EdgeInsets.only(left: 20.0, right: 30.0, top: 0, bottom: 0),
            child: Align(
              alignment: Alignment.centerRight,
              child:  Icon(Icons.date_range_rounded, size: 35, color: Colors.blue,)
                  
            ),
            
          ),

        Divider(
          height: 40,
          thickness: 1,
          color: Colors.grey,
          indent:20,
          endIndent: 20,
        ),

           //Qantity
            const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Ouantity:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 20)),
            ),
          ),
        Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey,
          indent:20,
          endIndent: 20,
        ),

             //Tag
            const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Tag:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 20)),
            ),
          ),
        Divider(
          height: 25,
          thickness: 1,
          color: Colors.grey,
          indent:20,
          endIndent: 20,
        ),

         //Status
            const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Status:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 20)),
            ),
          ),
        Divider(
          height: 25,
          thickness: 1,
          color: Colors.grey,
          indent:20,
          endIndent: 20,
        ),

         //Location:
            const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Location:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 20)),
            ),
          ),
          const Padding(
            padding:
                EdgeInsets.only(left: 20.0, right: 30.0, top: 0, bottom: 0),
            child: Align(
              alignment: Alignment.centerRight,
              child:  Icon(Icons.center_focus_strong ,size: 35, color: Colors.blue,)
                  
            ),
            
          ),
        Divider(
          height: 40,
          thickness: 1,
          color: Colors.grey,
          indent:20,
          endIndent: 20,
        ),
        
        Center(
  child:  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      
      RaisedButton(
        color: Colors.blue,

        child: Text("RETURN"),
        onPressed: null,
      ),
      SizedBox(width: 5),
      RaisedButton(
        color: Colors.blue,
        child: Text("BORROW"),
        onPressed: null,
      ),
    ],
  ),
)
            
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