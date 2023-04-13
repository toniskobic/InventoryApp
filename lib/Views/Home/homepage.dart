import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inv_app/Assets/custom.dart';
import 'package:inv_app/Classes/borrowed.dart';
import 'package:inv_app/Classes/resource.dart';
import 'package:inv_app/Classes/resourceArguments.dart';
import 'package:inv_app/State/filterState.dart';
import 'package:inv_app/Views/Home/borrowed_details.dart';
import 'package:inv_app/Views/Home/resource_details.dart';
import 'package:inv_app/Views/filter.dart';
import 'package:inv_app/Widgets/search_widget.dart';
import 'package:inv_app/api/resourceService.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Resource> resources = [];
  List<Resource> resursi = [];
  List<Borrowed> borrowedResourcesList = [];
  String searchText = '';

  late List<Resource> resourceSearch = resursi;
  late FilterState filterState = FilterState(null, []);

  @override
  void initState() {
    super.initState();

    updateResource();
    setState(() {
      resources = List.from(resursi);
    });
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
            /* Repository */
            Column(children: [
              Row(children: [
                buildSearch(),
                IconButton(
                  onPressed: () async {
                    final data = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => FilterWidget(),
                      ),
                    );
                    data != null
                        ? {
                            setState(() {
                              filterState = data;
                            })
                          }
                        : print("nullllll");
                  },
                  icon: Icon(FluentIcons.apps_list_24_regular),
                  alignment: Alignment.centerLeft,
                ),
              ]),
              Expanded(child: resursiListView()),
            ]),
            /* Borrowed */
            Column(children: [
              Row(children: [
                buildSearch(),
              ]),
              Expanded(child: resursiBorrowedListView())
            ]),
          ],
        ),
      ),
    );
  }

  Widget resursiListView() {
    if (resursi.length != resources.length) {
      updateResource();
      setState(() {
        resources = List.from(resursi);
      });
    }
    if (resursi.length == 0) {
      return circularWaiting();
    }
    if (filterState.sort != null) {
      if (filterState.sort == Sort.nameAZ) {
        resursi.sort(
            (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      } else if (filterState.sort == Sort.nameZA) {
        resursi.sort(
            (b, a) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      }
    }
    if (filterState.selectedTagsList!.isNotEmpty) {
      var toFilter = [];

      filterState.selectedTagsList!.forEach((tag) {
        resursi.forEach((resurs) {
          if (resurs.tags != []) {
            resurs.tags!.forEach((tagR) {
              if (tagR.id == tag.id) {
                toFilter.add(resurs);
              }
            });
          }
        });
      });
      resursi.removeWhere((resurs) => !toFilter.contains(resurs));
    }
    print(resursi.length);
    return ListView.builder(
        itemCount: resursi.length,
        itemBuilder: (context, index) => resursi[index].quantity! > 0
            ? Card(
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
                            : "https://helloworld.raspberrypi.org/assets/raspberry_pi_full-3b24e4193f6faf616a01c25cb915fca66883ca0cd24a3d4601c7f1092772e6bd.png")),
                    title: Text("${resursi[index].name}"),
                    subtitle: Text("Remaining: ${resursi[index].quantity}"),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.pushNamed(context, ResourceDetails.routeName,
                          arguments: ResourceArguments(resursi[index].id));
                    }))
            : SizedBox.shrink());
  }

  Widget resursiBorrowedListView() {
    return FutureBuilder<List<Borrowed?>>(
        future: borrowedResources(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            circularWaiting();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null && snapshot.data!.length > 0) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) => snapshot
                              .data![index]!.resource!.quantity! >
                          0 && snapshot
                              .data![index]!.status == true
                      ? Card(
                          child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                            .data?[index]
                                            ?.resource
                                            ?.picture
                                            ?.formats
                                            ?.thumbnail
                                            ?.url !=
                                        null
                                    ? snapshot.data![index]!.resource!.picture!
                                        .formats!.thumbnail!.url
                                        .toString()
                                    : "https://helloworld.raspberrypi.org/assets/raspberry_pi_full-3b24e4193f6faf616a01c25cb915fca66883ca0cd24a3d4601c7f1092772e6bd.png"),
                              ),
                              title: Text(
                                  "${snapshot.data![index]!.resource!.name}"),
                              subtitle: Text(
                                  "Borrowed: ${snapshot.data![index]!.Quantity}"),
                              trailing: Icon(Icons.navigate_next),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BorrowedResourceDetails(
                                            id: snapshot.data![index]!.id,
                                            name: snapshot.data![index]!
                                                .resource!.name)));
                              }))
                      : SizedBox.shrink());
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

  void updateResource() {
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
