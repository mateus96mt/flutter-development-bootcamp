import 'dart:io';

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/services/coin_rate.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const int ratePrecision = 3;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  double bTCRate, eTHRate, lTCRate;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.getCoinRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          coinRates(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: currencySelector(isAndroid: Platform.isAndroid),
          ),
        ],
      ),
    );
  }

  Widget currencySelector({bool isAndroid = true}) {
    return isAndroid
        ? DropdownButton<String>(
            items: dropdownMenuItems(),
            onChanged: (value) {
              setState(
                () {
                  this.selectedCurrency = value ?? '';
                  getCoinRates();
                },
              );
            },
            value: selectedCurrency,
          )
        : CupertinoPicker(
            backgroundColor: Colors.lightBlue,
            itemExtent: 32.0,
            onSelectedItemChanged: (selectedIndex) {
              setState(
                () {
                  this.selectedCurrency = currenciesList[selectedIndex] ?? '';
                  getCoinRates();
                },
              );
            },
            children: cupertinoSelectorItems(),
          );
  }

  List<DropdownMenuItem<String>> dropdownMenuItems() {
    List<DropdownMenuItem<String>> list = [];
    for (String currency in currenciesList) {
      list.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return list;
  }

  List<Widget> cupertinoSelectorItems() {
    List<Widget> list = [];
    for (String currency in currenciesList) {
      list.add(
        Text(currency),
      );
    }
    return list;
  }

  Widget coinRateCard({@required double rate, @required String label}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $label = ${rate.toStringAsFixed(ratePrecision)} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget coinRates() {
    return isLoading
        ? Expanded(
            child: SpinKitCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(color: Colors.lightBlue),
                );
              },
            ),
          )
        : Column(
            children: [
              coinRateCard(
                rate: bTCRate,
                label: 'BTC',
              ),
              coinRateCard(
                rate: eTHRate,
                label: 'ETH',
              ),
              coinRateCard(
                rate: lTCRate,
                label: 'LTC',
              ),
            ],
          );
  }

  void getCoinRates() {
    setState(() {
      this.isLoading = true;
    });

    CoinRateService.getCoinRate(
            inputCoin: 'BTC', outputCoin: this.selectedCurrency)
        .then(
      (_bTCCoinRate) {
        CoinRateService.getCoinRate(
                inputCoin: 'ETH', outputCoin: this.selectedCurrency)
            .then(
          (_eTHCoinRate) {
            CoinRateService.getCoinRate(
                    inputCoin: 'LTC', outputCoin: this.selectedCurrency)
                .then(
              (_lTCCoinRate) {
                setState(() {
                  this.bTCRate = _bTCCoinRate.rate;
                  this.eTHRate = _eTHCoinRate.rate;
                  this.lTCRate = _lTCCoinRate.rate;
                  this.isLoading = false;
                });
              },
            );
          },
        );
      },
    );
  }
}
