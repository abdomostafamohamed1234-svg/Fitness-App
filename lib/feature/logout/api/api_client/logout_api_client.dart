import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'logout_api_client.g.dart';

@injectable
@RestApi()
abstract class LogoutApiClient {
  @factoryMethod
  factory LogoutApiClient(Dio dio) = _LogoutApiClient;

  @GET(AppEndPoints.logout)
  Future<HttpResponse<dynamic>> logout();
}