

import 'package:statefull_widget/Model/EQWatchlistItem.dart';

class EquityOrderTradeBook {
  final String orderId;
  final String clientId;
  final String symbol;
  final String scripCode;
  final String orderType;
  final String transactionType;
  final String product;
  final String exchange;
  final String segment;
  final String status;
  final String validity;
  final int quantity;
  final String quantityFormatted;
  final int disclosedQuantity;
  final double price;
  final String priceFormatted;
  final double limitPrice;
  final String limitPriceFormatted;
  final double triggerPrice;
  final String triggerPriceFormatted;
  final double stopLossPrice;
  final String stopLossPriceFormatted;
  final int portfolioId;
  final String companyName;
  final String exchangeOrderNo;
  final String exchangeTimeStamp;
  final String filledQuantityFormatted;
  final int filledQuantity;
  final String unfilledQuantityFormatted;
  final int unfilledQuantity;
  final String exchangeTradeNo;
  final String rejectedReason;
  final int lotSize;

  EquityOrderTradeBook({
    this.orderId,
    this.clientId,
    this.symbol,
    this.scripCode,
    this.orderType,
    this.transactionType,
    this.product,
    this.exchange,
    this.segment,
    this.status,
    this.validity,
    this.quantity,
    this.quantityFormatted,
    this.disclosedQuantity,
    this.price,
    this.priceFormatted,
    this.limitPrice,
    this.limitPriceFormatted,
    this.triggerPrice,
    this.triggerPriceFormatted,
    this.stopLossPrice,
    this.stopLossPriceFormatted,
    this.portfolioId,
    this.companyName,
    this.exchangeOrderNo,
    this.exchangeTimeStamp,
    this.filledQuantityFormatted,
    this.filledQuantity,
    this.unfilledQuantityFormatted,
    this.unfilledQuantity,
    this.exchangeTradeNo,
    this.rejectedReason,
    this.lotSize,
  });

  factory EquityOrderTradeBook.fromJson(Map<String, dynamic> jsonMap) {
    return EquityOrderTradeBook(
      orderId: jsonMap['orderId'] as String,
      clientId: jsonMap['clientId'] as String,
      symbol: jsonMap['symbol'] as String,
      scripCode: jsonMap['scripCode'] as String,
      orderType: jsonMap['orderType'] as String,
      transactionType: jsonMap['transactionType'] as String,
      product: jsonMap['product'] as String,
      exchange: jsonMap['exchange'] as String,
      segment: jsonMap['exchange'] as String,
      status: jsonMap['status'] as String,
      validity: jsonMap['validity'] as String,
      quantity: jsonMap['quantity'] as int,
      quantityFormatted: jsonMap['quantityFormatted'] as String,
      disclosedQuantity: jsonMap['disclosedQuantity'] as int,
      price: jsonMap['price'] as double,
      priceFormatted: jsonMap['priceFormatted'] as String,
      limitPrice: jsonMap['limitPrice'] as double,
      limitPriceFormatted: jsonMap['limitPriceFormatted'] as String,
      triggerPrice: jsonMap['triggerPrice'] as double,
      triggerPriceFormatted: jsonMap['triggerPriceFormatted'] as String,
      stopLossPrice: jsonMap['stopLossPrice'] as double,
      stopLossPriceFormatted: jsonMap['stopLossPriceFormatted'] as String,
      portfolioId: jsonMap['portfolioId'] as int,
      companyName: jsonMap['companyName'] as String,
      exchangeOrderNo: jsonMap['exchangeOrderNo'] as String,
      exchangeTimeStamp: jsonMap['exchangeTimeStamp'] as String,
      filledQuantityFormatted: jsonMap['filledQuantityFormatted'] as String,
      filledQuantity: jsonMap['filledQuantity'] as int,
      unfilledQuantityFormatted: jsonMap['unfilledQuantityFormatted'] as String,
      unfilledQuantity: jsonMap['unfilledQuantity'] as int,
      exchangeTradeNo: jsonMap['exchangeTradeNo'] as String,
      rejectedReason: jsonMap['rejectedReason'] as String,
      lotSize: jsonMap['lotSize'] as int,
    );
  }

  static List<EquityOrderTradeBook> getOrderBook(
      List<Map<String, dynamic>> listJsonMap) {
    return listJsonMap
        .map((jsonMap) => EquityOrderTradeBook.fromJson(jsonMap))
        .toList();
  }
}
