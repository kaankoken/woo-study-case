import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:woo_study_case/domain/home/table_view_model.dart';
import 'package:woo_study_case/domain/models/coin.dart';
import 'package:woo_study_case/infra/dto/coin_dto.dart';

final _formatter = NumberFormat('#,##.000');
final _volumeFormatter = NumberFormat.compact();

extension CoinDataExtension on String {
  Future<List<CoinDto>> readJsonData(TabFilter filter) async {
    //read json file
    final jsondata = await rootBundle.loadString(this);
    //decode json data as list
    final list = (json.decode(jsondata) as Map<String, dynamic>)['data'] as List<dynamic>;

    //map json and initialize using DataModel
    switch (filter) {
      case TabFilter.ALL:
        return list.map((e) => CoinDto.fromJson(e)).toList();
      case TabFilter.SPOT:
        return list.where((e) => e['type'] == 'SPOT').map((e) => CoinDto.fromJson(e)).toList();
      case TabFilter.FUTURES:
        return list.where((e) => e['type'] == 'FUTURES').map((e) => CoinDto.fromJson(e)).toList();
      default:
        return list.map((e) => CoinDto.fromJson(e)).toList();
    }
  }
}

extension PriceExtension on double {
  String get priceDisplay => _formatter.format(this).toString();
}

extension VolumeExtension on double {
  String get volumeDisplay => _volumeFormatter.format(this).toString();
}

extension CoinDataConversionExtension on List<CoinDto> {
  List<Coin> toCoinList() {
    return map(
      (e) => Coin(
        base: e.base,
        quote: e.quote,
        type: e.type,
        lastPrice: e.lastPrice,
        volume: e.volume,
        symbol: e.type == 'SPOT' ? '${e.base}/${e.quote}' : '${e.base}-PERP',
        lastPriceDisplay: e.lastPrice.priceDisplay,
        volumeDisplay: '\$' + e.volume.volumeDisplay,
      ),
    ).toList();
  }
}
