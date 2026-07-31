import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_endpoints.dart';
import 'package:flowery/features/forget_password/data/models/requestes/forget_password_request.dart';
import 'package:flowery/features/forget_password/data/models/requestes/reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/requestes/verify_reset_password_request.dart';
import 'package:flowery/features/forget_password/data/models/responses/forget_password_response.dart';
import 'package:flowery/features/forget_password/data/models/responses/reset_password_response.dart';
import 'package:flowery/features/forget_password/data/models/responses/verify_email_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'forget_password_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ForgetPasswordApiClient {
  @factoryMethod
  factory ForgetPasswordApiClient(Dio dio) = _ForgetPasswordApiClient;

   @POST(AppEndPoints.forgotPassword)
  Future<ForgetPasswordResponse> forgetPassword(
    @Body() ForgetPasswordRequest request,
  );
 @POST(AppEndPoints.verifyResetCode)
  Future<VerifyEmailResponse> verifyEmail(@Body() VerifyResetPasswordRequest request);

   @PUT(AppEndPoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword(@Body() ResetPasswordRequest request);
}
