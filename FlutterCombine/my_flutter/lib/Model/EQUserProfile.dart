import 'dart:convert';

import 'package:statefull_widget/Model/EQWatchlistItem.dart';

class EquityUserProfile {
  final int userId;
  final String emailId;
  final String mobile;
  final String name;
  final int plId;
  final EquityUserPreferences preferences;
  final List<EquityInvestor> investors;

  EquityUserProfile({
    this.userId,
    this.emailId,
    this.mobile,
    this.name,
    this.plId,
    this.preferences,
    this.investors,
  });

  factory EquityUserProfile.fromJson(Map<String, dynamic> jsonMap) {
    return EquityUserProfile(
      userId: jsonMap['userId'] as int,
      emailId: jsonMap['emailId'] as String,
      name: jsonMap['name'] as String,
      plId: jsonMap['plId'] as int,
      investors: (jsonMap['equityInvestors'] as List)
          .map((val) => EquityInvestor.fromJson(val))
          .toList(),
      preferences: EquityUserPreferences.fromJson(jsonMap['preferences']),
    );
  }

  @override
  String toString() {
    return "$userId:$emailId:$name";
  }
}

class EquityUserPreferences {
  final int prepaidBrokerage;
  final int minimumPayIn;
  final int minimumPayOut;
  final String prepaidBrokerageFormatted;
  final String minimumPayOutFormatted;
  final String minimumPayInFormatted;

  EquityUserPreferences({
    this.prepaidBrokerage,
    this.minimumPayIn,
    this.minimumPayOut,
    this.prepaidBrokerageFormatted,
    this.minimumPayOutFormatted,
    this.minimumPayInFormatted,
  });

  factory EquityUserPreferences.fromJson(Map<String, dynamic> jsonMap) {
    return EquityUserPreferences(
      prepaidBrokerage: jsonMap['prepaidBrokerage'] as int,
      prepaidBrokerageFormatted: jsonMap['prepaidBrokerageFormatted'] as String,
      minimumPayIn: jsonMap['minimumPayIn'] as int,
      minimumPayInFormatted: jsonMap['minimumPayInFormatted'] as String,
      minimumPayOut: jsonMap['minimumPayOut'] as int,
      minimumPayOutFormatted: jsonMap['minimumPayOutFormatted'] as String,
    );
  }
}

class EquityInvestor {
  final String name;
  final int investorId;
  final String clientId;
  final String portfolioId;
  final String dpId;
  final String segment;
  final String product;
  final String exchange;
  final bool nri;
  final bool corporate;
  final String pan;
  final String emailId;
  final String mobile;
  final List<EquityBank> banks;

  EquityInvestor({
    this.name,
    this.investorId,
    this.clientId,
    this.portfolioId,
    this.dpId,
    this.segment,
    this.product,
    this.exchange,
    this.nri,
    this.corporate,
    this.pan,
    this.emailId,
    this.mobile,
    this.banks
  });

  
  
  factory EquityInvestor.fromJson(Map<String, dynamic> jsonMap) {
    return EquityInvestor(
      name: jsonMap['name'] as String,
      investorId: jsonMap['investorId'] as int,
      clientId: jsonMap['clientId'] as String,
      portfolioId: jsonMap['portfolioId'] as String,
      dpId: jsonMap['dpId'] as String,
      segment: jsonMap['segment'] as String,
      product: jsonMap['product'] as String,
      exchange: jsonMap['exchange'] as String,
      nri: jsonMap['nri'] as bool,
      corporate: jsonMap['corporate'] as bool,
      pan: jsonMap['pan'] as String,
      emailId: jsonMap['emailId'] as String,
      mobile: jsonMap['mobile'] as String,
      banks: (jsonMap['banks'] as List)
          .map((val) => EquityBank.fromJson(val))
          .toList()
    );
  }
}

class EquityBank {
  final String bankId;
  final String bankName;
  final String type;
  final String ifsc;
  final String accountNo;
  final bool activated;
  final String createdOn;
  final String activatedOn;

  EquityBank({
    this.bankName,this.bankId,this.activatedOn,this.accountNo,this.activated,this.createdOn,this.type,this.ifsc
  });

  factory EquityBank.fromJson(Map<String, dynamic> jsonMap) {
    return EquityBank(bankId: jsonMap['bankId'] as String
    ,bankName: jsonMap['bankName'] as String,
    type: jsonMap['type'] as String,
    ifsc: jsonMap['ifsc'] as String, 
    accountNo: jsonMap['accountNo'] as String,
    activated: jsonMap['activated'] as bool, 
    createdOn: jsonMap['createdOn'] as String, 
    activatedOn: jsonMap['activatedOn'] as String);
  }

}

