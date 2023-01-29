import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/dealer/ViewProducts.dart';
import 'package:laps/model/DealerList.dart';
import 'package:laps/model/LoadingImage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchText = new TextEditingController();
  String filter;
  Future<List<DealerList>> listData;

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
                          return filter == null || filter == ""
                              ? new Card(
                                  elevation: 10,
                                  child: ListTile(
                                    onTap: () {
                                      //_showDialog(snapshot.data[index]);
                                      DealerList dealerList =
                                          snapshot.data[index];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewProducts(product: dealerList),
                                        ),
                                      );
                                    },
                                    // leading: Image.network("https://homepages.cae.wisc.edu/~ece533/images/airplane.png"),
                                    //leading: Text("${snapshot.data[index].id}"),
                                    title: Text(snapshot
                                            .data[index].vehicle.vehicleMake +
                                        ' - ' +
                                        snapshot
                                            .data[index].vehicle.vehicleModel +
                                        ' - ' +
                                        // Hidden all variant as per client request
                                        // snapshot.data[index].vehicle.vehicleVariant +
                                        //  ' - ' +
                                        snapshot.data[index].part.partName),
                                    //subtitle: Text("${snapshot.data[index].productNotes}"),
                                    subtitle: new Text(
                                      "${snapshot.data[index].productNotes}",
                                      overflow: TextOverflow.ellipsis,
                                      //maxLines: 2,
                                      //softWrap: false,
                                    ),
                                    //Number format to covert price to AED and display on screen
                                    trailing: Text(NumberFormat.currency(
                                            name: 'AED ')
                                        .format(
                                            snapshot.data[index].productPrice)),
                                  ),
                                )
                              :
                              //Filter records using search input in Vehicle Make
                              snapshot.data[index].vehicle.vehicleMake
                                          .toLowerCase()
                                          .contains(filter) ||
                                      //Filter records using search input in product price
                                      snapshot.data[index].productPrice
                                          .toString()
                                          .toLowerCase()
                                          .contains(filter) ||
                                      //Filter records using search input in product notes case insensitive
                                      snapshot.data[index].productNotes
                                          .toLowerCase()
                                          .contains(filter) ||
                                      //Filter records using search input in part name case insensitive
                                      snapshot.data[index].part.partName
                                          .toLowerCase()
                                          .contains(filter) ||
                                      //Filter records using search input in vehicle variant case insensitive
                                      // Hidden all variant as per client request
                                      //  snapshot.data[index].vehicle.vehicleVariant.toLowerCase().contains(filter) ||
                                      //Filter records using search input in Chassis number case insensitive
                                      snapshot.data[index].productChassisnum
                                          .toLowerCase()
                                          .contains(filter) ||
                                      //Filter records using search input in vehicle model case insensitive
                                      snapshot.data[index].vehicle.vehicleModel
                                          .toLowerCase()
                                          .contains(filter)
                                  ?
                                  // Show filtered records
                                  new Card(
                                      elevation: 10,
                                      child: ListTile(
                                        onTap: () {
                                          //_showDialog(snapshot.data[index]);
                                          DealerList dealerList =
                                              snapshot.data[index];
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewProducts(
                                                      product: dealerList),
                                            ),
                                          );
                                        },
                                        // leading: Image.network("https://homepages.cae.wisc.edu/~ece533/images/airplane.png"),
                                        //leading: Text("${snapshot.data[index].id}"),
                                        title: Text(snapshot.data[index].vehicle
                                                .vehicleMake +
                                            ' - ' +
                                            snapshot.data[index].vehicle
                                                .vehicleModel +
                                            ' - ' +
                                            // Hidden all variant as per client request
                                            // snapshot.data[index].vehicle.vehicleVariant +
                                            // ' - ' +
                                            snapshot.data[index].part.partName),
                                        //subtitle: Text("${snapshot.data[index].productNotes}"),
                                        subtitle: new Text(
                                          "${snapshot.data[index].productNotes}",
                                          overflow: TextOverflow.ellipsis,
                                          //maxLines: 2,
                                          //softWrap: false,
                                        ),
                                        //Number format to covert price to AED and display on screen
                                        trailing: Text(
                                            NumberFormat.currency(name: 'AED ')
                                                .format(snapshot
                                                    .data[index].productPrice)),
                                      ),
                                    )
                                  : new Container();
                        }))
              ],
            ));
          }
        },
      ),
    );
  }

  Future<List<DealerList>> _getProductList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int merchantId = prefs.getInt("merchantid") ?? 0;
    var jsonData = await new ApiRequest().getDataFromAPI(
        "products",
        "[include][0][relation]=merchant&filter[include][1][relation]=vehicle&filter[include][2][relation]=part&filter[include][3][relation]=productimages&filter[where][productStatus]=A&filter[where][merchant_id]=$merchantId" +
            "&filter[order][0]=id DESC");

    List<DealerList> products = [];
    try {
      for (var prod in jsonData) {
        DealerList product = DealerList.fromJson(prod);
        products.add(product);
      }
    } catch (e) {
      print(e);
    }
    //print(products.length);
    return products;
  }
}
