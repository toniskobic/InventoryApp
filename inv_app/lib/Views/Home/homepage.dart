import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inv_app/Assets/custom.dart';
import 'package:inv_app/Classes/resource.dart';
import 'package:inv_app/Views/Home/resource_details.dart';
import 'package:inv_app/Widgets/search_widget.dart';
import 'package:inv_app/api/resourceService.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Resource> resursi = [];
  bool isLoading = false;
  String searchText = '';

  late List<Resource> resourceSearch = resursi;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBar(
                    backgroundColor: Colors.white,
                    bottom: TabBar(labelColor: Colors.black, tabs: [
                      Text(
                        'Repository',
                        style: tabBarStyle(),
                      ),
                      Text(
                        'Borrowed',
                        style: tabBarStyle(),
                      )
                    ]))),
            body: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      buildSearch(),
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
                Text('Borrowed')
              ],
            )));
  }

  Widget resursiListView() {
    if (resursi.length < 0) {
      return circularWaiting();
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ResourceDetails(id: resursi[index].id)));
                })));
  }

  Widget buildSearch() => SearchWidget(
      text: searchText, hintText: 'Resource name', onChanged: searchResource);

  void searchResource(String searchText) {
    final resourcesFound = resourceSearch.where((resurs) {
      final title = resurs.name!.toLowerCase();
      final search = searchText.toLowerCase();

      return title.contains(search);
    }).toList();

    setState(() {
      this.searchText = searchText;
      this.resursi = resourcesFound;
    });
  }
}
