import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inv_app/Assets/custom.dart';
import 'package:inv_app/Classes/tag.dart';
import 'package:inv_app/State/filterState.dart';
import 'package:inv_app/Views/filterTag.dart';
import 'package:inv_app/api/tagService.dart';

class FilterWidget extends StatefulWidget {
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

enum Sort { nameAZ, nameZA, tagAZ, tagZA }

class _FilterWidgetState extends State<FilterWidget> {
  Sort? sort = null;
  List<Tag> tagList = [];
  List<Tag>? selectedTagsList = [];

  List<bool> _isOpen = [true, false];
  //late FilterState filterState;

  @override
  void initState() {
    super.initState();
    /* var fs = Provider.of<FilterState>(context, listen: false);

    filterState = context.read<FilterState>(); */
    /* print(filterState.sort);
    print(filterState.selectedTagsList); */

    getTags()
        .then((response) => {
              if (mounted)
                {
                  setState(() {
                    tagList = response;
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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "InventoryApp",
            style: resourceDetailsStyle(),
          ),
          centerTitle: true,
        ),

        //Tijelo
        body: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  ExpansionPanelList(
                    animationDuration: Duration(milliseconds: 500),
                    elevation: 0,
                    expandedHeaderPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    expansionCallback: (i, isOpen) => setState(() => {
                          _isOpen.assignAll([false, false]),
                          _isOpen[i] = !isOpen
                        }),
                    children: [
                      /* SORT */
                      ExpansionPanel(
<<<<<<< Updated upstream
                        //hasIcon: false,
=======
                        // hasIcon: false,
>>>>>>> Stashed changes
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text('Sort', style: filterStyle()),
                            trailing: Icon(
                              isExpanded
                                  ? FluentIcons.subtract_24_regular
                                  : FluentIcons.add_circle_24_regular,
                              color: Colors.blue,
                            ),
                          );
                        },
                        body: Column(children: <Widget>[
                          RadioListTile<Sort>(
                            title: const Text('Name A to Z'),
                            value: Sort.nameAZ,
                            groupValue: sort,
                            toggleable: true,
                            onChanged: (Sort? value) {
                              //filterState.changeSort(value);
                              setState(() {
                                sort = value;
                              });
                            },
                          ),
                          RadioListTile<Sort>(
                            title: Text('Name Z to A'),
                            value: Sort.nameZA,
                            groupValue: sort,
                            toggleable: true,
                            onChanged: (Sort? value) {
                              //filterState.changeSort(value);
                              setState(() {
                                sort = value;
                              });
                            },
                          ),
                        ]),
                        isExpanded: _isOpen[0],
                        canTapOnHeader: true,
                      ),
                      /* TAG */
                      ExpansionPanel(
<<<<<<< Updated upstream
                        //hasIcon: false,
=======
                        // hasIcon: false,
>>>>>>> Stashed changes
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text('Tag', style: filterStyle()),
                            trailing: Icon(
                              isExpanded
                                  ? FluentIcons.subtract_24_regular
                                  : FluentIcons.add_circle_24_regular,
                              color: Colors.blue,
                            ),
                          );
                        },
                        body: Column(children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 0, bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Selected: ${selectedTagsList?.length}",
                                        style: TextStyle()),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle:
                                            const TextStyle(fontSize: 15),
                                      ),
                                      onPressed: () => {
                                        /* filterState.selectedTagsList =
                                              List.from(tagList), */
                                        setState(() {
                                          selectedTagsList = List.from(tagList);
                                        }),
                                      },
                                      child: const Text('Select all'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          tagWidget(),
                        ]),
                        isExpanded: _isOpen[1],
                        canTapOnHeader: true,
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            /* filterState.changeSort(Sort.nameAZ);
                              filterState.selectedTagsList; */
                            setState(() {
                              sort = Sort.nameAZ;
                              selectedTagsList = [];
                            });
                          },
                          child: const Text('CLEAR'),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          style: filterButon(),
                          onPressed: () {
                            Navigator.pop(
                                context, FilterState(sort, selectedTagsList));
                          },
                          child: const Text('APPLY'),
                        ),
                      ],
                    )),
              )
            ])));
  }

  Widget tagWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: tagList
            .map((tagModel) => myTagsChipUIWidget(
                  tagModel: tagModel,
                  onTap: () => addPlayersTags(
                      tagModel), //filterState.addFilterTags(tagModel),
                  action: "Choose",
                  selectedList: selectedTagsList?.toList(),
                ))
            .toList(),
      ),
    );
  }

  void addPlayersTags(tagModel) async {
    if (!selectedTagsList!.contains(tagModel))
      setState(() {
        selectedTagsList?.add(tagModel);
      });
    else {
      setState(() {
        selectedTagsList?.remove(tagModel);
      });
    }
  }
}
