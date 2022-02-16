import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inv_app/Assets/custom.dart';
import 'package:inv_app/Classes/resource.dart';
import 'package:inv_app/api/resourceService.dart';

class ResourceDetailsForm extends StatefulWidget {
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
  final int id;
  const ResourceDetails({Key? key, required this.id}) : super(key: key);

  static const routeName = '/resources';

  @override
  _ResourceDetailsState createState() => _ResourceDetailsState();
}

class _ResourceDetailsState extends State<ResourceDetails> {
  DateTime date = DateTime.now();
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(DateTime.now().year - 5),
      end: DateTime(DateTime.now().year + 5));

//ispisuje selektirani datum u button
  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

//ispisuje datum from
  String getFrom() {
    if (dateRange == null) {
      return 'Loan date ';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange.start);
    }
  }

//ispisuje datum until
  String getUntil() {
    if (dateRange == null) {
      return 'Expected return date';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange.end);
    }
  }

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
          child: FutureBuilder<Resource?>(
              future: getResourceById(widget.id),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? circularWaiting()
                    : Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          //Slika resursa
                          Padding(
                              padding: EdgeInsets.only(top: 0.0, bottom: 20),
                              child: Center(
                                child: Image(
                                  image: NetworkImage(snapshot.data?.picture
                                              ?.formats?.thumbnail?.url !=
                                          null
                                      ? snapshot.data!.picture!.formats!
                                          .thumbnail!.url
                                          .toString()
                                      : "https://helloworld.raspberrypi.org/assets/raspberry_pi_full-3b24e4193f6faf616a01c25cb915fca66883ca0cd24a3d4601c7f1092772e6bd.png"),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),

                          //tekst resource description
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 0, bottom: 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  'Resource description: ${snapshot.data?.description == null ? "No description" : snapshot.data?.description}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                          ),
                          Divider(
                            height: 20,
                            thickness: 1,
                            color: Colors.grey,
                            indent: 20,
                            endIndent: 20,
                          ),

                          //datum
                          Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 5),
                              Text(
                                'Loan date',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              Icon(Icons.arrow_right_alt_outlined,
                                  size: 35, color: Colors.blue),
                              SizedBox(width: 5),
                              Text(
                                'Expected return date',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          )),

                          Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 5),
                              RaisedButton(
                                color: Colors.white,
                                child: Text(getFrom()),
                                onPressed: () => pickDateRange(context),
                              ),
                              Icon(Icons.arrow_right_alt_outlined,
                                  size: 35, color: Colors.blue),
                              SizedBox(width: 5),
                              RaisedButton(
                                color: Colors.white,
                                child: Text(getUntil()),
                                onPressed: () => pickDateRange(context),
                              ),
                            ],
                          )),

                          const Padding(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 30.0, top: 0, bottom: 0),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.date_range_rounded,
                                  size: 35,
                                  color: Colors.blue,
                                )

                                /* ne razumijem zasto taj on pressed ne radi al to bi bilo idealno rjesenje
              IconButton(
                onPressed: ()=>pickDateRange(context), 
                icon: Icon(Icons.date_range_rounded, size: 35, color: Colors.blue,))*/
                                ),
                          ),

                          Divider(
                            height: 40,
                            thickness: 1,
                            color: Colors.grey,
                            indent: 20,
                            endIndent: 20,
                          ),

                          //Qantity
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 0, bottom: 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  'Ouantity: ${snapshot.data?.quantity}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                          ),
                          Divider(
                            height: 20,
                            thickness: 1,
                            color: Colors.grey,
                            indent: 20,
                            endIndent: 20,
                          ),

                          //Tag
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 0, bottom: 0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text('Tags:',
                                            style: resourceDetailsStyle()),
                                        tagsWidget(snapshot.data?.tags),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                          Divider(
                            height: 25,
                            thickness: 1,
                            color: Colors.grey,
                            indent: 20,
                            endIndent: 20,
                          ),

                          //Status
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 0, bottom: 0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Status: ${snapshot.data?.status == null ? "No status" : snapshot.data?.status}',
                                  textAlign: TextAlign.left,
                                  style: resourceDetailsStyle(),
                                )),
                          ),
                          Divider(
                            height: 25,
                            thickness: 1,
                            color: Colors.grey,
                            indent: 20,
                            endIndent: 20,
                          ),

                          //Location:
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 0, bottom: 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Location:',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 30.0, top: 0, bottom: 0),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.center_focus_strong,
                                  size: 35,
                                  color: Colors.blue,
                                )),
                          ),
                          Divider(
                            height: 40,
                            thickness: 1,
                            color: Colors.grey,
                            indent: 20,
                            endIndent: 20,
                          ),

                          // Modularni shit

                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 0, bottom: 0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text('Details:',
                                            style: resourceDetailsStyle()),
                                        Expanded(
                                            child: resourceDetails(
                                                snapshot.data!.details))
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                          Divider(
                            height: 25,
                            thickness: 1,
                            color: Colors.grey,
                            indent: 20,
                            endIndent: 20,
                          ),

                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  child: Text("RETURN"),
                                  onPressed: null,
                                  style: resourceButton(),
                                ),
                                SizedBox(width: 5),
                                ElevatedButton(
                                  child: Text("BORROW"),
                                  onPressed: null,
                                  style: resourceButton(),
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                          )
                        ],
                      );
              }),
        ));
  }

  Future pickDate(BuildContext context) async {
    final initalDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;

    setState(() => date = newDate);
  }

  Future pickDateRange(BuildContext context) async {
    final initalDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange,
    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }

  Widget tagsWidget(tags) {
    if (tags != null) {
      for (var tag in tags) {
        return Text(tag.name.toString());
      }
    }
    return Text('');
  }

  Widget resourceDetails(details) {
    if (details.length != 0) {
      List<dynamic> detailsList = [];

      for (var detail in details) {
        var kljuc = detail.keys.elementAt(2);

        var temp = '$kljuc: ${detail[kljuc]}';
        detailsList.add(temp);
        /* for (final mapEntry in detail.entries) {
          key = mapEntry.key;
          value = mapEntry.value;
        } */
      }
      if (detailsList.length != 0) {
        return new Column(
            children:
                detailsList.map((item) => new Text(item.toString())).toList());
      } else {
        return Text('');
      }
    } else {
      return Text('');
    }
  }
}
