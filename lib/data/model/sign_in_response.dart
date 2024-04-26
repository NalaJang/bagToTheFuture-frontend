import 'package:json_annotation/json_annotation.dart';

import 'token_data_model.dart';

part 'sign_in_response.g.dart';

@JsonSerializable()
class SignInResponse {
  final int code;
  final String message;
  final TokenDataModel data;

  SignInResponse({required this.code, required this.message, required this.data});

  factory SignInResponse.fromJson(Map<String, dynamic> json) => _$SignInResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}