class CoinRate {
  double rate;

  CoinRate.fromJson(Map<String, dynamic> json) {
    this.rate = double.tryParse(json['rate'].toString()) ?? 0.0;
  }
}
