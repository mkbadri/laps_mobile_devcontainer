import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    getUserDetails();
    getVersionDetails();
  }

  String userName = '';
  String userLoginId = '';
  String userEmailId = '';
  String userMobileNo = '';
  int roleType;
  String merchantName = '';
  String merchantAddress = '';
  String merchantMobileNo = '';
  String roleName = '';
  String versionName = '';
  String versionCode = '';

  void getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("username") ?? "unknown";
      userLoginId = prefs.getString("userloginid") ?? "unknown";
      merchantName = prefs.getString("merchantname") ?? "unknown";
      userEmailId = prefs.getString("useremailid") ?? "unknown";
      userMobileNo = prefs.getString("usermobileno") ?? "unknown";
      roleType = prefs.getInt("roletype") ?? 0;
      merchantAddress = prefs.getString("merchantaddress") ?? "unknown";
      merchantMobileNo = prefs.getString("merchantmobileno") ?? "unknown";
      if (roleType == 1) {
        roleName = 'Supplier';
      } else if (roleType == 2) {
        roleName = 'Agent';
      }
    });
  }

  void getVersionDetails() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        versionName = packageInfo.version;
        versionCode = packageInfo.buildNumber;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget divider = const Divider(
    height: 20,
    color: Colors.grey,
    indent: 20,
    endIndent: 20,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        viewUsernameAndId(userName, userLoginId),
        viewRowProfileDetails("E-mail", userEmailId),
        viewRowProfileDetails("Phone", userMobileNo),
        divider,
        viewRowProfileDetails(roleName + " Name", merchantName),
        viewRowProfileDetails(roleName + " Mobile", merchantMobileNo),
        viewRowProfileDetails(roleName + " Address", merchantAddress),
        divider,
        viewAppVersion("Version $versionName+$versionCode Build"),
      ],
    ));
  }

  Widget viewUsernameAndId(String userName, String userLoginId) {
    return Container(
        padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              userName,
              style: new TextStyle(
                fontSize: 30.0,
                //fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 10,
              color: Colors.white,
            ),
            Text(
              userLoginId,
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ],
        ));
  }

  Widget viewRowProfileDetails(String key, String value) {
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 17.0, 30.0, 17.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: new TextStyle(
              color: Colors.blue[900],
              fontSize: 16.0,
            ),
          ),
          new Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    textAlign: TextAlign.right,
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget viewLogout() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Logout",
              style: new TextStyle(
                color: Colors.blue[900],
                fontSize: 16.0,
              ),
            ),
            Icon(
              Icons.exit_to_app,
              size: 35,
              color: Colors.grey[600],
            )
          ],
        ),
      ),
      onTap: () {
        // showAlertDialog(context);
      },
    );
  }

  Widget viewAppVersion(String version) {
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
      child: Text(
        version,
        style: new TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
