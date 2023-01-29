import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:sigv4/sigv4.dart';

class RequestImageProcess {
  final client = Sigv4Client(
    keyId: DotEnv().env['keyId_ri'],
    accessKey: DotEnv().env['accessKey_ri'],
    region: DotEnv().env['region_ri'],
    serviceName: DotEnv().env['serviceName_ri'],
  );

  final awspath = DotEnv().env['aws_s3_url_ri'] +
      '/' +
      DotEnv().env['aws_s3_api_stage_ri'] +
      '/' +
      DotEnv().env['aws_s3_bucket_name_ri'] +
      '/';

  dynamic getImage(String filename) async {
    // Some fictive endpoint  ;
    final path = awspath + filename;
    print("AWS request path : " + path);
    // Create the request
    var request = client.request(path);

    // GET request
    Response res = await get(request.url, headers: request.headers);
    print("Response Code : ${res.statusCode}");
    //print(res.body);
    return res.body;
  }

  dynamic putImage(File image, String filename) async {
    String extension = image.path.split('.').last;
    print("putImage : Image Name :" + filename + "." + extension);
    final path = awspath + filename + "." + extension;

    try {
      var request = client.request(path, method: 'PUT');

      var res = await put(
        request.url,
        headers: request.headers,
        body: base64.encode(image.readAsBytesSync()),
      );
      print("putImage : Response Status : ${res.statusCode}");
      print(res.body);
      return res.statusCode;
    } catch (e) {
      print(e);
    }
  }
}
