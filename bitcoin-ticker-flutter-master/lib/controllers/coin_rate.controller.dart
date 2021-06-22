import 'package:dio/dio.dart';

//enum inputCoins { BTC, ETH, LTC }

class CoinRateController {
  static String baseUrl = 'https://rest.coinapi.io/v1/exchangerate';
  static String apiKey = '6ED6148B-ADAC-4254-A1C4-34D9E9F61C29';

  static Future<Response> getCoinRate(var inputCoin, var outputCoin) {
    String url = '$baseUrl/$inputCoin/$outputCoin?apiKey=$apiKey';
    print(url);
    return Dio().get(url);
  }
}
