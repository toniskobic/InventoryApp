import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inv_app/Assets/custom.dart';
import 'package:inv_app/Classes/resource.dart';
import 'package:inv_app/Views/Home/resource_details.dart';
import 'package:inv_app/Widgets/search_widget.dart';
import 'package:inv_app/api/resourceService.dart';
import 'package:nfc_manager/nfc_manager.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Resource> resursi = [];
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
    _checkNFC();
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        // Do something with an NfcTag instance.
        print('radi nfc');
      },
    );
  }

  _checkNFC() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      print('nfc dostupan');
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text(
                        'NFC may not be supported or may be temporarily turned off.'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('GOT IT'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.0),
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
                  Expanded(child: resursiBorrowedListView())
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
                    backgroundImage: NetworkImage(resursi[index]
                        .picture!
                        .formats!
                        .thumbnail!
                        .url
                        .toString())),
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

  Widget resursiBorrowedListView() {
    return FutureBuilder<List<Resource?>>(
        future: borrowedResources(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            circularWaiting();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null && snapshot.data!.length > 0) {
              print(resursi[1].picture?.formats?.medium?.url);
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) => Card(
                      child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(resursi[index]
                                        .picture
                                        ?.formats
                                        ?.thumbnail
                                        ?.url !=
                                    null
                                ? resursi[index]
                                    .picture!
                                    .formats!
                                    .thumbnail!
                                    .url
                                    .toString()
                                : "https://helloworld.raspberrypi.org/assets/raspberry_pi_full-3b24e4193f6faf616a01c25cb915fca66883ca0cd24a3d4601c7f1092772e6bd.png"),
                          ),
                          title: Text("${resursi[index].name}"),
                          subtitle:
                              Text("Remaining: ${resursi[index].quantity}"),
                          trailing: Icon(Icons.navigate_next),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ResourceDetails(
                                        id: resursi[index].id)));
                          })));
            } else
              return Text("You didn't borrow anything yet.");
          } else {
            Get.snackbar('Oops', "Something's wrong with a server, try again.",
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red[400]);
          }
          return const SizedBox();
        });
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
