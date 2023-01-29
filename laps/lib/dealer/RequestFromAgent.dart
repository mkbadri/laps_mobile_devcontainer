import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/dealer/ViewRequestFromAgent.dart';
import 'package:laps/model/DealerListReqFrmAgent.dart';
import 'package:laps/model/LoadingImage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestFromAgent extends StatefulWidget {
  @override
  _RequestFromAgentState createState() => _RequestFromAgentState();
}

class _RequestFromAgentState extends State<RequestFromAgent> {
  TextEditingController searchText = new TextEditingController();
  String filter;
  Future<List<DealerListReqFrmAgent>> listData;

  // Add listen for text search. Add search value to filter variable. Convert to lowercase for case insensitive
  @override
  void initState() {
    listData = _getProductList();
    searchText.addListener(() {
      setState(() {
        filter = searchText.text.toLowerCase();
      });
    });
  }

  @override
  void dispose(){
    searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      child: FutureBuilder(
        future: listData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: new LoadingImage().loadingImage,
              ),
            );
          } else {
            return new Material(
              child: new Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: deviceWidth * 0.85,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        // A textbox on top for the user to input search text
                        child: new TextField(
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF002E6C))
                            ),
                            labelText: "Search...",
                          ),
                          controller: searchText,
                        ),
                      ),
                    ),
                    Container(
                      width: deviceWidth * 0.10,
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        // Button to Refresh the List
                        child: IconButton(
                          icon: Icon(Icons.refresh),
                          tooltip: 'Refresh The List',
                          onPressed: () {
                            setState(() {
                              listData = _getProductList();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                new Expanded(child: 
                new ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return filter == null || filter == "" ? new Card(
                    elevation: 10,
                    child: ListTile(
                      onTap: () {
                        DealerListReqFrmAgent agentHomeList = snapshot.data[index];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewReqFrmAgent(product: agentHomeList),
                          ),
                        );
                      },
                      // leading: Image.network("https://homepages.cae.wisc.edu/~ece533/images/airplane.png"),
                      //leading: Text("${snapshot.data[index].id}"),
                      title: Text(snapshot.data[index].requestId +
                          ' - ' +
                        snapshot.data[index].agent.merchantName),
                      subtitle: Text("${snapshot.data[index].part.partName} - ${snapshot.data[index].product.productNotes}"),
                      //Number format to covert price to AED and display on screen
                      trailing: Text(NumberFormat.currency(name: 'AED ')
                          .format(snapshot.data[index].product.productPrice)),
                    ),
                  ):
                  //Filter records using search input in Vehicle Make
                  snapshot.data[index].requestId.toString().toLowerCase().contains(filter) ||
                  //Filter records using search input in product price
                  snapshot.data[index].agent.merchantName.toString().toLowerCase().contains(filter) ||
                  //Filter records using search input in product price
                  snapshot.data[index].product.productNotes.toLowerCase().contains(filter) ||
                  //Filter records using search input in product price
                  snapshot.data[index].product.productPrice.toString().toLowerCase().contains(filter) ||
                  //Filter records using search input in part name case insensitive
                  snapshot.data[index].part.partName.toLowerCase().contains(filter) ? 
                  // Show filtered records
                  new Card(
                    elevation: 10,
                    child: ListTile(
                      onTap: () {
                        DealerListReqFrmAgent agentHomeList = snapshot.data[index];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewReqFrmAgent(product: agentHomeList),
                          ),
                        );
                      },
                      // leading: Image.network("https://homepages.cae.wisc.edu/~ece533/images/airplane.png"),
                      //leading: Text("${snapshot.data[index].id}"),
                      title: Text(snapshot.data[index].requestId +
                          ' - ' +
                        snapshot.data[index].agent.merchantName),
                      subtitle: Text("${snapshot.data[index].part.partName} - ${snapshot.data[index].product.productNotes}"),
                      //Number format to covert price to AED and display on screen
                      trailing: Text(NumberFormat.currency(name: 'AED ')
                          .format(snapshot.data[index].product.productPrice)),
                    ),
                  ) : new Container();
                }))
              ],)
            );
          }
        },
      ),
    );
  }

  Future<List<DealerListReqFrmAgent>> _getProductList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int merchantId = prefs.getInt("merchantid") ?? 0;
    print(merchantId);
    var jsonData = await new ApiRequest().getDataFromAPI("reqacttabs",
        //"[include][0][relation]=part&filter[include][1][relation]=vehicle&filter[include][2][relation]=agent&filter[include][3][relation]=dealer&filter[include][4][relation]=reqtab&filter[include][5][relation]=product&filter[where][dealer_id]=$merchantId&filter[where][status]=120&filter[where][req_status]=A");
        "={\"where\": {\"dealer_id\": \"$merchantId\",\"reqStatus\": \"A\",\"status\": \"120\"},\"order\": [\"id DESC\"],\"include\": [{\"relation\": \"reqtab\"},{\"relation\": \"vehicle\"},{\"relation\": \"part\"},{\"relation\": \"agent\"},{\"relation\": \"dealer\"},{\"relation\": \"product\",\"scope\": {\"include\": [{\"relation\": \"productimages\"}]}}]}");
    List<DealerListReqFrmAgent> products = [];
    try {
      for (var prod in jsonData) {
        DealerListReqFrmAgent product = DealerListReqFrmAgent.fromJson(prod);
        products.add(product);
      }
    } catch (e) {
      print(e);
    }
    //print(products.length);
    return products;
  }

  
}