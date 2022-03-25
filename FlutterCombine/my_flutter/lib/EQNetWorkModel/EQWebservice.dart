import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:statefull_widget/EQNetWorkModel/EQNetworkLayer.dart';
import 'package:statefull_widget/EQStore/User.dart';
import 'package:statefull_widget/Model/EQLogin.dart';

class EQWebservice {
  final http.Client client;

  EQWebservice(this.client);

  Future<EQBaseResponse> apiCall(FINetworkResource request) async {
    final httpRequest = APIRequest(request);
    print(request.baseUrlPath);
    final response = await client.send(httpRequest);
    final bodyData = await response.stream.transform(utf8.decoder).join();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final Map<String, dynamic> jsonMap = json.decode(bodyData);

      if (jsonMap.isNotEmpty) {
        if (jsonMap.containsKey('accessToken')) {
          var model = EQLogin.fromJson(jsonMap);
          print(model.accessToken);
          User.instance.accessToken = model.accessToken;
          return model;
        } else if (jsonMap.containsKey('data')) {
          var model = EQBaseResponseModel(jsonMap);
          return model;
        } else {
          // some other type
        }
      }
    } else if (response.statusCode == 403) {
      return returnError(bodyData);
    } else if (response.statusCode >= 500 && response.statusCode <= 599) {
      return returnError(bodyData);
    }
  }

  EQBaseResponse returnError(String data) {
    final Map<String, dynamic> jsonMap = json.decode(data);
    if (jsonMap.isNotEmpty) {
      var model = EQError(jsonMap);
      return model;
    }
  }
}

class EQBaseError {
  int code;
  String desc;

  EQBaseError({this.code, this.desc});

  factory EQBaseError.fromJson(dynamic jsonFrom) {
    return EQBaseError(
        code: jsonFrom['code'] as int, desc: jsonFrom['desc'] as String);
  }
}

