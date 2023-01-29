import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:laps/agent/AgentHomeScreen.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/commonFunction/DateAndTime.dart';
import 'package:laps/commonFunction/RequestImageProcess.dart';
import 'package:laps/model/AgentListFromDealer.dart';
import 'package:laps/model/AgentListHome.dart';
import 'package:laps/packages/popup.dart';
import 'package:laps/packages/popup_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/LoadingImage.dart';

class FromDealer extends StatefulWidget {
  final AgentListHome homelist;
  const FromDealer({Key key, @required this.homelist}) : super(key: key);
  @override
  _FromDealerState createState() => _FromDealerState();
}

class _FromDealerState extends State<FromDealer> {
  Future<List<AgentListFromDealer>> listFromDealer;
  bool isLoading = false;
  List<double> finalPrice = [];
  List<AgentListFromDealer> listToRelease = [];
  //List<Uint8List> listImages = [];
  Uint8List loadImage;

  String notesFirstHalf, notesSecondHalf;
  bool notesFlag = true;

  @override
  void initState() {
    listFromDealer = _getFromDealerList();
    super.initState();
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
                releaseButton(),
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
                  child: Text(
                    "Full View",
                    style: TextStyle(fontSize: 12),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color: widget.homelist.reqtab.requestimages == null
                              ? Colors.grey
                              : widget.homelist.reqtab.requestimages.length > 0
                                  ? Colors.blue[800]
                                  : Colors.grey)),
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
                  child: Text(
                    "Zoom View",
                    style: TextStyle(fontSize: 12),
                  ),
                  padding: const EdgeInsets.all(5.0),
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
                  child: const Text(
                    "Fitment View",
                    style: TextStyle(fontSize: 12),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color: widget.homelist.reqtab.requestimages == null
                              ? Colors.grey
                              : widget.homelist.reqtab.requestimages.length > 2
                                  ? Colors.blue[800]
                                  : Colors.grey)),
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

  Future<List<AgentListFromDealer>> _getFromDealerList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int merchantId = prefs.getInt("merchantid") ?? 0;
    print("merchantId : $merchantId");
    var jsonData = await new ApiRequest().getDataFromAPI(
        "reqacttabs",
        //"[include][0][relation]=part&filter[include][1][relation]=vehicle&filter[include][2][relation]=workshop&filter[include][3][relation]=agent&filter[include][4][relation]=dealer&filter[include][5][relation]=reqtab&filter[include][6][relation]=product&filter[where][req_id]=${widget.homelist.reqId}&filter[where][status][gt]=119&filter[where][req_status]=A");
        "={\"where\": {\"req_id\": \"${widget.homelist.reqId}\",\"agent_id\": \"$merchantId\",\"reqStatus\": \"A\",\"status\": {\"gt\":\"119\"}},\"order\": [\"id ASC\"],\"include\": [{\"relation\": \"reqtab\"},{\"relation\": \"workshop\"},{\"relation\": \"vehicle\"},{\"relation\": \"part\"},{\"relation\": \"agent\"},{\"relation\": \"dealer\"},{\"relation\": \"product\",\"scope\": {\"include\": [{\"relation\": \"productimages\"}]}}]}");

    try {
      for (var prod in jsonData) {
        AgentListFromDealer product = AgentListFromDealer.fromJson(prod);
        listToRelease.add(product);
        if (product.agentPrice != 0) {
          finalPrice.add(product.agentPrice);
        } else {
          if (product.status == 120)
            finalPrice.add(product.product.productPrice);
          else
            finalPrice.add(product.dealerPrice);
        }
        // if Dealer didnt respond, set the final price as actual part price
        // Commented list of image loading
/*        if(product.product.productimages != null){
          await getImage(product.product.productimages[0].imageName);
        }
        else{
          setState(() {
            listImages.add(null);
          });
        }
        */
      }
    } catch (e) {
      print(e);
    }
    //print(products.length);
    return listToRelease;
  }

  Future<void> getSingleImage(String filename) async {
    var image = await new RequestImageProcess().getImage(filename);
    setState(() {
      loadImage = base64.decode(image);
    });
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
                      color: snapshot.data[index].status == 130
                          ? Colors.red[200]
                          : Colors.white,
                      child: Column(
                        children: [
                          ListTile(
                            onLongPress: () {},
                            onTap: () {
                              if (snapshot.data[index].status == 131 ||
                                  snapshot.data[index].status == 120) {
                                getFinalPrice(
                                    context,
                                    index,
                                    snapshot.data[index].dealerPrice,
                                    snapshot.data[index].product.productPrice);
                              } else if (snapshot.data[index].status == 130) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                      Text("This item is not available..."),
                                ));
                              }
                            },
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
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text("Photos     "),
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
                                        textColor: Colors.blue[800],
                                        child: const Text(
                                          "Full View",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: Colors.blue[800])),
                                        onPressed: () async {
                                          if (snapshot.data[index].product
                                                  .productimages.length >
                                              0) {
                                            await getSingleImage(snapshot
                                                .data[index]
                                                .product
                                                .productimages[0]
                                                .imageName);
                                            showPopup(
                                                context,
                                                Center(
                                                    child: Image.memory(
                                                        loadImage)));
                                          } else {
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text("No Image to View.."),
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
                                        textColor: Colors.blue[800],
                                        child: const Text(
                                          "Zoom View",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: Colors.blue[800])),
                                        onPressed: () async {
                                          if (snapshot.data[index].product
                                                  .productimages.length >
                                              1) {
                                            await getSingleImage(snapshot
                                                .data[index]
                                                .product
                                                .productimages[1]
                                                .imageName);
                                            showPopup(
                                                context,
                                                Center(
                                                    child: Image.memory(
                                                        loadImage)));
                                          } else {
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text("No Image to View.."),
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
                                        textColor: snapshot.data[index].product
                                                    .productimages.length >
                                                2
                                            ? Colors.blue[800]
                                            : Colors.grey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: snapshot
                                                            .data[index]
                                                            .product
                                                            .productimages
                                                            .length >
                                                        2
                                                    ? Colors.blue[800]
                                                    : Colors.grey)),
                                        child: const Text(
                                          "Fitment View",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        onPressed: () async {
                                          if (snapshot.data[index].product
                                                  .productimages.length >
                                              2) {
                                            await getSingleImage(snapshot
                                                .data[index]
                                                .product
                                                .productimages[2]
                                                .imageName);
                                            showPopup(
                                                context,
                                                Center(
                                                    child: Image.memory(
                                                        loadImage)));
                                          } else {
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text("No Image to View.."),
                                            ));
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
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

  Widget releaseButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RaisedButton(
            elevation: 10,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AgentHomeScreen()),
                  (Route<dynamic> route) => false);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RaisedButton(
            elevation: 10,
            onPressed: () {
              releaseToWorkshop();
            },
            child: Text(
              "Send Quote",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  releaseToWorkshop() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt("id") ?? 0;
    DateTime d1 = new DateTime.now().toUtc();
    print(d1.toIso8601String());
    for (int i = 0; i < listToRelease.length; i++) {
      if (listToRelease[i].status > 130 || listToRelease[i].status == 120) {
        var responseData = await new ApiRequest().patchDataInAPI(
            "reqacttabs/${listToRelease[i].id}",
            composeJSON(userID, finalPrice[i], d1.toIso8601String()));
      }
    }
    var responseData1 = await new ApiRequest().patchDataInAPI(
        "reqtabs/${widget.homelist.reqId}",
        jsonEncode({
          "status": 2,
          "updatedby": userID,
          "updatedon": d1.toIso8601String()
        }));
    var responseData2 = await new ApiRequest().patchDataInAPI(
        "reqagntabs/${widget.homelist.id}", jsonEncode({"status": 20}));
    if (responseData2.statusCode == 204) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AgentHomeScreen()),
          (Route<dynamic> route) => false);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Sent Successfully..."),
      ));
      setState(() {
        isLoading = false;
      });
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Update Failed..."),
      ));
      setState(() {
        isLoading = false;
      });
    }

    //setState(() { isLoading = false; });
  }

  String composeJSON(int userID, double agentPrice, String date) {
    int status = 140;
    if (agentPrice > 0) {
      status = 141;
    }

    String jsonData = jsonEncode({
      "agntrlsUserid": userID,
      "status": status,
      "agntrlsDatetime": date,
      "agentPrice": agentPrice
    });
    return jsonData;
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

  getFinalPrice(BuildContext context, int index, double dealerPrice,
      double productPrice) {
    final _finalPrice = TextEditingController();
    _finalPrice.text = "${finalPrice[index]}";
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
        print(date.toIso8601String());
        if (dealerPrice != 0) {
          if (finalPriceNew >= dealerPrice) {
            var resData = await new ApiRequest().patchDataInAPI(
                "reqacttabs/${listToRelease[index].id}",
                jsonEncode({
                  "agentPrice": finalPriceNew,
                  "agntrlsUserid": userID,
                  "agntrlsDatetime": date.toIso8601String()
                }));
            if (resData.statusCode == 204 || resData.statusCode == 200) {
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
          } else {
            Navigator.of(context, rootNavigator: true).pop();
            Scaffold.of(context).showSnackBar(SnackBar(
              content:
                  Text("Final price cannot be less than supplier price..."),
            ));
          }
        } else {
          if (finalPriceNew >= productPrice) {
            var resData = await new ApiRequest().patchDataInAPI(
                "reqacttabs/${listToRelease[index].id}",
                jsonEncode({
                  "agentPrice": finalPriceNew,
                  "agntrlsUserid": userID,
                  "agntrlsDatetime": date.toIso8601String()
                }));
            if (resData.statusCode == 204 || resData.statusCode == 200) {
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
          } else {
            Navigator.of(context, rootNavigator: true).pop();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Final price cannot be less than part price..."),
            ));
          }
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
}
