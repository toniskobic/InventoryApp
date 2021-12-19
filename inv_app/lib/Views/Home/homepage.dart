import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inv_app/Classes/resource.dart';
import 'package:inv_app/api/resourceService.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class ResourceList extends StatelessWidget {
  const ResourceList({Key? key, required this.resource}) : super(key: key);

  final List<Resource> resource;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: resource.length,
      itemBuilder: (context, index) {
        return Text('resource[index].name');
      },
    );
  }
}

class _HomepageState extends State<Homepage> {
  List<Resource> resursi = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResources()
        .then((response) => {
              if (mounted)
                {
                  setState(() {
                    resursi = response;
                  })
                }
            })
        .catchError((e) {
      Get.snackbar('Error', '$e',
          duration: Duration(seconds: 2), backgroundColor: Colors.red[100]);
      print('$e');
    });
  }

  Widget resursiListView() {
    if (resursi.contains(null) || resursi.length < 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
      ));
    }
    return ListView.builder(
        itemCount: resursi.length,
        itemBuilder: (context, index) => Card(
              child: ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://www.mytrendyphone.eu/images/Foldable-Drone-Pro-2-with-HD-Dual-Camera-E99-1800mAh-up-to-20min-18062021-01-p.jpg")),
                  title: Text("${resursi[index].name}"),
                  subtitle: Text("Remaining: ${resursi[index].quantity}"),
                  trailing: Icon(Icons.navigate_next),
                  onTap: () => print("Dohvati $index. resurs")),
            ));
  }

  @override
  Widget build(BuildContext context) {
    //return Scaffold(body: resursiListView());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Repository',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(50, 63, 75, 1),
                  fontFamily: 'Mulish',
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1.5),
            ),
            SizedBox(height: 10),

            Text(
              'Borrowed',
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Color.fromRGBO(123, 135, 148, 1),
                  fontFamily: 'Mulish',
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1.5),
            ),
            SizedBox(height: 30),
            //sad ide search
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, size: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Search',
              ),
            ),
            SizedBox(height: 10, width: 50),
            new SizedBox(
                height: 20.0,
                width: 20.0,
                child: new IconButton(
                  onPressed: () {},
                  iconSize: 20.0,
                  icon: Icon(Icons.filter_alt),
                  alignment: Alignment.bottomLeft,
                )),
            SizedBox(height: 10),
            Expanded(child: resursiListView())
          ],
        ),
      ),
    );
  }
}
