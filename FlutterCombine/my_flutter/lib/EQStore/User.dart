import 'package:shared_preferences/shared_preferences.dart';

class User {

  User.privateConsructor();
  static final User instance = User.privateConsructor();  
  
  String clientId ;
  String accessToken;

// get access token
  getaccessToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      this.accessToken = prefs.getString("accessToken");
      return this.accessToken;
    }catch (error) {
      return '';
    }
  }

// set access token
  setaccessToken(String accessToken) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();  
      prefs.setString("accessToken", accessToken);
      this.accessToken = accessToken;
    } catch (error){
        print(error);
    }
  }

  // get clinet id
  getclientId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();  
      this.clientId = prefs.getString("clienId");
      return this.clientId;

    } catch(error) {
      return '';
    }
  }

  // set client Id
  setClientId(String cilentId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("clienId", clientId);
      this.clientId = clientId;
    } catch (error) {
        print(error);
    }
  }

}