import 'package:dio/dio.dart';
import 'package:flowery/config/routing/app_routes.dart';
import 'package:flowery/feature/profile/data/models/profile_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_client.g.dart';

@injectable
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @GET(AppRoutes.profile)
  Future<ProfileResponseModel> getProfile();
}