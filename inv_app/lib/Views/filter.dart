import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inv_app/Assets/custom.dart';
import 'package:inv_app/Classes/tag.dart';
import 'package:inv_app/Views/filterTag.dart';

class FilterWidget extends StatefulWidget {
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

enum Status { available, borrowed }
enum Sort { nameAZ, nameZA, tagAZ, tagZA }

class _FilterWidgetState extends State<FilterWidget> {
  bool _sortExpanded = false;
  bool _statusExpanded = false;
  bool _tagExpanded = false;

  Status? _status = Status.available;
  Sort? _sort = Sort.nameAZ;

  List<Tag> tagList = [
    Tag(
      id: 1,
      name: "chipset",
    ),
    Tag(id: 2, name: "pen")
  ];
  List<Tag>? selectedTagsList = [];

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
        child: Column(
          children: <Widget>[
            /* Sort */
            ExpansionTile(
              title: Text('Sort', style: filterStyle()),
              trailing: FaIcon(
                _sortExpanded ? FontAwesomeIcons.minus : FontAwesomeIcons.plus,
                color: Colors.blue,
              ),
              children: <Widget>[
                ListTile(
                  title: Text('Name A to Z'),
                  leading: Radio<Sort>(
                    value: Sort.nameAZ,
                    groupValue: _sort,
                    onChanged: (Sort? value) {
                      setState(() {
                        _sort = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Name Z to A'),
                  leading: Radio<Sort>(
                    value: Sort.nameZA,
                    groupValue: _sort,
                    onChanged: (Sort? value) {
                      setState(() {
                        _sort = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Tag A to Z'),
                  leading: Radio<Sort>(
                    value: Sort.tagAZ,
                    groupValue: _sort,
                    onChanged: (Sort? value) {
                      setState(() {
                        _sort = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Tag Z to A'),
                  leading: Radio<Sort>(
                    value: Sort.tagZA,
                    groupValue: _sort,
                    onChanged: (Sort? value) {
                      setState(() {
                        _sort = value;
                      });
                    },
                  ),
                ),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() => _sortExpanded = expanded);
              },
            ),
            divider(),

            /* Status */
            ExpansionTile(
              title: Text('Status', style: filterStyle()),
              trailing: FaIcon(
                _statusExpanded
                    ? FontAwesomeIcons.minus
                    : FontAwesomeIcons.plus,
                color: Colors.blue,
              ),
              children: <Widget>[
                ListTile(
                  title: const Text('Available'),
                  leading: Radio<Status>(
                    value: Status.available,
                    groupValue: _status,
                    onChanged: (Status? value) {
                      setState(() {
                        _status = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Borrowed'),
                  leading: Radio<Status>(
                    value: Status.borrowed,
                    groupValue: _status,
                    onChanged: (Status? value) {
                      setState(() {
                        _status = value;
                      });
                    },
                  ),
                )
              ],
              onExpansionChanged: (bool expanded) {
                setState(() => _statusExpanded = expanded);
              },
            ),
            divider(),
            /* Tag */
            ExpansionTile(
              title: Text('Tag', style: filterStyle()),
              trailing: FaIcon(
                _tagExpanded ? FontAwesomeIcons.minus : FontAwesomeIcons.plus,
                color: Colors.blue,
              ),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 0, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Selected: ", style: TextStyle()),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Select all", style: TextStyle()),
                        ],
                      )
                    ],
                  ),
                ),
                tagWidget(),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() => _tagExpanded = expanded);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("CLEAR",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 30),
          ElevatedButton(
            style: filterButon(),
            onPressed: () {},
            child: const Text('APPLY'),
          ),
        ],
      ),
    );
  }

  Widget tagWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Wrap(
        alignment: WrapAlignment.start,
        children: tagList
            .map((tagModel) => myTagsChipUIWidget(
                  tagModel: tagModel,
                  onTap: () => addPlayersTags(tagModel),
                  action: "Choose",
                  selected: true,
                ))
            .toList(),
      ),
    ]);
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
