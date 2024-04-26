import 'package:dio/dio.dart' hide Headers;
import 'package:rest_api_ex/data/model/get_response.dart';
import 'package:rest_api_ex/data/model/sign_in_response.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

// iOS ip
// @RestApi(baseUrl: 'http://127.0.0.1:8080/v1')
// Android ip
String baseUrl = 'http://10.0.2.2:8080/v1';
const String emailAuthUrl = 'http://10.0.2.2:8084/v1';

@RestApi(baseUrl: emailAuthUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/member/register')
  Future<void> createUser(@Body() Map<String, dynamic> body);

  @POST('/member/login/oauth')
  Future<void> oauthLogin(@Body() Map<String, dynamic> body);

  @POST('/member/login')
  @Headers({
    'Content-Type': 'application/json',
    'accessToken': 'true', // accessToken 요청 헤더 추가
  })
  Future<SignInResponse> emailLogin(
    @Field('email') String email,
    @Field('password') String password,
  );

  @POST('/certificate/email')
  Future<GetResponse> emailAuth(
    @Field('email') String email,
  );

  @GET('/certificate/email')
  Future<GetResponse> emailAuthStatus(
    @Query('email') String email,
    @Query('certificationNumber') String certificationNumber,
  );
}
