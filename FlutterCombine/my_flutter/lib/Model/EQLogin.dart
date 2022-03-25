
import 'package:statefull_widget/Model/EQUserProfile.dart';


//EQLogin
class EQLogin implements EQBaseResponse  {
  String accessToken;
  String refreshToken;

  EQLogin({this.accessToken, this.refreshToken});

  factory EQLogin.fromJson(Map<String, dynamic> json) {
    return EQLogin(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String);
  }

  @override
  String toString() {
    return '{accessToken:$accessToken,refreshToken:$refreshToken}';
  }
}

//EQError
class EQError implements EQBaseResponse {
  int code;
  String desc;
  String error;

  EQError(dynamic json) {
    code = json['code'] as int;
    desc = json['desc'] as String;
    error = json ['error'] as String;
  }
}

// EQBaseResponse
abstract class EQBaseResponse {}

//EQBaseResponseModel
class EQBaseResponseModel<T> implements EQBaseResponse {
  int code;
  String desc;
  List<EQError> errors;
  bool success;
  String type;
  String name;
  T data;
    EQBaseResponseModel(Map<String, dynamic> json) {
        code = json['code'] as int;
        desc = json['desc'] as String;
        
        errors = (json['errors'] as List).map((val) =>  EQError(val)).toList();
        success = json['success'] as bool;
        name = json['name'];
        switch (name) {
          case 'User':
            data = EquityUserProfile.fromJson(json['data']) as T;
            break;
          default:
          data =  json['data'] as T;
        }
   }
}

