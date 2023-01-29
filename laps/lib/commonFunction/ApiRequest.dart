import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:laps/model/MerchantMap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRequest {
  static String APIURL = DotEnv().env['api_url'];

  // Dynamic call for authorization and set updated sessionToken in case of session expired
  dynamic getDataFromAPI(String APIName, String APIFilter) async {
    var _APICall = APIURL + APIName;
    int status = 0, status_counter = 2;
    var data;
    if (APIFilter.length != 0) {
      _APICall = _APICall + '?filter' + APIFilter;
    }
    do {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String sessionToken = prefs.getString("sessiontoken") ?? "unknown";
      String deviceToken = prefs.getString("devicetoken") ?? "unknown";
      print("getDataFromAPI : API Url : " + _APICall);
      print("getDataFromAPI : Header : " + sessionToken);
      data = await get(_APICall, headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $sessionToken",
        "deviceToken": "$deviceToken"
      });
      print("getDataFromAPI : Status Code : ${data.statusCode}");
      if (data.statusCode == 401) {
        if (await postLoginAuthAPI()) {
          status = status + 1;
        } else {
          status = status_counter + 1;
        }
      } else {
        status = status_counter + 1;
      }
    } while (status <= status_counter);
    return jsonDecode(data.body);
  }

  dynamic postDataInAPI(String APIName, String jsondata) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String sessionToken = prefs.getString("sessiontoken") ?? "unknown";
    String deviceToken = prefs.getString("devicetoken") ?? "unknown";
    print("postDataInAPI : URL :" + APIURL + APIName);
    print("postDataInAPI : Data :" + jsondata);
    var data = await post(APIURL + APIName,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $sessionToken",
          "deviceToken": "$deviceToken"
        },
        body: jsondata);
    print("postDataInAPI : Respone : ${data.statusCode}");
    return data;
  }

  dynamic patchDataInAPI(String APIName, String jsondata) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String sessionToken = prefs.getString("sessiontoken") ?? "unknown";
    String deviceToken = prefs.getString("devicetoken") ?? "unknown";
    print("patchDataInAPI : URL :" + APIURL + APIName);
    print("patchDataInAPI : Data :" + jsondata);
    var data = await patch(APIURL + APIName,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $sessionToken",
          "deviceToken": "$deviceToken"
        },
        body: jsondata);
    print("patchDataInAPI : Respone : ${data.statusCode}");
    return data;
  }

  dynamic deleteDataInAPI(String APIName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String sessionToken = prefs.getString("sessiontoken") ?? "unknown";
    String deviceToken = prefs.getString("devicetoken") ?? "unknown";
    print("deleteDataInAPI : URL :" + APIURL + APIName);
    var data = await delete(APIURL + APIName,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $sessionToken",
          "deviceToken": "$deviceToken"
        });
    print("deleteDataInAPI : Respone : ${data.statusCode}");
    return data;
  }

  dynamic postLoginAPI(String APIName, String jsondata) async {
    print("postLoginAPI : URL :" + APIURL + APIName);
    print("postLoginAPI : Data :" + jsondata);
    var data = await post(APIURL + APIName,
        headers: {"Content-type": "application/json"}, body: jsondata);
    print("postLoginAPI : Respone : ${data.statusCode}");
    return data;
  }

  dynamic postLogoutAPI() async {
    String APIName = "logout";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginId = prefs.getString("userloginid") ?? "unknown";
    String sessionToken = prefs.getString("sessiontoken") ?? "unknown";
    String deviceToken = prefs.getString("devicetoken") ?? "unknown";
    String jsondata = jsonEncode({
          "user_loginid": loginId,
          "user_deviceTkn": deviceToken
        });
    
    print("postLoginAPI : URL :" + APIURL + APIName);
    print("postLoginAPI : Data :" + jsondata);
    var data = await post(APIURL + APIName,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $sessionToken",
          "deviceToken": "$deviceToken"
        }, 
        body: jsondata);
    print("postLoginAPI : Respone : ${data.statusCode}");
    return data;
  }

  Future<bool> postLoginAuthAPI() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userLoginID = prefs.getString("userloginid") ?? "";
    String deviceToken = prefs.getString("devicetoken") ?? "";
    String requestBody = jsonEncode(
        {"user_loginid": "$userLoginID", "user_deviceTkn": "$deviceToken"});
    //String sessionToken = prefs.getString("sessiontoken") ?? "unknown";
    print("postDataInAPI : URL :" + APIURL + "authenticate");
    print("postDataInAPI : Data :" + requestBody);
    var data = await post(APIURL + "authenticate",
        headers: {"Content-type": "application/json"}, body: requestBody);
    print("postDataInAPI : Respone : ${data.statusCode}");
    if (data.statusCode == 200) {
      Map responseBody = jsonDecode(data.body);
      if (responseBody['status'] == 1) {
        prefs.remove("sessiontoken");
        prefs.setString(
            "sessiontoken", responseBody['resultdata'][2]['session']);
        return true;
      } else {
        prefs.clear();
        return false;
      }
    } else {
      prefs.clear();
      return false;
    }
  }

  Future<String> getMerchantidFilter(int merchantid,int roleType,String conditionName) async{
    var _APICall = APIURL + "merchantmaps?filter[where][mapRoletype]=$roleType&filter[where][merchantId]=$merchantid";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String sessionToken = prefs.getString("sessiontoken") ?? "unknown";
    String deviceToken = prefs.getString("devicetoken") ?? "unknown";
    String result="";
    List<MerchantMap> merchantMap =[];
    print("API Url : " + _APICall);
    print("Header : " + sessionToken);
    var data = await get(_APICall, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $sessionToken",
      "deviceToken": "$deviceToken"
    });
    print("Status Code : ${data.statusCode}");
    if(data.statusCode == 200){
      var responseData = jsonDecode(data.body);
      
      try {
        for (var json in responseData) {
          MerchantMap merchantMapObject = MerchantMap.fromJson(json);
          merchantMap.add(merchantMapObject);
          
        }
      } catch (e) {
        print(e);
      }
    }
    if(merchantMap.length == 1){
      result = "[where][" + conditionName + "]=${merchantMap.first.mapMerchantid}&";
    }else{
      for (var i=0; i<merchantMap.length; i++) {
        result = result + "filter[where][" + conditionName + "][inq]=${merchantMap[i].mapMerchantid}&";
      }
      result = result.substring(6);
    }
    
    return result;
  }

  // Dynamic call for authorization and set updated sessionToken in case of session expired
  dynamic getDataFromAPIwait(String APIName, String APIFilter) async {
    var _APICall = APIURL + APIName;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String sessionToken = prefs.getString("sessiontoken") ?? "unknown";
    String deviceToken = prefs.getString("devicetoken") ?? "unknown";
    if (APIFilter.length != 0) {
      _APICall = _APICall + '?filter' + APIFilter;
    }
    print("API Url : " + _APICall);
    print("Header : " + sessionToken);
    var data = await get(_APICall, headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $sessionToken",
      "deviceToken": "$deviceToken"
    });
    print("Status Code : ${data.statusCode}");
    return jsonDecode(data.body);
  }
}
