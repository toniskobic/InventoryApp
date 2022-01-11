import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inv_app/Assets/custom.dart';

class FilterWidget extends StatefulWidget {
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool _customTileExpanded = false;

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
      body: Column(
        children: <Widget>[
          /* Sort */
          ExpansionTile(
            title: Text('Sort', style: filterStyle()),
            trailing: FaIcon(
              _customTileExpanded
                  ? FontAwesomeIcons.minus
                  : FontAwesomeIcons.plus,
              color: Colors.blue,
            ),
            children: <Widget>[
              ListTile(title: Text('Name A to Z')),
              ListTile(title: Text('Name Z to A')),
              ListTile(title: Text('Tag A to Z')),
              ListTile(title: Text('Tag Z to A')),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded = expanded);
            },
          ),
          divider(),

          /* Status */
          ExpansionTile(
            title: Text('Status', style: filterStyle()),
            trailing: FaIcon(
              _customTileExpanded
                  ? FontAwesomeIcons.minus
                  : FontAwesomeIcons.plus,
              color: Colors.blue,
            ),
            children: <Widget>[
              ListTile(title: Text('Available')),
              ListTile(title: Text('Borrowed')),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded = expanded);
            },
          ),
          divider(),
          /* Tag */
          ExpansionTile(
            title: Text('Tag', style: filterStyle()),
            trailing: FaIcon(
              _customTileExpanded
                  ? FontAwesomeIcons.minus
                  : FontAwesomeIcons.plus,
              color: Colors.blue,
            ),
            children: <Widget>[
              ListTile(title: Text('Available')),
              ListTile(title: Text('Borrowed')),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded = expanded);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
                width: 247,
                height: 34,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Stack(children: <Widget>[
                  Positioned(
                      top: 9,
                      left: 0,
                      child: Text(
                        'CLEAN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(47, 128, 237, 1),
                            fontFamily: 'Mulish',
                            fontSize: 15,
                            letterSpacing: 1.25,
                            fontWeight: FontWeight.normal,
                            height: 1.5 /*PERCENT not supported*/
                            ),
                      )),
                ])),
          ),
        ],
      ),
    );
  }
}
