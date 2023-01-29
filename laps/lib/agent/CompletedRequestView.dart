import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:laps/agent/CompletedRequestHome.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/commonFunction/DateAndTime.dart';
import 'package:laps/commonFunction/ImageProcessor.dart';
import 'package:laps/model/AgentListFromDealer.dart';
import 'package:laps/model/AgentListHome.dart';
import 'package:laps/packages/popup.dart';
import 'package:laps/packages/popup_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/LoadingImage.dart';

class CompletedRequestView extends StatefulWidget {
  final AgentListHome homelist;
  const CompletedRequestView({Key key, @required this.homelist})
      : super(key: key);
  @override
  _CompletedRequestViewState createState() => _CompletedRequestViewState();
}

class _CompletedRequestViewState extends State<CompletedRequestView> {
  Future<List<AgentListFromDealer>> listFromDealer;
  bool isLoading = false;
  String notesFirstHalf, notesSecondHalf;
  bool notesFlag = true;
  Uint8List loadImage;
  List<double> finalPrice = [];
  List<AgentListFromDealer> listToview = [];
  final _finalPrice = TextEditingController();

  @override
  void initState() {
    listFromDealer = _getFromDealerList();
    super.initState();
  }

  @override
  void dispose() {
    _finalPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: new LoadingImage().loadingImage,
          )
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 3),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    children: <Widget>[
                      viewRowPartDetails(
                          "Request Number", widget.homelist.requestId),
                      viewRowPartDetails(
                          "Request Date",
                          DateUtil().formattedDateandTime(DateTime.parse(
                                  widget.homelist.reqtab.requestDate)) ??
                              "null"),
                      viewRowPartDetails(
                          "Buyer", widget.homelist.workshop.merchantName),
                      viewRowPartDetails(
                          "Part Name", widget.homelist.part.partName),
                      viewRowPartNotes(
                          'Request Notes', widget.homelist.reqtab.requestNotes),
                    ],
                  ),
                ),
                viewProductSpec(),
                viewRequestImage(),
                viewList(),
                cancelButton(),
              ],
            ),
          );
  }

  Widget viewRowPartDetails(String key, String value) {
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
      // color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(key), Text(value)],
      ),
    );
  }

  Widget viewRowPartNotes(String key, String value) {
    if (value.length > 50) {
      notesFirstHalf = value.substring(0, 50);
      notesSecondHalf = value.substring(50, value.length);
    } else {
      notesFirstHalf = value;
      notesSecondHalf = "";
    }
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(key),
          new Expanded(
              child: new Container(
            padding: EdgeInsets.only(left: 20),
            child: notesSecondHalf.isEmpty
                ? new Text(notesFirstHalf, textAlign: TextAlign.right)
                : new Column(
                    children: <Widget>[
                      new Text(
                        notesFlag
                            ? (notesFirstHalf + "...")
                            : (notesFirstHalf + notesSecondHalf),
                        textAlign: TextAlign.right,
                      ),
                      new InkWell(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new Text(
                              notesFlag ? "show more" : "show less",
                              style: new TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            notesFlag = !notesFlag;
                          });
                        },
                      ),
                    ],
                  ),
          )),
        ],
      ),
    );
  }

  Widget viewProductSpec() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Make"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.homelist.vehicle.vehicleMake}",
                  style: TextStyle(
                      color: Colors.blue[800], fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Model",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.homelist.vehicle.vehicleModel}",
                  style: TextStyle(
                      color: Colors.blue[800], fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          // Hidden all variant as per client request
          /*     Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Variant"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.homelist.vehicle.vehicleVariant}",
                  style: TextStyle(
                      color: Colors.blue[800], fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          */
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Year"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.homelist.vehicle.vehicleYear}",
                  style: TextStyle(
                      color: Colors.blue[800], fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget viewRequestImage() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(5.0),
      constraints: BoxConstraints(minWidth: 2000),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceEvenly,
        children: [
          Text("Request \nPhotos"),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10.0,
            runSpacing: 5,
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 30,
                child: FlatButton(
                  color: Colors.white,
                  textColor: widget.homelist.reqtab.requestimages == null
                      ? Colors.grey
                      : widget.homelist.reqtab.requestimages.length > 0
                          ? Colors.blue[800]
                          : Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color: widget.homelist.reqtab.requestimages == null
                              ? Colors.grey
                              : widget.homelist.reqtab.requestimages.length > 0
                                  ? Colors.blue[800]
                                  : Colors.grey)),
                  child: const Text(
                    "Full View",
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () async {
                    if (widget.homelist.reqtab.requestimages != null) {
                      if (widget.homelist.reqtab.requestimages.length > 0) {
                        await getSingleImage(
                            widget.homelist.reqtab.requestimages[0].imageName);
                        showPopup(
                            context, Center(child: Image.memory(loadImage)));
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("No Image to View.."),
                        ));
                      }
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("No Image to View.."),
                      ));
                    }
                  },
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: FlatButton(
                  color: Colors.white,
                  textColor: widget.homelist.reqtab.requestimages == null
                      ? Colors.grey
                      : widget.homelist.reqtab.requestimages.length > 1
                          ? Colors.blue[800]
                          : Colors.grey,
                  child: const Text(
                    "Zoom View",
                    style: TextStyle(fontSize: 12),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color: widget.homelist.reqtab.requestimages == null
                              ? Colors.grey
                              : widget.homelist.reqtab.requestimages.length > 1
                                  ? Colors.blue[800]
                                  : Colors.grey)),
                  onPressed: () async {
                    if (widget.homelist.reqtab.requestimages != null) {
                      if (widget.homelist.reqtab.requestimages.length > 1) {
                        await getSingleImage(
                            widget.homelist.reqtab.requestimages[1].imageName);
                        showPopup(
                            context, Center(child: Image.memory(loadImage)));
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("No Image to View.."),
                        ));
                      }
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("No Image to View.."),
                      ));
                    }
                  },
                ),
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: FlatButton(
                  color: Colors.white,
                  textColor: widget.homelist.reqtab.requestimages == null
                      ? Colors.grey
                      : widget.homelist.reqtab.requestimages.length > 2
                          ? Colors.blue[800]
                          : Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color: widget.homelist.reqtab.requestimages == null
                              ? Colors.grey
                              : widget.homelist.reqtab.requestimages.length > 2
                                  ? Colors.blue[800]
                                  : Colors.grey)),
                  child: const Text(
                    "Fitment View",
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () async {
                    if (widget.homelist.reqtab.requestimages != null) {
                      if (widget.homelist.reqtab.requestimages.length > 2) {
                        await getSingleImage(
                            widget.homelist.reqtab.requestimages[2].imageName);
                        showPopup(
                            context, Center(child: Image.memory(loadImage)));
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("No Image to View.."),
                        ));
                      }
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("No Image to View.."),
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showPopup(BuildContext context, Widget widget, {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 10,
        left: 10,
        right: 10,
        bottom: 10,
        child: PopupContent(
          content: new GestureDetector(
            child: widget,
            onTap: () {
              try {
                Navigator.pop(context); //close the popup
              } catch (e) {}
            },
          ),
        ),
      ),
    );
  }

  Future<void> getSingleImage(String filename) async {
    var image = await new ImageProcessor().getImage(filename);
    setState(() {
      loadImage = base64.decode(image);
    });
  }

  Future<List<AgentListFromDealer>> _getFromDealerList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int merchantId = prefs.getInt("merchantid") ?? 0;
    print("merchantId : $merchantId");
    String reqStatus =
        widget.homelist.status == 21 || widget.homelist.status == 22
            ? 'C'
            : 'A';
    var jsonData = await new ApiRequest().getDataFromAPI("reqacttabs",
        "[include][0][relation]=part&filter[include][1][relation]=vehicle&filter[include][2][relation]=workshop&filter[include][3][relation]=agent&filter[include][4][relation]=dealer&filter[include][5][relation]=reqtab&filter[include][6][relation]=product&filter[where][req_id]=${widget.homelist.reqId}&filter[where][status][gt]=140&filter[where][reqStatus]=$reqStatus");

    try {
      for (var prod in jsonData) {
        AgentListFromDealer product = AgentListFromDealer.fromJson(prod);
        listToview.add(product);
        if (product.status > 150)
          finalPrice.add(product.reqtab.finalPrice);
        else
          finalPrice.add(product.agentPrice);
      }
    } catch (e) {
      print(e);
    }
    return listToview;
  }

  Widget viewList() {
    return Container(
      child: FutureBuilder(
          future: listFromDealer,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: new LoadingImage().loadingImage,
                ),
              );
            } else {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: snapshot.data[index].status > 150
                          ? Colors.green[200]
                          : snapshot.data[index].reqStatus == 'C'
                              ? Colors.white
                              : Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            onLongPress: () {},
                            onTap: () {},
                            title: Text(
                                "${snapshot.data[index].dealer.merchantName}"),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${snapshot.data[index].product.productNotes}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                viewQuality(snapshot
                                    .data[index].product.productQuality),
                                Text(
                                    NumberFormat.currency(
                                            name: 'Final price - AED ')
                                        .format(finalPrice[index]),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    NumberFormat.currency(name: 'AED ').format(
                                        snapshot
                                            .data[index].product.productPrice),
                                    style: TextStyle(
                                        decoration:
                                            TextDecoration.lineThrough)),
                                Text(NumberFormat.currency(name: 'AED ')
                                    .format(snapshot.data[index].dealerPrice))
                              ],
                            ),
                            isThreeLine: true,
                          ),
                          snapshot.data[index].status > 150
                              ? ButtonBar(
                                  //alignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    snapshot.data[index].product
                                                .productStatus !=
                                            'P'
                                        ? FlatButton(
                                            color: Colors.white,
                                            textColor: Colors.blue[800],
                                            child: Text("Confirm"),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                    color: Colors.blue[800])),
                                            onPressed: () async {
                                              confirmPurchase(
                                                  context,
                                                  snapshot
                                                      .data[index].product.id);
                                            },
                                          )
                                        : new Container(),
                                    FlatButton(
                                      color: Colors.white,
                                      textColor: Colors.blue[800],
                                      child: Text("Update Price"),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                              color: Colors.blue[800])),
                                      onPressed: () async {
                                        getFinalPrice(context, index,
                                            snapshot.data[index].product.id);
                                      },
                                    ),
                                  ],
                                )
                              : new Container(),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }

  Widget viewQuality(double value) {
    return RatingBarIndicator(
      rating: value,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: 20.0,
      direction: Axis.horizontal,
    );
  }

  Widget cancelButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RaisedButton(
        elevation: 10,
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => CompletedRequestHome()),
              (Route<dynamic> route) => false);
        },
        child: Text(
          "Cancel",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  getFinalPrice(BuildContext context, int index, int productId) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget updateButton = FlatButton(
      child: Text("Update"),
      onPressed: () async {
        double finalPriceNew = double.tryParse(_finalPrice.text);
        final prefs = await SharedPreferences.getInstance();
        int userID = prefs.getInt("id") ?? 0;
        DateTime date = new DateTime.now().toUtc();
        var resDataProducts = await new ApiRequest().patchDataInAPI(
            "products/$productId",
            jsonEncode({
              "productSoldprice": finalPriceNew,
              "updatedby": userID,
              "updatedon": date.toIso8601String()
            }));
        var resDataReqTab = await new ApiRequest().patchDataInAPI(
            "reqtabs/${widget.homelist.reqId}",
            jsonEncode({
              "finalPrice": finalPriceNew,
              "updatedby": userID,
              "updatedon": date.toIso8601String()
            }));
        if (resDataReqTab.statusCode == 200 ||
            resDataReqTab.statusCode == 204) {
          setState(() {
            finalPrice[index] = finalPriceNew;
          });
          Navigator.of(context, rootNavigator: true).pop();
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Update Successfully..."),
          ));
        } else {
          Navigator.of(context, rootNavigator: true).pop();
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Update Failed..."),
          ));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Update final Price"),
      content: TextField(
        controller: _finalPrice,
        decoration: InputDecoration(hintText: "Update final Price"),
        keyboardType: TextInputType.number,
      ),
      actions: [
        cancelButton,
        updateButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  confirmPurchase(BuildContext context, int productId) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("Confirm"),
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        int userID = prefs.getInt("id") ?? 0;
        DateTime date = new DateTime.now().toUtc();
        var resDataProducts = await new ApiRequest().patchDataInAPI(
            "products/$productId",
            jsonEncode({
              "productStatus": 'P',
              "updatedby": userID,
              "updatedon": date.toIso8601String()
            }));
        var resDataReqAgnt = await new ApiRequest().patchDataInAPI(
            "reqagntabs/${widget.homelist.id}", jsonEncode({"status": 22}));
        if (resDataReqAgnt.statusCode == 200 ||
            resDataReqAgnt.statusCode == 204) {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => CompletedRequestHome()),
              (Route<dynamic> route) => false);
        } else {
          Navigator.of(context, rootNavigator: true).pop();
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Update Failed. try again."),
          ));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm?"),
      content: Text("Would you like to confirm?"),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
