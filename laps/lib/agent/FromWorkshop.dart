import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:laps/agent/AgentHomeScreen.dart';
import 'package:laps/commonFunction/RequestImageProcess.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/commonFunction/DateAndTime.dart';
import 'package:laps/model/AgentListFromWorkshop.dart';
import 'package:laps/model/AgentListHome.dart';
import 'package:laps/packages/popup.dart';
import 'package:laps/packages/popup_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/LoadingImage.dart';

class FromWorkshop extends StatefulWidget {
  final AgentListHome homelist;
  const FromWorkshop({Key key, @required this.homelist}) : super(key: key);
  @override
  _FromWorkshopState createState() => _FromWorkshopState();
}

class _FromWorkshopState extends State<FromWorkshop> {
  String merchantidfilter;
  var mycolor = Colors.white;
  List<bool> isSelected = [];
  bool isLoading = false;
  Future<List<AgentListFromWorkshop>> listFromWorkshop;
  List<AgentListFromWorkshop> selectedList = [];
  List<AgentListFromWorkshop> unSelectedList = [];
  //List<Uint8List> listImages = [];
  Uint8List loadImage;
  bool errMsgList = false;

  // Adding variable to check if any supplier products are available
  var totalCount = 0;

  String notesFirstHalf, notesSecondHalf;
  bool notesFlag = true;
  @override
  void initState() {
    listFromWorkshop = _getProductList();
    super.initState();
  }

  Future<List<AgentListFromWorkshop>> _getProductList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int merchantId = prefs.getInt("merchantid") ?? 0;
    print("merchantId : $merchantId");
    merchantidfilter =
        await ApiRequest().getMerchantidFilter(merchantId, 1, 'merchant_id');
    print("merchantidfilter : " + merchantidfilter);
    var jsonData = await new ApiRequest().getDataFromAPI("products",
        "${merchantidfilter}filter[include][0][relation]=merchant&filter[include][1][relation]=productimages&filter[where][vehicle_id]=${widget.homelist.vehicleId}&filter[where][part_id]=${widget.homelist.reqtab.partId}&filter[where][productStatus]=A&filter[order][0]=merchant_id ASC");

