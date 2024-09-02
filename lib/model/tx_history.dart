// To parse this JSON data, do
//
//     final txHistory = txHistoryFromJson(jsonString);

import 'dart:convert';

TxHistory txHistoryFromJson(String str) => TxHistory.fromJson(json.decode(str));

String txHistoryToJson(TxHistory data) => json.encode(data.toJson());

class TxHistory {
  TxResult? result;

  TxHistory({
    this.result,
  });

  factory TxHistory.fromJson(Map<String, dynamic> json) => TxHistory(
        result: json["result"] == null ? null : TxResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
      };
}

class TxResult {
  String? tokenName;
  String? tokenSymbol;
  String? tokenLogo;
  String? tokenDecimals;
  String? transactionHash;
  String? address;
  DateTime? blockTimestamp;
  String? blockNumber;
  String? blockHash;
  String? toAddress;
  String? value;

  TxResult({
    this.tokenName,
    this.tokenSymbol,
    this.tokenLogo,
    this.tokenDecimals,
    this.transactionHash,
    this.address,
    this.blockTimestamp,
    this.blockNumber,
    this.blockHash,
    this.toAddress,
    this.value,
  });

  factory TxResult.fromJson(Map<String, dynamic> json) => TxResult(
        tokenName: json["token_name"],
        tokenSymbol: json["token_symbol"],
        tokenLogo: json["token_logo"],
        tokenDecimals: json["token_decimals"],
        transactionHash: json["transaction_hash"],
        address: json["address"],
        blockTimestamp: json["block_timestamp"] == null
            ? null
            : DateTime.parse(json["block_timestamp"]),
        blockNumber: json["block_number"],
        blockHash: json["block_hash"],
        toAddress: json["to_address"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "token_name": tokenName,
        "token_symbol": tokenSymbol,
        "token_logo": tokenLogo,
        "token_decimals": tokenDecimals,
        "transaction_hash": transactionHash,
        "address": address,
        "block_timestamp": blockTimestamp?.toIso8601String(),
        "block_number": blockNumber,
        "block_hash": blockHash,
        "to_address": toAddress,
        "value": value,
      };
}
