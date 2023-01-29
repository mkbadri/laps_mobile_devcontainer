import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:laps/agent.dart';
import 'package:laps/commonFunction/ApiRequest.dart';
import 'package:laps/dealer.dart';
import 'package:laps/model/UserInfo.dart';
import 'package:laps/model/LoadingImage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  // To load the configration file
  // To access - DotEnv().env['variable_name'];
  await DotEnv().load('config/config.env');
  runApp(LapsApp());
}

class LapsApp extends StatefulWidget {
  @override
  _LapsAppState createState() => _LapsAppState();
}

class _LapsAppState extends State<LapsApp> {
  bool isValidSession = false;
  int roleId;
  bool setSession = false;
  
  
  Future<void> validateSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String sessiontoken = prefs.getString("sessiontoken") ?? "";
    roleId = prefs.getInt("roleid") ?? 0;
    if (sessiontoken.length != 0) {
      setSession = await ApiRequest().postLoginAuthAPI();
    }
    setState(() {
      if (sessiontoken.length == 0) {
        isValidSession = false;
      } else {
        isValidSession = setSession;
      }
    });
  }

  @override
  void initState() {
    validateSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isValidSession)
      if(roleId == 1){
        return MaterialApp(
          home: DealerHomeScreen(),
        );
      }else if(roleId == 2){
        return MaterialApp(
          home: Agent(),
        );
      }else{
        return MaterialApp(
        theme: ThemeData(backgroundColor: Colors.grey),
        home: LoginPage(),
      );
      }
    else
      return MaterialApp(
        theme: ThemeData(backgroundColor: Colors.grey),
        home: LoginPage(),
      );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userID = TextEditingController();
  final password = TextEditingController();
  String errMsg = "";
  bool isLoading = false;

  void setUserInfo(
      UserInfo userinfo, String sessionToken,String deviceToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", userinfo.id);
    prefs.setString("username", userinfo.userName);
    prefs.setString("userloginid", userinfo.loginId);
    prefs.setString("useremailid", userinfo.userEmailId);
    prefs.setString("usermobileno", userinfo.userMobileNo);
    prefs.setInt("roleid", userinfo.roleId);
    prefs.setInt("roletype", userinfo.roleType);
    prefs.setInt("merchantid", userinfo.merchantId);
    prefs.setString("merchantname", userinfo.merchantName);
    prefs.setString("merchantaddress", userinfo.merchantAddress);
    prefs.setString("merchantmobileno", userinfo.merchantMobileNo);
    prefs.setString("sessiontoken", sessionToken);
    prefs.setString("devicetoken", deviceToken);
    print("Done setUserInfo");
  }

  void _onClickLoginBtn(String userid, String password) async {
    //Call API for login validation
    print(userid + ' - ' + password);
    String requestBody = jsonEncode(
            {"user_loginid": "$userid", "user_password": "$password"});
    var postres = await new ApiRequest().postLoginAPI("login", requestBody);
    
    if (postres.statusCode == 200) {
      Map responseBody = jsonDecode(postres.body);
      if (responseBody['status'] == 1) {
        UserInfo userinfo =
            new UserInfo.fromJson(responseBody['resultdata'][0]['userInfo'][0]);
        String sessionToken = responseBody['resultdata'][2]['session'];
        String deviceToken = responseBody['resultdata'][1]['deviceToken'];
        await setUserInfo(userinfo, sessionToken,deviceToken);
        if(userinfo.roleId==1){
          print("Navigated");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DealerHomeScreen()),
          );
        }else if(userinfo.roleId==2){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Agent()),
          );
        }else{
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.clear();
          errorMsg(1);
        }
        
      } else {
        print("$responseBody['status']" + " - Error");
        errorMsg(1);
      }
    } else {
      print("${postres.statusCode}" + " - Error");
      errorMsg(1);
    }
  }

  void errorMsg(int key) {
    setState(() {
      if (key == 1)
        errMsg = "Invaid user ID or Password..!";
      else
        errMsg = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    // Custom Text Style for input fields
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    final logoDisplay = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image(
        height: 75,
        width: 200,
        image: AssetImage('assets/logo.png'),
      ),
    );

    // Code for userID textbox
    final userField = Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          obscureText: false,
          style: style,
          controller: userID,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));
    // Code for password textbox
    final passwordField = Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          obscureText: true,
          style: style,
          controller: password,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
        ));
    // Code for login button
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF1E5085),
      child: MaterialButton(
        elevation: 20,
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _onClickLoginBtn(userID.text, password.text);
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
      ),
    );

    return isLoading
        ? Center(
            child: new LoadingImage().loadingImage,
          )
        : Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logoDisplay,
              Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        elevation: 50,
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(children: <Widget>[
                              userField,
                              passwordField,
                              loginButton,
                              Text(
                                "$errMsg",
                                style: TextStyle(color: Colors.red),
                              ),
                            ]))))
              ])
            ]),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
