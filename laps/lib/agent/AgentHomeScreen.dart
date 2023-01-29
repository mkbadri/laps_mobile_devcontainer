import 'package:flutter/material.dart';
import 'package:laps/agent/FromDealer.dart';
import 'package:laps/agent/FromWorkshop.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/model/AgentListHome.dart';
import 'package:laps/model/LoadingImage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentHomeScreen extends StatefulWidget {
  @override
  _AgentHomeScreenState createState() => _AgentHomeScreenState();
}

class _AgentHomeScreenState extends State<AgentHomeScreen> {
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
                            // setState(() {
                            //   listData = _getProductList();
                            // });
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => AgentHomeScreen()),
                                (Route<dynamic> route) => false);
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
                                Text("Buyer Requests"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: Row(
                              children: <Widget>[
                                Text("Supplier Quotes"),
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
                                filterList = [11];
                              } else {
                                // FilterStatus is used to check only the existence
                                filterstatus = "1";
                                filterList = [12, 13, 14];
                              }
                            }
                            //_selection[index] = !_selection[index];
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
                              //color: snapshot.data[index].status == 13 ? Colors.green[200] : Colors.grey[200],
                              shape: snapshot.data[index].status == 14
                                  ? new Border(
                                      right: BorderSide(
                                          color: Colors.green, width: 10))
                                  : snapshot.data[index].status == 13
                                      ? new Border(
                                          right: BorderSide(
                                              color: Colors.amber, width: 10))
                                      : new Border(),
                              elevation: 10,
                              child: ListTile(
                                onTap: () {
                                  AgentListHome homelist = snapshot.data[index];
                                  if (snapshot.data[index].status == 11)
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          FromWorkshop(homelist: homelist),
                                    ));
                                  else
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          FromDealer(homelist: homelist),
                                    ));
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
                                        textStatus[index]
                                            .toLowerCase()
                                            .contains(filter)) &&
                                    (filterList
                                        .contains(snapshot.data[index].status))
                                ? new Card(
                                    shape: snapshot.data[index].status == 14
                                        ? new Border(
                                            right: BorderSide(
                                                color: Colors.green, width: 10))
                                        : snapshot.data[index].status == 13
                                            ? new Border(
                                                right: BorderSide(
                                                    color: Colors.amber,
                                                    width: 10))
                                            : new Border(),
                                    elevation: 10,
                                    child: ListTile(
                                      onTap: () {
                                        AgentListHome homelist =
                                            snapshot.data[index];
                                        if (snapshot.data[index].status == 11)
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => FromWorkshop(
                                                homelist: homelist),
                                          ));
                                        else
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                FromDealer(homelist: homelist),
                                          ));
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
                            // return snapshot.data[index].status.toString().toLowerCase().contains(filterstatus) ?
                            return filterList
                                    .contains(snapshot.data[index].status)
                                ? new Card(
                                    shape: snapshot.data[index].status == 14
                                        ? new Border(
                                            right: BorderSide(
                                                color: Colors.green, width: 10))
                                        : snapshot.data[index].status == 13
                                            ? new Border(
                                                right: BorderSide(
                                                    color: Colors.amber,
                                                    width: 10))
                                            : new Border(),
                                    //color: snapshot.data[index].status == 14 ? Colors.green[200] : Colors.grey[200],
                                    elevation: 10,
                                    child: ListTile(
                                      onTap: () {
                                        AgentListHome homelist =
                                            snapshot.data[index];
                                        if (snapshot.data[index].status == 11)
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => FromWorkshop(
                                                homelist: homelist),
                                          ));
                                        else
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                FromDealer(homelist: homelist),
                                          ));
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
                                    shape: snapshot.data[index].status == 14
                                        ? new Border(
                                            right: BorderSide(
                                                color: Colors.green, width: 10))
                                        : snapshot.data[index].status == 13
                                            ? new Border(
                                                right: BorderSide(
                                                    color: Colors.amber,
                                                    width: 10))
                                            : new Border(),
                                    elevation: 10,
                                    child: ListTile(
                                      onTap: () {
                                        AgentListHome homelist =
                                            snapshot.data[index];
                                        if (snapshot.data[index].status == 11)
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => FromWorkshop(
                                                homelist: homelist),
                                          ));
                                        else
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                FromDealer(homelist: homelist),
                                          ));
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
    var jsonData = await new ApiRequest().getDataFromAPI(
        "reqagntabs",
        //"[include][0][relation]=part&filter[include][1][relation]=vehicle&filter[include][2][relation]=workshop&filter[include][3][relation]=agent&filter[include][4][relation]=reqtab&filter[where][agent_id]=$merchantId&filter[where][reqStatus]=A&filter[where][status][between][0]=10&filter[where][status][between][1]=19&filter[order][0]=id DESC");
        "={\"where\": {\"agent_id\": \"$merchantId\",\"reqStatus\": \"A\",\"status\": {\"between\": [10,19]}},\"order\": [\"id DESC\"],\"include\": [{\"relation\": \"reqtab\",\"scope\": {\"include\": [{\"relation\": \"requestimages\"}]}},{\"relation\": \"workshop\"},{\"relation\": \"vehicle\"},{\"relation\": \"part\"},{\"relation\": \"agent\"}]}");
    List<AgentListHome> products = [];
    try {
      for (var prod in jsonData) {
        AgentListHome product = AgentListHome.fromJson(prod);
        products.add(product);
        if (product.status == 11)
          textStatus.add("New");
        else if (product.status == 12)
          textStatus.add("Pending");
        else if (product.status == 13)
          textStatus.add("Partial");
        else if (product.status == 14)
          textStatus.add("Received");
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
