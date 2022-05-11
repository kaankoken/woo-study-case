import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin_dto.freezed.dart';
part 'coin_dto.g.dart';

@freezed
class CoinDto with _$CoinDto {
  const factory CoinDto({
    required String base,
    required String quote,
    required String type,
    required double lastPrice,
    required double volume,
  }) = _CoinDto;

  factory CoinDto.fromJson(Map<String, dynamic> json) => _$CoinDtoFromJson(json);
}