    List<AgentListFromWorkshop> products = [];
    try {
      for (var prod in jsonData) {
        AgentListFromWorkshop product = AgentListFromWorkshop.fromJson(prod);
        products.add(product);
        unSelectedList.add(product);
        isSelected.add(false);

        // Commented list of image loading
        /*       if(product.productimages != null){
          await getImage(product.productimages[0].imageName);
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
    return products;
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
                viewDealerList(),
                validationField(),

                // seekbutton call has been moved to viewDealerList method
                // seekButton(),
              ],
            ),
          );
  }

  // Future<void> getImage(String filename) async {
  //   var image = await new ImageProcessor().getImage(filename);
  //   setState(() {
  //     listImages.add(base64.decode(image));
  //   });
  // }

  Future<void> getSingleImage(String filename) async {
    var image = await new RequestImageProcess().getImage(filename);
    setState(() {
      loadImage = base64.decode(image);
    });
  }

  Widget viewDealerList() {
    return Container(
      child: FutureBuilder(
          future: listFromWorkshop,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: new LoadingImage().loadingImage,
                ),
              );
            } else {
              totalCount = snapshot.data.length;
              return Column(children: <Widget>[
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: isSelected[index]
                            ? Colors.green[200]
                            : Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              selected: isSelected[index],
                              onTap: () {
                                setState(() {
                                  isSelected[index] = !isSelected[index];
                                  if (isSelected[index]) {
                                    unSelectedList.remove(snapshot.data[index]);
                                    selectedList.add(snapshot.data[index]);
                                  } else {
                                    unSelectedList.add(snapshot.data[index]);
                                    selectedList.remove(snapshot.data[index]);
                                  }
                                });
                              },
                              title: Text(
                                  "${snapshot.data[index].merchant.merchantName}"),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${snapshot.data[index].productNotes}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  viewQuality(
                                      snapshot.data[index].productQuality),
                                ],
                              ),
                              trailing: Text(NumberFormat.currency(name: 'AED ')
                                  .format(snapshot.data[index].productPrice)),
                              //isThreeLine: true,
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
                                          child: Text(
                                            "Full View",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: Colors.blueAccent)),
                                          onPressed: () async {
                                            if (snapshot.data[index]
                                                    .productimages.length >
                                                0) {
                                              await getSingleImage(snapshot
                                                  .data[index]
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
                                          textColor: snapshot.data[index]
                                                      .productimages.length >
                                                  1
                                              ? Colors.blue[800]
                                              : Colors.grey,
                                          child: Text(
                                            "Zoom View",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: Colors.blueAccent)),
                                          onPressed: () async {
                                            if (snapshot.data[index]
                                                    .productimages.length >
                                                1) {
                                              await getSingleImage(snapshot
                                                  .data[index]
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
                                          textColor: snapshot.data[index]
                                                      .productimages.length >
                                                  2
                                              ? Colors.blue[800]
                                              : Colors.grey,
                                          child: Text(
                                            "Fitment View",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: snapshot
                                                              .data[index]
                                                              .productimages
                                                              .length >
                                                          2
                                                      ? Colors.blue[800]
                                                      : Colors.grey)),
                                          onPressed: () async {
                                            if (snapshot.data[index]
                                                    .productimages.length >
                                                2) {
                                              await getSingleImage(snapshot
                                                  .data[index]
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
                    }),
                seekButton()
              ]);
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

  Widget seekButton() {
    // Check list of parts from suppliers - if parts exist - request quote to
    // supplier - else show option for agent to revert with price directly
    return totalCount == 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  elevation: 10,
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => AgentHomeScreen()),
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
                    updatePriceToWorkshop();
                  },
                  child: Text(
                    "Send Price",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  elevation: 10,
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => AgentHomeScreen()),
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
                    validateList();
                  },
                  child: Text(
                    "Request Quote",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Widget validationField() {
    return Visibility(
      visible: errMsgList,
      maintainSize: false,
      maintainAnimation: true,
      maintainState: true,
      child: Text(
        "Select atleast 1 option to seek.",
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  // This function allows the agent to update the price for the requested part
  // A popup on screen captures the price from the agent and once submitted closes the request
  // This is only specific to the price enquiry process
  updatePriceToWorkshop() async {
    final _finalPrice = TextEditingController();

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
        final prefs = await SharedPreferences.getInstance();
        int userID = prefs.getInt("id") ?? 0;
        DateTime d1 = new DateTime.now().toUtc();

        // Update status as 5 along with the price entered by agent
        // in request main table (enquiry complete)
        var responseData1 = await new ApiRequest().patchDataInAPI(
            "reqtabs/${widget.homelist.reqId}",
            jsonEncode({
              "finalPrice": double.tryParse(_finalPrice.text),
              "status": 5,
              "updatedby": userID,
              "updatedon": d1.toIso8601String()
            }));

        // Update status as 24 in request agent table (price enquiry completed)
        var responseData2 = await new ApiRequest().patchDataInAPI(
            "reqagntabs/${widget.homelist.id}", jsonEncode({"status": 24}));

        if (responseData1.statusCode >= 200 &&
            responseData1.statusCode < 300 &&
            responseData2.statusCode >= 200 &&
            responseData2.statusCode < 300) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => AgentHomeScreen()),
              (Route<dynamic> route) => false);
          Navigator.of(context, rootNavigator: true).pop();
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Updated Price Successfully..."),
          ));
        } else {
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

  void validateList() {
    if (selectedList.length == 0) {
      setState(() {
        errMsgList = !errMsgList;
      });
    } else {
      setState(() {
        errMsgList = false;
      });
      postMethodforSeek();
    }
  }

  void postMethodforSeek() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    int userID = prefs.getInt("id") ?? 0;
    for (int i = 0; i < selectedList.length; i++) {
      var selectdata = await new ApiRequest().postDataInAPI(
          "reqacttabs", composeJSON(selectedList[i], userID, true));
    }
    for (int i = 0; i < unSelectedList.length; i++) {
      var unselectdata = await new ApiRequest().postDataInAPI(
          "reqacttabs", composeJSON(unSelectedList[i], userID, false));
    }
    String json = jsonEncode({"status": 12});
    var finalcalldata = await new ApiRequest()
        .patchDataInAPI("reqagntabs/${widget.homelist.id}", json);
    if (finalcalldata.statusCode == 204 || finalcalldata.statusCode == 200) {
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
    setState(() {
      isLoading = false;
    });
  }

  String composeJSON(AgentListFromWorkshop data, int id, bool isSelected) {
    DateTime date = new DateTime.now().toUtc();
    String jsonData = jsonEncode({
      "id": 0,
      "reqagn_id": widget.homelist.id,
      "req_id": widget.homelist.reqId,
      "requestId": widget.homelist.requestId,
      "workshop_id": widget.homelist.workshopId,
      "vehicle_id": widget.homelist.vehicleId,
      "part_id": widget.homelist.partId,
      "agent_id": widget.homelist.agentId,
      "dealer_id": data.merchantId,
      "product_id": data.id,
      "status": isSelected ? 120 : 100,
      "reqStatus": "A",
      "agntreqUserid": id,
      "agntreqDatetime": date.toIso8601String(),
      "quantity": 1
    });
    return jsonData;
  }

  Widget viewRowPartDetails(String key, String value) {
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
      // color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(key),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: new Text(
                value,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
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
          /*      Column(
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
                  child: Text(
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
}
