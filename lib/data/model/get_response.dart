import 'package:json_annotation/json_annotation.dart';

part 'get_response.g.dart';

@JsonSerializable()
class GetResponse {
  final Map<String, dynamic> data;

  const GetResponse({
    required this.data,
  });

  factory GetResponse.fromJson(Map<String, dynamic> json) => _$GetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetResponseToJson(this);
}