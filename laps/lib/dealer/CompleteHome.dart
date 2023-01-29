import 'package:flutter/material.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/model/LoadingImage.dart';
import 'package:laps/model/DealerListCompleted.dart';
import 'package:laps/dealer/CompletedView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedHome extends StatefulWidget {
  @override
  _CompletedHomeState createState() => _CompletedHomeState();
}

class _CompletedHomeState extends State<CompletedHome> {
  TextEditingController searchText = new TextEditingController();
  String filter = "",filterstatus = "";
  Future<List<DealerListCompleted>> listData; 
  List<bool> _selection;
  List<String> textStatus = [];

  // Add listen for text search. Add search value to filter variable. Convert to lowercase for case insensitive
  @override
  void initState() {
    _selection = [true, false,false];
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
                                  Text("Sold"),
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
                                  if(index==0)
                                    filterstatus = "";
                                  else if (index==1)
                                    filterstatus = "s";
                                  else 
                                    filterstatus = "p";
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
                          if((filter =="") && (filterstatus =="")){
                    return 
                      new Card(
                        elevation: 10,
                        child: ListTile(
                          onTap: () {
                            DealerListCompleted homelist = snapshot.data[index]; 
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CompletedView(homelist: homelist) 
                            ));
                            
                          },
                          title: Text(snapshot.data[index].vehicle.vehicleMake +
                                      ' - ' +
                                      snapshot.data[index].vehicle.vehicleModel +
                                      ' - ' +
                                      snapshot.data[index].part.partName), 
                          subtitle: new Text("${snapshot.data[index].productNotes}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                          trailing: Text(textStatus[index]),
                                    ),
                      );
                  } else if ((filter !="") && (filterstatus !="")){
                    return (snapshot.data[index].vehicle.vehicleMake.toString().toLowerCase().contains(filter) || 
                          snapshot.data[index].vehicle.vehicleModel.toString().toLowerCase().contains(filter) || 
                          snapshot.data[index].part.partName.toLowerCase().contains(filter) ||
                          snapshot.data[index].productNotes.toLowerCase().contains(filter) //||
                          //snapshot.data[index].productPrice.toLowerCase().contains(filter)
                          ) && 
                          (snapshot.data[index].productStatus.toString().toLowerCase().contains(filterstatus)) ? 
                      new Card(
                        elevation: 10,
                        child: ListTile(
                          onTap: () {
                            DealerListCompleted homelist = snapshot.data[index]; 
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CompletedView(homelist: homelist)
                            ));
                          },
                          title: Text(snapshot.data[index].vehicle.vehicleMake +
                                      ' - ' +
                                      snapshot.data[index].vehicle.vehicleModel +
                                      ' - ' +
                                      snapshot.data[index].part.partName), 
                          subtitle: new Text("${snapshot.data[index].productNotes}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                         // trailing: Text(NumberFormat.currency(name: 'AED ')
                         //             .format(snapshot.data[index].productPrice)),
                        ),
                      ): new Container();

                  } else if ((filter =="") && (filterstatus !="")){
                    return snapshot.data[index].productStatus.toString().toLowerCase().contains(filterstatus) ? 
                      new Card(
                      
                        elevation: 10,
                        child: ListTile(
                          onTap: () {
                            DealerListCompleted homelist = snapshot.data[index]; 
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CompletedView(homelist: homelist) 
                            ));
                          },
                          title: Text(snapshot.data[index].vehicle.vehicleMake +
                                      ' - ' +
                                      snapshot.data[index].vehicle.vehicleModel +
                                      ' - ' +
                                      snapshot.data[index].part.partName), 
                          subtitle: new Text("${snapshot.data[index].productNotes}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                         // trailing: Text(NumberFormat.currency(name: 'AED ')
                         //             .format(snapshot.data[index].productPrice)),
                        ),
                      ): new Container();

                  } else if ((filter !="") && (filterstatus =="")){
                    return snapshot.data[index].vehicle.vehicleMake.toString().toLowerCase().contains(filter) || 
                          //Filter records using search input in Merchant Name
                          snapshot.data[index].vehicle.vehicleModel.toString().toLowerCase().contains(filter) || 
                          //Filter records using search input in part name case insensitive
                          snapshot.data[index].part.partName.toLowerCase().contains(filter) ||
                          snapshot.data[index].productNotes.toLowerCase().contains(filter) || 
                          textStatus[index].toLowerCase().contains(filter) ?
                      new Card(
                        elevation: 10,
                        child: ListTile(
                          onTap: () {
                            DealerListCompleted homelist = snapshot.data[index]; 
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CompletedView(homelist: homelist) 
                            ));
                          },
                          title: Text(snapshot.data[index].vehicle.vehicleMake +
                                      ' - ' +
                                      snapshot.data[index].vehicle.vehicleModel +
                                      ' - ' +
                                      snapshot.data[index].part.partName), 
                          subtitle: new Text("${snapshot.data[index].productNotes}",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                          trailing: Text(textStatus[index]),
                        ),
                      ): new Container();
                    
                  }
                  else{
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

  Future<List<DealerListCompleted>> _getProductList() async { 
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int merchantId = prefs.getInt("merchantid") ?? 0;
    var jsonData = await new ApiRequest().getDataFromAPI("products", 
        "={\"where\": {\"merchant_id\": \"$merchantId\",\"productStatus\": {\"inq\": [\"P\", \"S\"]}},\"order\": [\"id DESC\"],\"include\": [{\"relation\": \"merchant\"},{\"relation\": \"vehicle\"},{\"relation\": \"part\"},{\"relation\": \"productimages\"},{\"relation\": \"productreqact\",\"scope\": {\"where\": {\"status\": \"151\"}}}]}");
 
    List<DealerListCompleted> products = []; 
    try {
      for (var prod in jsonData) {
        DealerListCompleted product = DealerListCompleted.fromJson(prod); 
        products.add(product);
        if(product.productStatus=='S') textStatus.add("Sold"); 
        else if(product.productStatus=='P') textStatus.add("Purchased");
        else textStatus.add("");
      }
    } catch (e) {
      print(e);
    }
    return products;
  }
}