import 'package:json_annotation/json_annotation.dart';

part 'email_auth_response.g.dart';

@JsonSerializable()
class EmailAuthResponse {
  final Map<String, dynamic> data;

  const EmailAuthResponse({
    required this.data,
  });

  factory EmailAuthResponse.fromJson(Map<String, dynamic> json) => _$EmailAuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmailAuthResponseToJson(this);
}