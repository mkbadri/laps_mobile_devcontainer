import 'package:flutter/material.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/commonFunction/profile.dart';
import 'package:laps/dealer/RequestFromAgent.dart';
import 'package:laps/dealer/CompleteHome.dart';
import 'package:laps/main.dart';
import 'package:laps/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scaffold_tab_bar/scaffold_tab_bar.dart';

import 'dealer/AddProduct.dart';
import 'dealer/HomeScreen.dart';

class DealerHomeScreen extends StatefulWidget {
  @override
  _DealerHomeScreenState createState() => _DealerHomeScreenState();
}

class _DealerHomeScreenState extends State<DealerHomeScreen> {
  @override
  void initState() {
    super.initState();
    getUserName();
  }

  String username = '';
  String merchantName = '';
  void getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username") ?? "unknown";
      merchantName = prefs.getString("merchantname") ?? "unknown";
    });
  }

  @override
  Widget build(BuildContext context) {
    // getUserName("username");
    return MaterialApp(
      theme: appTheme,
      initialRoute: "/",
      home: Scaffold(
        appBar: AppBar(
            title: Text(merchantName.toUpperCase() + '\n' + username),
            actions: <Widget>[
              IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                showAlertDialog(context);
              },),
            ],
            leading: GestureDetector(
              child: Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => DealerHomeScreen()),
                  (Route<dynamic> route) => false);
              },
            )),
        body: ScaffoldTabBar(
          children: [
            ScreenTab(
              screen: HomeScreen(),
              tab: BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
            ),
            ScreenTab(
              screen: AddProduct(),
              tab: BottomNavigationBarItem(
                icon: Icon(Icons.add),
                title: Text('Add Parts'),
              ),
            ),
            ScreenTab(
              screen: RequestFromAgent(),
              //screen: Text('Request'),
              tab: BottomNavigationBarItem(
                icon: Icon(Icons.message),
                title: Text('Request'),
              ),
            ),
            ScreenTab(
              screen: CompletedHome(),
              //screen: Text('Request'),
              tab: BottomNavigationBarItem(
                icon: Icon(Icons.history),
                title: Text('Completed'),
              ),
            ),
            ScreenTab(
              //screen: showAlertDialog(context),
              screen: Profile(),
              tab: BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method for logout : Should be moved on later stage of development
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget logoutButton = FlatButton(
      child: Text("Logout"),
      onPressed: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        //Cleares the Data stored in local
        try {
          var data = await ApiRequest().postLogoutAPI();
          if(data.statusCode == 200){
            preferences.clear();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false);
          }
        } catch (e) {
          preferences.clear();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
        }
        
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout?"),
      content: Text("Would you like to logout?"),
      actions: [
        cancelButton,
        logoutButton,
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
