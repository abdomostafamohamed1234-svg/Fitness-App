import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../data/models/request/login_request_model.dart';
import '../data/models/response/login_response_model.dart';
part 'login_api_client.g.dart';

@injectable
@RestApi()
abstract class LoginApiClient {
  @factoryMethod
  factory LoginApiClient(Dio dio) = _LoginApiClient;

  @POST(AppEndPoints.signin)
  Future<LoginResponse> login(@Body() LoginRequestModel requests);
}