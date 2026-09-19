import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_endpoints.dart';
import 'package:flowery/features/change_password/data/models/requestes/change_password_request.dart';
import 'package:flowery/features/change_password/data/models/responses/change_password_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'change_password_api_client.g.dart';

@LazySingleton()
@RestApi()
abstract class ChangePasswordApiClient {
  @factoryMethod
  factory ChangePasswordApiClient(Dio dio) = _ChangePasswordApiClient;

  @PATCH(AppEndPoints.changePassword)
  Future<ChangePasswordResponse> changePassword({
    @Body() required ChangePasswordRequest request,
  });
}
