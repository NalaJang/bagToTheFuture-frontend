import 'package:json_annotation/json_annotation.dart';

part 'token_data_model.g.dart';

@JsonSerializable()
class TokenDataModel {
  final String accessToken;
  final String refreshToken;

  TokenDataModel({required this.accessToken, required this.refreshToken});

  factory TokenDataModel.fromJson(Map<String, dynamic> json) => _$TokenDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$TokenDataModelToJson(this);
}