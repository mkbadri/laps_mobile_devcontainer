import 'package:flutter/material.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/model/AgentListSupplierHome.dart';
import 'package:laps/model/LoadingImage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierViewInAgent extends StatefulWidget {
  @override
  _SupplierViewInAgentState createState() => _SupplierViewInAgentState();
}

class _SupplierViewInAgentState extends State<SupplierViewInAgent> {
  TextEditingController searchText = new TextEditingController();
  String filter = "", filterstatus = "";
  Future<List<AgentListSupplierHome>> listData;
  List<String> textStatus = [];
  List<int> filterList = [];
  List<AgentsDealerList> listDealer;

  // Add listen for text search. Add search value to filter variable. Convert to lowercase for case insensitive
  @override
  void initState() {
    listData = _getProductList();
    _getDealerList();
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
                            setState(() {
                              listData = _getProductList();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                new Expanded(
                    child: new ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          if ((filter == "") && (filterstatus == "")) {
                            return new Card(
                              shape: snapshot.data[index].status == 131
                                  ? new Border(
                                      right: BorderSide(
                                          color: Colors.green, width: 10))
                                  : snapshot.data[index].status == 130
                                      ? new Border(
                                          right: BorderSide(
                                              color: Colors.red, width: 10))
                                      : snapshot.data[index].status == 120
                                          ? new Border(
                                              right: BorderSide(
                                                  color: Colors.amber,
                                                  width: 10))
                                          : new Border(),
                              elevation: 10,
                              child: ListTile(
                                onTap: () {},
                                title: Text(
                                    snapshot.data[index].requestId +
                                        ' - ' +
                                        snapshot
                                            .data[index].dealer.merchantName,
                                    overflow: TextOverflow.ellipsis),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "${snapshot.data[index].vehicle.vehicleMake} - ${snapshot.data[index].vehicle.vehicleModel} - ${snapshot.data[index].vehicle.vehicleYear}",
                                        overflow: TextOverflow.ellipsis),
                                    Text(
                                        "${snapshot.data[index].part.partName} - ${snapshot.data[index].product.productNotes}",
                                        overflow: TextOverflow.ellipsis)
                                  ],
                                ),
                                isThreeLine: true,
                                trailing: Text(textStatus[index]),
                              ),
                            );
                          } else if ((filter != "") && (filterstatus != "")) {
                            return (snapshot.data[index].requestId
                                            .toString()
                                            .toLowerCase()
                                            .contains(filter) ||
                                        //Filter records using search input in Merchant Name
                                        snapshot.data[index].dealer.merchantName
                                            .toString()
                                            .toLowerCase()
                                            .contains(filter) ||
                                        //Filter records using search input in part name case insensitive
                                        snapshot.data[index].part.partName
                                            .toLowerCase()
                                            .contains(filter) ||
                                        snapshot.data[index].vehicle.vehicleMake
                                            .toLowerCase()
                                            .contains(filter) ||
                                        snapshot
                                            .data[index].vehicle.vehicleModel
                                            .toLowerCase()
                                            .contains(filter) ||
                                        snapshot.data[index].vehicle.vehicleYear
                                            .toLowerCase()
                                            .contains(filter) ||
                                        snapshot
                                            .data[index].product.productNotes
                                            .toLowerCase()
                                            .contains(filter) ||
                                        textStatus[index]
                                            .toLowerCase()
                                            .contains(filter)) &&
                                    (snapshot.data[index].status
                                        .toString()
                                        .toLowerCase()
                                        .contains(filterstatus))
                                ? new Card(
                                    shape: snapshot.data[index].status == 131
                                        ? new Border(
                                            right: BorderSide(
                                                color: Colors.green, width: 10))
                                        : snapshot.data[index].status == 130
                                            ? new Border(
                                                right: BorderSide(
                                                    color: Colors.red,
                                                    width: 10))
                                            : snapshot.data[index].status == 120
                                                ? new Border(
                                                    right: BorderSide(
                                                        color: Colors.amber,
                                                        width: 10))
                                                : new Border(),
                                    elevation: 10,
                                    child: ListTile(
                                      onTap: () {},
                                      title: Text(
                                          snapshot.data[index].requestId +
                                              ' - ' +
                                              snapshot.data[index].dealer
                                                  .merchantName,
                                          overflow: TextOverflow.ellipsis),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              "${snapshot.data[index].vehicle.vehicleMake} - ${snapshot.data[index].vehicle.vehicleModel} - ${snapshot.data[index].vehicle.vehicleYear}",
                                              overflow: TextOverflow.ellipsis),
                                          Text(
                                              "${snapshot.data[index].part.partName} - ${snapshot.data[index].product.productNotes}",
                                              overflow: TextOverflow.ellipsis)
                                        ],
                                      ),
                                      isThreeLine: true,
                                      trailing: Text(textStatus[index]),
                                    ),
                                  )
                                : new Container();
                          } else if ((filter == "") && (filterstatus != "")) {
                            // return snapshot.data[index].status.toString().toLowerCase().contains(filterstatus) ?
                            return filterList
                                    .contains(snapshot.data[index].status)
                                ? new Card(
                                    shape: snapshot.data[index].status == 131
                                        ? new Border(
                                            right: BorderSide(
                                                color: Colors.green, width: 10))
                                        : snapshot.data[index].status == 130
                                            ? new Border(
                                                right: BorderSide(
                                                    color: Colors.red,
                                                    width: 10))
                                            : snapshot.data[index].status == 120
                                                ? new Border(
                                                    right: BorderSide(
                                                        color: Colors.amber,
                                                        width: 10))
                                                : new Border(),
                                    //color: snapshot.data[index].status == 14 ? Colors.green[200] : Colors.grey[200],
                                    elevation: 10,
                                    child: ListTile(
                                      onTap: () {},
                                      title: Text(
                                          snapshot.data[index].requestId +
                                              ' - ' +
                                              snapshot.data[index].dealer
                                                  .merchantName,
                                          overflow: TextOverflow.ellipsis),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              "${snapshot.data[index].vehicle.vehicleMake} - ${snapshot.data[index].vehicle.vehicleModel} - ${snapshot.data[index].vehicle.vehicleYear}",
                                              overflow: TextOverflow.ellipsis),
                                          Text(
                                              "${snapshot.data[index].part.partName} - ${snapshot.data[index].product.productNotes}",
                                              overflow: TextOverflow.ellipsis)
                                        ],
                                      ),
                                      isThreeLine: true,
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
                                    snapshot.data[index].dealer.merchantName
                                        .toString()
                                        .toLowerCase()
                                        .contains(filter) ||
                                    //Filter records using search input in part name case insensitive
                                    snapshot.data[index].part.partName
                                        .toLowerCase()
                                        .contains(filter) ||
                                    snapshot.data[index].vehicle.vehicleMake
                                        .toLowerCase()
                                        .contains(filter) ||
                                    snapshot.data[index].vehicle.vehicleModel
                                        .toLowerCase()
                                        .contains(filter) ||
                                    snapshot.data[index].vehicle.vehicleYear
                                        .toLowerCase()
                                        .contains(filter) ||
                                    snapshot.data[index].product.productNotes
                                        .toLowerCase()
                                        .contains(filter) ||
                                    textStatus[index]
                                        .toLowerCase()
                                        .contains(filter)
                                ? new Card(
                                    shape: snapshot.data[index].status == 131
                                        ? new Border(
                                            right: BorderSide(
                                                color: Colors.green, width: 10))
                                        : snapshot.data[index].status == 130
                                            ? new Border(
                                                right: BorderSide(
                                                    color: Colors.red,
                                                    width: 10))
                                            : snapshot.data[index].status == 120
                                                ? new Border(
                                                    right: BorderSide(
                                                        color: Colors.amber,
                                                        width: 10))
                                                : new Border(),
                                    elevation: 10,
                                    child: ListTile(
                                      onTap: () {},
                                      title: Text(
                                          snapshot.data[index].requestId +
                                              ' - ' +
                                              snapshot.data[index].dealer
                                                  .merchantName,
                                          overflow: TextOverflow.ellipsis),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              "${snapshot.data[index].vehicle.vehicleMake} - ${snapshot.data[index].vehicle.vehicleModel} - ${snapshot.data[index].vehicle.vehicleYear}",
                                              overflow: TextOverflow.ellipsis),
                                          Text(
                                              "${snapshot.data[index].part.partName} - ${snapshot.data[index].product.productNotes}",
                                              overflow: TextOverflow.ellipsis)
                                        ],
                                      ),
                                      isThreeLine: true,
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

  Future<List<AgentListSupplierHome>> _getProductList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int merchantId = prefs.getInt("merchantid") ?? 0;
    print("merchantId : $merchantId");
    var jsonData = await new ApiRequest().getDataFromAPI("reqacttabs",
        "[where][agent_id]=$merchantId&filter[where][reqStatus]=A&filter[where][status][between][0]=119&filter[where][status][between][1]=139&filter[include][0][relation]=part&filter[include][1][relation]=vehicle&filter[include][2][relation]=agent&filter[include][3][relation]=dealer&filter[include][4][relation]=reqtab&filter[include][5][relation]=product");
    textStatus.clear();
    List<AgentListSupplierHome> products = [];
    try {
      for (var prod in jsonData) {
        AgentListSupplierHome product = AgentListSupplierHome.fromJson(prod);
        products.add(product);
        if (product.status == 120)
          textStatus.add("Pending");
        else if (product.status == 130)
          textStatus.add("Not Available");
        else if (product.status == 131)
          textStatus.add("Received");
        else
          textStatus.add("unknown");
      }
    } catch (e) {
      print(e);
    }
    //print(products.length);
    return products;
  }

  Future<List<AgentsDealerList>> _getDealerList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int merchantId = prefs.getInt("merchantid") ?? 0;
    print("merchantId : $merchantId");
    String idfilter =
        await ApiRequest().getMerchantidFilter(merchantId, 1, 'id');
    print("merchantidfilter : " + idfilter);
    var jsonData = await new ApiRequest().getDataFromAPI(
        "merchants", "${idfilter}filter[where][merchant_status]=A");
    print(jsonData.toString());
    List<AgentsDealerList> products = [];
    try {
      for (var prod in jsonData) {
        AgentsDealerList product = AgentsDealerList.fromJson(prod);
        products.add(product);
      }
    } catch (e) {
      print(e);
    }
    //print(products.length);
    return products;
  }
}
