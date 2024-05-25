class coinCapModel {
  coinCapModel({
    required this.name,
    required this.symbol,
    required this.rank,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
  });
  final String name;
  final String symbol;
  final num rank;
  final String imageUrl;
  final num price;
  final num change;
  final num changePercentage;

  factory coinCapModel.fromJson(Map<String, dynamic> json) {
    return coinCapModel(
      name: json['name'],
      symbol: json['symbol'],
      rank: json['market_cap_rank'],
      imageUrl: json['image'],
      price: json['current_price'],
      change: json['price_change_24h'],
      changePercentage: json['price_change_percentage_24h'],
    );
  }
  // List<mycoinapi> myarray = [];
}
