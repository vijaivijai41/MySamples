
class EQWatchlistItem {
  String symbol;
  String scripCode;
  EQExchange exchange;
  EQSegment segment;
  int lotSize;
  double lastTradedPrice;
  double prevClosePrice;
  String prevClosePriceFormatted;
  int change;
  int changePercentage;


  EQWatchlistItem(
  this.symbol,
  this.scripCode,
  this.exchange,
  this.segment,
  this.change,
  this.changePercentage,
  this.lotSize,
  this.lastTradedPrice,
  this.prevClosePrice,
  this.prevClosePriceFormatted
  );

  factory EQWatchlistItem.fromJson(dynamic json) {
    return  EQWatchlistItem(
      json['symbol'] as String, 
      json['scripCode'] as String,
      EQExchangeExtension._value(json['exchange'] as String),
      EQSegmentExtension._value(json['segment'] as String),
      json['change'] as int,
      json['changePercentage'] as int, 
      json['lotSize'] as int, 
      json['lastTradedPrice'] as double, 
      json['prevClosePrice'] as double,
      json['prevClosePriceFormatted'] as String, );
  }

  @override
  String toString() {
    return '{this.symbol,this.scripCode,this.exchange.name}';
  }
}


enum EQExchange { 
  NSE, 
  BSE, 
  NFO
}

extension EQExchangeExtension on EQExchange {
  // parse value
  static EQExchange _value(String val) {
    switch (val) {
      case 'NSE':
        return EQExchange.NSE;
      case 'BSE':
        return EQExchange.BSE;
      case 'NFO':
        return EQExchange.NFO;
      }
    }
EQExchange get value => _value(this.toString());

  // display value
  String get name {
    switch (this) {
      case EQExchange.NSE:
        return "NSE";
      case EQExchange.BSE:
        return "BSE";
      case EQExchange.NFO:
        return "NFO";
    }
  }
}


 
enum EQSegment { CASH, FNO }

extension EQSegmentExtension on EQSegment {
  // parse value
  static EQSegment _value(String val) {
    switch (val) {
      case 'CASH':
        return EQSegment.CASH;
      case 'FNO':
        return EQSegment.FNO;
    }
  }

  EQSegment get value => _value(this.toString());

  // display value
  String get name {
    switch (this) {
      case EQSegment.CASH:
        return "CASH";
      case EQSegment.FNO:
        return "FNO";
    }
  }
}

