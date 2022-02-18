import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inv_app/Assets/custom.dart';
import 'package:inv_app/Classes/borrowed.dart';
import 'package:inv_app/Classes/resource.dart';
import 'package:inv_app/Classes/tag.dart';
import 'package:inv_app/Views/Forms/registration.dart';
import 'package:inv_app/Views/Home/resource_details.dart';
import 'package:inv_app/Views/filterTag.dart';
import 'package:inv_app/Views/modules.dart';
import 'package:inv_app/api/loginService.dart';
import 'package:inv_app/Classes/user.dart';
import 'package:inv_app/api/resourceService.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BorrowedResourceDetailsForm extends StatefulWidget {
  @override
  BorrowedResourceDetailsFormState createState() {
    return BorrowedResourceDetailsFormState();
  }
}

class BorrowedResourceDetailsFormState
    extends State<BorrowedResourceDetailsForm> {
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

class BorrowedResourceDetails extends StatefulWidget {
  final int id;
  final String? name;

  const BorrowedResourceDetails(
      {Key? key, required this.id, required this.name})
      : super(key: key);
  @override
  _BorrowedResourceDetailsState createState() =>
      _BorrowedResourceDetailsState();
}

class _BorrowedResourceDetailsState extends State<BorrowedResourceDetails> {
  DateTime date = DateTime.now();
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime(DateTime.now().day - 30),
      end: DateTime(DateTime.now().day + 30));

//ispisuje selektirani datum u button
  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

//ispisuje datum from
  String getFrom(String? dateFrom) {
    if (dateFrom == null) {
      return 'Loan date ';
    } else {
      return DateFormat('dd/MM/yyyy').format(DateTime.parse(dateFrom));
    }
  }

//ispisuje datum until
  String getUntil(String? dateTo) {
    if (dateTo == null) {
      return 'Expected return date';
    } else {
      return DateFormat('dd/MM/yyyy').format(DateTime.parse(dateTo));
    }
  }

  @override
  Widget build(BuildContext context) {
    //Dizajn
    return Scaffold(
        backgroundColor: Colors.white,
        //App bar
        appBar: AppBar(
          title: Text(
            widget.name ?? "Fetching...",
            style: TextStyle(
                color: Colors.white, fontFamily: 'Mulish', fontSize: 20),
          ),
          centerTitle: true,
        ),

        //Tijelo
        body: SingleChildScrollView(
          child: FutureBuilder<Borrowed?>(
              future: getBorrowedResourceById(widget.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return circularWaiting();
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      //Slika resursa
                      Padding(
                          padding: EdgeInsets.only(top: 0.0, bottom: 20),
                          child: Center(
                            child: Image(
                              image: NetworkImage(snapshot.data?.resource
                                          ?.picture?.formats?.thumbnail?.url !=
                                      null
                                  ? snapshot.data!.resource!.picture!.formats!
                                      .thumbnail!.url
                                      .toString()
                                  : "https://helloworld.raspberrypi.org/assets/raspberry_pi_full-3b24e4193f6faf616a01c25cb915fca66883ca0cd24a3d4601c7f1092772e6bd.png"),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
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
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Icon(Icons.arrow_right_alt_outlined,
                              size: 35, color: Colors.blue),
                          SizedBox(width: 5),
                          Text(
                            'Expected return date',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black, fontSize: 20),
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
                            child: Text(getFrom(snapshot.data?.dateFrom)),
                            onPressed: () => pickDateRange(context),
                          ),
                          Icon(Icons.arrow_right_alt_outlined,
                              size: 35, color: Colors.blue),
                          SizedBox(width: 5),
                          RaisedButton(
                            color: Colors.white,
                            child: Text(getUntil(snapshot.data?.dateTo)),
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
                          child: Text('Ouantity: ${snapshot.data?.Quantity}',
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                      ),
                      Divider(
                        height: 20,
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
                                            snapshot.data!.resource!.details))
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
                      SizedBox(height: 30),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: ElevatedButton(
                                child: Text("RETURN"),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(widget.name!),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                    'Return date: ${getUntil(snapshot.data?.dateTo)}'),
                                                Text(
                                                    'Borrowed quantity: ${snapshot.data?.Quantity}'),
                                                ReturnForm(
                                                  dateFrom: getFrom(
                                                      snapshot.data?.dateFrom),
                                                  dateUntil: getFrom(
                                                      snapshot.data?.dateTo),
                                                  resourceId: snapshot
                                                      .data!.resource!.id,
                                                  borrowedQuantity:
                                                      snapshot.data?.Quantity,
                                                  availableQuantity: snapshot
                                                      .data!.resource!.quantity,
                                                  borrowedId: snapshot.data!.id,
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Close'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                style: resourceButton(),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: ElevatedButton(
                                child: Text("BORROW"),
                                onPressed: null,
                                style: greyButton(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  );
                }
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
      firstDate: DateTime(DateTime.now().day - 30),
      lastDate: DateTime(DateTime.now().day + 30),
      initialDateRange: dateRange,
    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }

  Widget tagsWidget(List<Tag>? tags) {
    if (tags != null && tags.length >= 0) {
      return Wrap(
          alignment: WrapAlignment.start,
          children: tags
              .map((tagModel) => myTagsChipUIWidget(
                    tagModel: tagModel,
                    action: "Choose",
                    selectedList: [],
                  ))
              .toList());
    }
    return Text('');
  }

  Widget resourceDetails(details) {
    print(details);
    if (details != null && details?.length != 0) {
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

//Vraćanje resursa

class ReturnForm extends StatefulWidget {
  final String dateFrom;
  final String dateUntil;
  final int resourceId;
  final int? borrowedQuantity;
  final int? availableQuantity;
  final int? borrowedId;

  const ReturnForm(
      {Key? key,
      required this.dateFrom,
      required this.dateUntil,
      required this.resourceId,
      required this.borrowedQuantity,
      required this.availableQuantity,
      required this.borrowedId})
      : super(key: key);
  @override
  ReturnFormState createState() {
    return ReturnFormState();
  }
}

class ReturnFormState extends State<ReturnForm> {
  final _formKey = GlobalKey<FormState>();

  String comment = "";
  void _return() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      returnResource(
          context,
          widget.resourceId,
          comment,
          widget.borrowedQuantity!,
          widget.availableQuantity!,
          widget.borrowedId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Comment:',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),

          //TextBox for commnet
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              maxLines: null,
              onSaved: (val) => comment = val!,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
              ),
              validator: (value) {
                if (value!.length >= 200) {
                  return 'Comment is too long.';
                }
                return null;
              },
            ),
          ),

          //Return Button
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: Center(
              child: Container(
                height: 40,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    _return();
                  },
                  child: const Text(
                    'RETURN',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
