import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:laps/commonFunction/ImageProcessor.dart';
import 'package:laps/dealer/CompleteHome.dart';
import 'package:laps/model/DealerListCompleted.dart';
import 'package:laps/packages/popup.dart';
import 'package:laps/packages/popup_content.dart';

class CompletedView extends StatefulWidget {
  final DealerListCompleted homelist;
  const CompletedView({Key key, @required this.homelist}) : super(key: key);
  @override
  _CompletedViewState createState() => _CompletedViewState();
}

class _CompletedViewState extends State<CompletedView> {
  Uint8List _image1, _image2, _image3, popupImage;
  String imageTitleOne = "Full View";
  String imageTitleTwo = "Zoom View";
  String imageTitleThree = "Fitment View";
  String notesFirstHalf, variantFirstHalf;
  String notesSecondHalf, variantSecondHalf;
  bool notesFlag = true, variantFlag = true;

  Future<void> getImages() async {
    var image1, image2, image3;
    if (widget.homelist.productimages != null) {
      if (widget.homelist.productimages.length > 0) {
        image1 = await new ImageProcessor()
            .getImage(widget.homelist.productimages[0].imageName);
        setState(() {
          _image1 = base64.decode(image1);
        });
      }

      if (widget.homelist.productimages.length > 1) {
        image2 = await new ImageProcessor()
            .getImage(widget.homelist.productimages[1].imageName);
        setState(() {
          _image2 = base64.decode(image2);
        });
      }
      if (widget.homelist.productimages.length > 2) {
        image3 = await new ImageProcessor()
            .getImage(widget.homelist.productimages[2].imageName);
        setState(() {
          _image3 = base64.decode(image3);
        });
      }
    }
  }

  @override
  void initState() {
    getImages();
    if (widget.homelist.productVariant.length > 70) {
      variantFirstHalf = widget.homelist.productVariant.substring(0, 70);
      variantSecondHalf = widget.homelist.productVariant
          .substring(70, widget.homelist.productVariant.length);
    } else {
      variantFirstHalf = widget.homelist.productVariant;
      variantSecondHalf = "";
    }
    if (widget.homelist.productNotes.length > 70) {
      notesFirstHalf = widget.homelist.productNotes.substring(0, 70);
      notesSecondHalf = widget.homelist.productNotes
          .substring(70, widget.homelist.productNotes.length);
    } else {
      notesFirstHalf = widget.homelist.productNotes;
      notesSecondHalf = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: viewProductWidget());
  }

  Widget getIcon() {
    if (widget.homelist.productInstore == 0)
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

  Widget viewProductWidget() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getIcon(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.homelist.productChassisnum,
                style: TextStyle(
                    color: Colors.blue[800], fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Container(
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
              /*        Column(
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
                      "${widget.homelist.vehicle.vehicleYear}",
                      style: TextStyle(
                          color: Colors.blue[800], fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Divider(
          color: Colors.white,
          height: 3.0,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Part Name"),
              Expanded(
                  child: Text(
                "${widget.homelist.part.partName}",
                textAlign: TextAlign.right,
              ))
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Price"),
              Text(NumberFormat.currency(name: 'AED ')
                  .format(widget.homelist.productPrice))
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 3.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Quality"),
              RatingBarIndicator(
                rating: widget.homelist.productQuality,
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
        ),
        Container(
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
                    ? new Text(variantFirstHalf, textAlign: TextAlign.right)
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
        ),
        Container(
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
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 3),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            children: <Widget>[
              viewRowPartDetails("Status",
                  widget.homelist.productStatus == 'S' ? 'Sold' : 'Purchased'),
              widget.homelist.productStatus == 'P'
                  ? Column(
                      children: [
                        viewRowPartDetails("Request Number",
                            widget.homelist.productreqact[0].requestId),
                        viewRowPartDetails(
                            "Purchased Price",
                            NumberFormat.currency(name: 'AED ').format(
                                widget.homelist.productreqact[0].dealerPrice))
                      ],
                    )
                  : viewRowPartDetails(
                      "Sold Price",
                      NumberFormat.currency(name: 'AED ')
                          .format(widget.homelist.productSoldprice)),
            ],
          ),
        ),
        Container(
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
        ),
        Align(
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
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => CompletedHome()),
                            (Route<dynamic> route) => false);
                      },
                      child: Text("Cancel"),
                      color: Colors.grey,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )),
      ],
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
}
