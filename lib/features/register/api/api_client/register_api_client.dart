import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_endpoints.dart';
import 'package:flowery/features/register/data/models/register_dto_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'register_api_client.g.dart';

@injectable
@RestApi()
abstract class RegisterApiClient {
  @factoryMethod
  factory RegisterApiClient(Dio dio) = _RegisterApiClient;

  @POST(AppEndPoints.signup)
  Future<RegisterDto> register(@Body() Map<String, dynamic> body);
}