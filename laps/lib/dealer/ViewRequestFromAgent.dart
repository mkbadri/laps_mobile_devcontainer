import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/commonFunction/DateAndTime.dart';
import 'package:laps/commonFunction/ImageProcessor.dart';
import 'package:laps/dealer/RequestFromAgent.dart';
import 'package:laps/model/DealerListReqFrmAgent.dart';
import 'package:laps/packages/popup.dart';
import 'package:laps/packages/popup_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewReqFrmAgent extends StatefulWidget {
  final DealerListReqFrmAgent product;
  const ViewReqFrmAgent({Key key, @required this.product}) : super(key: key);
  @override
  _ViewReqFrmAgentState createState() => _ViewReqFrmAgentState();
}

class _ViewReqFrmAgentState extends State<ViewReqFrmAgent> {
  Uint8List _image1, _image2, _image3, popupImage;
  String imageTitleOne = "Full View";
  String imageTitleTwo = "Zoom View";
  String imageTitleThree = "Fitment View";
  String notesFirstHalf,variantFirstHalf;
  String notesSecondHalf,variantSecondHalf;
  bool notesFlag = true,variantFlag = true;

  Future<void> getImages() async {
    var image1, image2, image3;
    if (widget.product.product.productimages != null) {
      if (widget.product.product.productimages.length > 0) {
        image1 = await new ImageProcessor()
            .getImage(widget.product.product.productimages[0].imageName);
        setState(() {
          _image1 = base64.decode(image1);
        });
      }

      if (widget.product.product.productimages.length > 1) {
        image2 = await new ImageProcessor()
            .getImage(widget.product.product.productimages[1].imageName);
        setState(() {
          _image2 = base64.decode(image2);
        });
      }
      if (widget.product.product.productimages.length > 2) {
        image3 = await new ImageProcessor()
            .getImage(widget.product.product.productimages[2].imageName);
        setState(() {
          _image3 = base64.decode(image3);
        });
      }
    }
  }

@override
  void initState() {
    getImages();
    if (widget.product.product.productVariant.length > 70) {
      variantFirstHalf = widget.product.product.productVariant.substring(0, 70);
      variantSecondHalf = widget.product.product.productVariant
          .substring(70, widget.product.product.productVariant.length);
    } else {
      variantFirstHalf = widget.product.product.productVariant;
      variantSecondHalf = "";
    }
    if (widget.product.product.productNotes.length > 70) {
      notesFirstHalf = widget.product.product.productNotes.substring(0, 70);
      notesSecondHalf = widget.product.product.productNotes
          .substring(70, widget.product.product.productNotes.length);
    } else {
      notesFirstHalf = widget.product.product.productNotes;
      notesSecondHalf = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          viewPartsIn(),
          Container(
            margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              children: <Widget>[
                viewRowRequestDetails("Request ID", widget.product.requestId),
                viewRowRequestDetails("Request Date", DateUtil().formattedDateandTime(DateTime.parse(widget.product.reqtab.requestDate)) ?? "null"),
                viewRowRequestDetails(
                    "Agent Name", widget.product.agent.merchantName),
                viewRowRequestDetails("Agent Contact no.",
                    widget.product.agent.merchantContactno),
              ],
            ),
          ),
          viewProductSpec(),
          Divider(
            color: Colors.white,
            height: 3.0,
          ),
          viewRowPartDetails("Part Name", widget.product.part.partName),
          viewRowPrice("Price", widget.product.product.productPrice),
          viewRowQuality("Quality", widget.product.product.productQuality),
          viewRowVariant(),
          viewRowNotes(),
          viewImages(),
          manageButtons(),
        ],
      ),
    );
  }

  Widget viewImages(){
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                //padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: _image1 == null
                    ? Text("Not Available")
                    : Stack(
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            child: Image.memory(
                              _image1,
                              height: 75,
                              width: 75,
                            ),
                            onPressed: () {
                              popupImage = _image1;
                              showPopup(
                                  context,
                                  Center(
                                    child: Image.memory(
                                      _image1,
                                    ),
                                  ),
                                  imageTitleOne);
                            },
                          ),
                        ],
                      ),
              ),
              Text(imageTitleOne),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                //padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: _image2 == null
                    ? Text("Not Available")
                    : Stack(
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            child: Image.memory(
                              _image2,
                              height: 75,
                              width: 75,
                            ),
                            onPressed: () {
                              //popupImage = _image1;
                              showPopup(
                                  context,
                                  Center(
                                    child: Image.memory(
                                      _image2,
                                    ),
                                  ),
                                  imageTitleTwo);
                            },
                          ),
                        ],
                      ),
              ),
              Text(imageTitleTwo),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                //padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: _image3 == null
                    ? Text("Not Available")
                    : Stack(
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            child: Image.memory(
                              _image3,
                              height: 75,
                              width: 75,
                            ),
                            onPressed: () {
                              //popupImage = _image1;
                              showPopup(
                                  context,
                                  Center(
                                    child: Image.memory(
                                      _image3,
                                    ),
                                  ),
                                  imageTitleThree);
                            },
                          ),
                        ],
                      ),
              ),
              Text(imageTitleThree),
            ],
          ),
        ],
      ),
    );
  }

  showPopup(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
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

  Widget viewRowVariant() {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Variant"),
          new Expanded(
              child: new Container(
            padding: EdgeInsets.only(left: 20),
            child: variantSecondHalf.isEmpty
                ? new Text(variantFirstHalf,textAlign: TextAlign.right)
                : new Column(
                    children: <Widget>[
                      new Text(
                        variantFlag
                            ? (variantFirstHalf + " ...")
                            : (variantFirstHalf + variantSecondHalf),
                        textAlign: TextAlign.right,
                      ),
                      new InkWell(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new Text(
                              variantFlag ? "show more" : "show less",
                              style: new TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            variantFlag = !variantFlag;
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

  Widget viewRowNotes() {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Notes"),
          new Expanded(
              child: new Container(
            padding: EdgeInsets.only(left: 20),
            child: notesSecondHalf.isEmpty
                ? new Text(notesFirstHalf,textAlign: TextAlign.right)
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

  Widget viewPartsIn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: getIcon(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.product.product.productChassisnum,
            style:
                TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget getIcon() {
    if (widget.product.product.productInstore == 0)
      return Row(
        children: <Widget>[
          Icon(
            Icons.directions_car,
            color: Colors.green,
          ),
          Text("Parts in Car - "),
        ],
      );
    else
      return Row(
        children: <Widget>[
          Icon(
            Icons.store,
            color: Colors.green,
          ),
          Text("Parts in Store"),
        ],
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
                  "${widget.product.vehicle.vehicleMake}",
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
                  "${widget.product.vehicle.vehicleModel}",
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
                  "${widget.product.vehicle.vehicleVariant}",
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
                  "${widget.product.vehicle.vehicleYear}",
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

  Widget viewRowRequestDetails(String key, String value) {
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
      // color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(key), Text(value)],
      ),
    );
  }

  Widget viewRowPartDetails(String key, String value) {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
      // color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(key), 
          Expanded(child: Text(value,textAlign: TextAlign.right,))
        ],
      ),
    );
  }

  Widget viewRowPrice(String key, double value) {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(key),
          Text(NumberFormat.currency(name: 'AED ').format(value))
        ],
      ),
    );
  }

  Widget viewRowQuality(String key, double value) {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 3.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(key),
          RatingBarIndicator(
            rating: value,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 30.0,
            direction: Axis.horizontal,
          ),
        ],
      ),
    );
  }

  Widget manageButtons() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                minWidth: 100,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, '/');
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => RequestFromAgent()),
                      (Route<dynamic> route) => false);
                  },
                  child: Text("Cancel"),
                  color: Colors.grey,
                  textColor: Colors.white,
                ),
              ),
              ButtonTheme(
                minWidth: 100,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    showDialogNotAvail(context);
                  },
                  child: Text("Sold"),
                  color: Colors.red,
                  textColor: Colors.white,
                ),
              ),
              ButtonTheme(
                minWidth: 100,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  child: Text("Update Price"),
                  color: Colors.green,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ));
  }

  showAlertDialog(BuildContext context) {
    final _dealerPrice = TextEditingController();
    _dealerPrice.text = "${widget.product.product.productPrice}";
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget UpdateButton = FlatButton(
      child: Text("Update and send"),
      onPressed: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        //int merchantId = prefs.getInt("merchantid") ?? 0;
        int userId = prefs.getInt("id") ?? 0;
        double dealerPrice = double.tryParse(_dealerPrice.text);
        DateTime date = new DateTime.now().toUtc();
        String requestBody = jsonEncode({
          "status": 131,
          "dealerPrice": dealerPrice,
          "dlerresUserid": userId, 
          "dlerresDatetime": date.toIso8601String()
        });
        var data = await new ApiRequest()
            .patchDataInAPI("reqacttabs/${widget.product.id}", requestBody);
        if (data.statusCode == 204 || data.statusCode == 200) {
          print("success");
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Updated Successfully..."),
          ));
          Navigator.of(context, rootNavigator: true).pop();
          //Navigator.pushNamed(context, '/');
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => RequestFromAgent()),
            (Route<dynamic> route) => false);
        } else {
          print("failed");
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Update Failed.."),
          ));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Update Price"),
      content: TextField(
        controller: _dealerPrice,
        decoration: InputDecoration(hintText: "Update Price"),
        keyboardType: TextInputType.number,
      ),
      actions: [
        cancelButton,
        UpdateButton,
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

  showDialogNotAvail(BuildContext context) {
    final _soldPrice = TextEditingController();
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget soldButton = FlatButton(
      child: Text("Sold"),
      onPressed: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        int merchantId = prefs.getInt("merchantid") ?? 0;
        int userId = prefs.getInt("id") ?? 0;
        double soldPrice = double.tryParse(_soldPrice.text);
        DateTime date = new DateTime.now().toUtc();
        String requestBodySP = jsonEncode({
          "productStatus": 'S',
          "productSoldprice": soldPrice,
          "updatedby": userId,
          "updatedon": "${date.toIso8601String()}"
        });
        var data = await new ApiRequest()
            .patchDataInAPI("products/" + "${widget.product.product.id}", requestBodySP);
        if (data.statusCode == 204 || data.statusCode == 200) {
          String requestBodyNA = jsonEncode({
            "status": 130, 
            "dealerPrice": 0, 
            "dlerresUserid": userId,
            "dlerresDatetime": date.toIso8601String()
          });
          var data = await new ApiRequest()
              .patchDataInAPI("reqacttabs/${widget.product.id}", requestBodyNA);
          if (data.statusCode == 204 || data.statusCode == 200) {
            print("success");
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Updated Successfully..."),
            ));
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => RequestFromAgent()),
              (Route<dynamic> route) => false);
          } else {
            print("failed");
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Update Failed.."),
            ));
          }
        } else {
          print("failed");
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Update Failed.."),
          ));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Sold"),
      content: TextField(
        controller: _soldPrice,
        decoration: InputDecoration(hintText: "Sold Price"),
        keyboardType: TextInputType.number,
      ),
      actions: [
        cancelButton,
        soldButton,
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

