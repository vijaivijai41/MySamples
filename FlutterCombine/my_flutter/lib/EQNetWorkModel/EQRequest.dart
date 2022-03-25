

import 'package:statefull_widget/EQNetWorkModel/EQNetworkLayer.dart';
import 'package:statefull_widget/EQStore/User.dart';



const equityBaseUrl = 'https://api.fundsindia.com/equity/';

enum FINetworkResourceType { 
  login,
  userProfile 
}

class EQRequest extends FINetworkResource {

 static _headers() => {
        'content-type': 'application/json',
        'x-api-version': '1.0.0',
        "Accept": "application/json",
        'x-fi-access-token': User.instance.accessToken
  };

  static final String basePath = "equity";
  static final String host = "api.fundsindia.com";

  static final String sceme = 'https';
  static final int port = 443;

  static EQRequest getResource(FINetworkResourceType type, dynamic params) {
    var request = EQRequest();
    switch (type) {
      case FINetworkResourceType.login:
        request.methodName = 'auth/login';
        request.method = HttpMethod.POST;
        request.headers =  _headers(); 
        request.contentEncoding = ContentEncoding.json;
        request.baseUrlPath = '$equityBaseUrl${request.methodName}';

        break;
      case FINetworkResourceType.userProfile:
        request.methodName = 'user-profile';
        request.method = HttpMethod.GET;
        request.headers =  _headers();
        request.contentEncoding = ContentEncoding.json;
        request.baseUrlPath = '$equityBaseUrl${request.methodName}';

        break;
    }
    if (params != null) {
          request.params = params;
    }
    
    return request;
  }

  // query params url append
  String get queryParameters {
    if (method == HttpMethod.GET && params != null) {
      final jsonString = Uri(queryParameters: params);
      return '?${jsonString.query}';
    }
    return '';
  }
}
