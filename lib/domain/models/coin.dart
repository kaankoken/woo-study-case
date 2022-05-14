import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin.freezed.dart';
part 'coin.g.dart';

@freezed
class Coin with _$Coin {
  const factory Coin({
    required String base,
    required String quote,
    required String type,
    required double lastPrice,
    required double volume,
    required String symbol,
    required String lastPriceDisplay,
    required String volumeDisplay,
    required int priority,
  }) = _Coin;

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);
}
