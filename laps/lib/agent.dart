import 'package:flutter/material.dart';
import 'package:laps/agent/AgentHomeScreen.dart';
import 'package:laps/agent/CompletedRequestHome.dart';
import 'package:laps/agent/SupplierViewInAgent.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/commonFunction/profile.dart';
import 'package:laps/main.dart';
import 'package:laps/styles/styles.dart';
import 'package:scaffold_tab_bar/scaffold_tab_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Agent extends StatefulWidget {
  @override
  _AgentState createState() => _AgentState();
}

class _AgentState extends State<Agent> {
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
                },
              ),
            ],
            leading: GestureDetector(
              child: Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Agent()),
                    (Route<dynamic> route) => false);
              },
            )),
        body: ScaffoldTabBar(
          children: [
            ScreenTab(
              screen: AgentHomeScreen(),
              tab: BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
            ),
            ScreenTab(
              screen: SupplierViewInAgent(),
              tab: BottomNavigationBarItem(
                icon: Icon(Icons.airplay),
                title: Text('Suppliers'),
              ),
            ),
            ScreenTab(
              screen: CompletedRequestHome(),
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
          await ApiRequest().postLogoutAPI();
          preferences.clear();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false);
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
