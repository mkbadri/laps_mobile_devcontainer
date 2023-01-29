import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laps/agent/CompletedRequestView.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/model/AgentListHome.dart';
import 'package:laps/model/LoadingImage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedRequestHome extends StatefulWidget {
  @override
  _CompletedRequestHomeState createState() => _CompletedRequestHomeState();
}

class _CompletedRequestHomeState extends State<CompletedRequestHome> {
  TextEditingController searchText = new TextEditingController();
  String filter = "", filterstatus = "";
  List<int> filterList = [];
  Future<List<AgentListHome>> listData;
  List<bool> _selection;
  List<String> textStatus = [];

  // Add listen for text search. Add search value to filter variable. Convert to lowercase for case insensitive
  @override
  void initState() {
    _selection = [true, false, false];
    listData = _getProductList();
    searchText.addListener(() {
      setState(() {
        filter = searchText.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    searchText.dispose();
    textStatus.clear();
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
                child: new Column(
              children: <Widget>[
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
                                borderSide:
                                    BorderSide(color: Color(0xFF002E6C))),
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
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ToggleButtons(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: Row(
                              children: <Widget>[
                                Text("All"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: Row(
                              children: <Widget>[
                                Text("Released"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: Row(
                              children: <Widget>[
                                Text("Purchased"),
                              ],
                            ),
                          )
                        ],
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0; i < _selection.length; i++) {
                              _selection[i] = i == index;
                              if (index == 0)
                                filterstatus = "";
                              else if (index == 1) {
                                filterstatus = "1";
                                // Added 24 (status price enquiry) in list
                                filterList = [20, 24];
                              } else {
                                filterstatus = "1";
                                filterList = [21, 22];
                              }
                            }
                          });
                        },
                        isSelected: _selection,
                        color: Colors.grey,
                        selectedColor: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                        borderColor: Colors.grey,
                        borderWidth: 1,
                        selectedBorderColor: Colors.green,
                      )
                    ],
                  ),
                ),
                new Expanded(
                    child: new ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if ((filter == "") && (filterstatus == "")) {
                            return new Card(
                              elevation: 10,
                              child: ListTile(
                                onTap: () {
                                  AgentListHome homelist = snapshot.data[index];
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          CompletedRequestView(
                                              homelist: homelist)));
                                },
                                title: Text(snapshot.data[index].requestId +
                                    ' - ' +
                                    snapshot.data[index].workshop.merchantName),
                                subtitle: Text(
                                    "${snapshot.data[index].part.partName}"),
                                trailing: Text(textStatus[index]),
                              ),
                            );
                          } else if ((filter != "") && (filterstatus != "")) {
                            return (snapshot.data[index].requestId
                                            .toString()
                                            .toLowerCase()
                                            .contains(filter) ||
                                        //Filter records using search input in Merchant Name
                                        snapshot
                                            .data[index].workshop.merchantName
                                            .toString()
                                            .toLowerCase()
                                            .contains(filter) ||
                                        //Filter records using search input in part name case insensitive
                                        snapshot.data[index].part.partName
                                            .toLowerCase()
                                            .contains(filter) ||
                                        //Filter records using search input in trailing text
                                        textStatus[index]
                                            .toLowerCase()
                                            .contains(filter)) &&
                                    (filterList
                                        .contains(snapshot.data[index].status))
                                ? new Card(
                                    elevation: 10,
                                    child: ListTile(
                                      onTap: () {
                                        AgentListHome homelist =
                                            snapshot.data[index];
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CompletedRequestView(
                                                        homelist: homelist)));
                                      },
                                      title: Text(
                                          snapshot.data[index].requestId +
                                              ' - ' +
                                              snapshot.data[index].workshop
                                                  .merchantName),
                                      subtitle: Text(
                                          "${snapshot.data[index].part.partName}"),
                                      trailing: Text(textStatus[index]),
                                    ),
                                  )
                                : new Container();
                          } else if ((filter == "") && (filterstatus != "")) {
                            return filterList
                                    .contains(snapshot.data[index].status)
                                ? new Card(
                                    elevation: 10,
                                    child: ListTile(
                                        onTap: () {
                                          AgentListHome homelist =
                                              snapshot.data[index];
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CompletedRequestView(
                                                          homelist: homelist)));
                                        },
                                        title: Text(
                                            snapshot.data[index].requestId +
                                                ' - ' +
                                                snapshot.data[index].workshop
                                                    .merchantName),
                                        subtitle: Text(
                                            "${snapshot.data[index].part.partName}"),
                                        // Added value of final price on the card
                                        // purpose to show the price entered for enquiry
                                        // (but shows of all status records)
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text("${textStatus[index]}"),
                                            Text(NumberFormat.currency(
                                                    name: 'AED ')
                                                .format(snapshot.data[index]
                                                    .reqtab.finalPrice)),
                                          ],
                                        )),
                                  )
                                : new Container();
                          } else if ((filter != "") && (filterstatus == "")) {
                            return snapshot.data[index].requestId
                                        .toString()
                                        .toLowerCase()
                                        .contains(filter) ||
                                    //Filter records using search input in Merchant Name
                                    snapshot.data[index].workshop.merchantName
                                        .toString()
                                        .toLowerCase()
                                        .contains(filter) ||
                                    //Filter records using search input in part name case insensitive
                                    snapshot.data[index].part.partName
                                        .toLowerCase()
                                        .contains(filter) ||
                                    textStatus[index]
                                        .toLowerCase()
                                        .contains(filter)
                                ? new Card(
                                    elevation: 10,
                                    child: ListTile(
                                      onTap: () {
                                        AgentListHome homelist =
                                            snapshot.data[index];
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CompletedRequestView(
                                                        homelist: homelist)));
                                      },
                                      title: Text(
                                          snapshot.data[index].requestId +
                                              ' - ' +
                                              snapshot.data[index].workshop
                                                  .merchantName),
                                      subtitle: Text(
                                          "${snapshot.data[index].part.partName}"),
                                      // Added value of final price on the card
                                      // purpose to show the price entered for enquiry
                                      // (but shows of all status records)
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("${textStatus[index]}"),
                                          Text(NumberFormat.currency(
                                                  name: 'AED ')
                                              .format(snapshot.data[index]
                                                  .reqtab.finalPrice)),
                                        ],
                                      ),
                                    ),
                                  )
                                : new Container();
                          } else {
                            return new Container();
                          }
                        }))
              ],
            ));
          }
        },
      ),
    );
  }

  Future<List<AgentListHome>> _getProductList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int merchantId = prefs.getInt("merchantid") ?? 0;
    // Added filter to fetch records with status 24
    var jsonData = await new ApiRequest().getDataFromAPI("reqagntabs",
        "={\"where\": {\"or\":[{\"and\":[{\"agent_id\": \"$merchantId\"},{\"status\": \"20\"},{\"reqStatus\": \"A\"}]},{\"and\": [{\"agent_id\": \"$merchantId\"},{\"status\": \"21\"},{\"reqStatus\": \"C\"}]},{\"and\": [{\"agent_id\": \"$merchantId\"},{\"status\": \"22\"},{\"reqStatus\": \"C\"}]}, {\"and\": [{\"agent_id\": \"$merchantId\"},{\"status\": \"24\"},{\"reqStatus\": \"A\"}]}]},\"order\": [\"id DESC\"],\"include\": [{\"relation\": \"part\"},{\"relation\": \"vehicle\"},{\"relation\": \"workshop\"},{\"relation\": \"agent\"},{\"relation\": \"reqtab\",\"scope\": {\"include\": [{\"relation\": \"requestimages\"}]}}]}");
    List<AgentListHome> products = [];
    textStatus.clear();
    try {
      for (var prod in jsonData) {
        AgentListHome product = AgentListHome.fromJson(prod);
        products.add(product);
        if (product.status == 20)
          textStatus.add("Released");
        else if (product.status == 21)
          textStatus.add("Purchased");
        else if (product.status == 22)
          textStatus.add("Confirmed");
        else if (product.status == 24)
          textStatus.add("Price Enquiry");
        else
          textStatus.add("");
      }
    } catch (e) {
      print(e);
    }
    //print(products.length);
    return products;
  }
}
