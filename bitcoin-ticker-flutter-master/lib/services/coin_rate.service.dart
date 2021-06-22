import 'package:bitcoin_ticker/controllers/coin_rate.controller.dart';
import 'package:bitcoin_ticker/models/coin_rate.model.dart';
import 'package:flutter/cupertino.dart';

class CoinRateService {
  static Future<CoinRate> getCoinRate(
      {@required String inputCoin, @required String outputCoin}) async {
    CoinRate coinRate;
    await CoinRateController.getCoinRate(inputCoin, outputCoin).then(
      (response) {
        coinRate = CoinRate.fromJson(response.data);
      },
    );
    return coinRate;
  }
}
