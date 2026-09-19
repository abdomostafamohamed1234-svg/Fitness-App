import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_endpoints.dart';
import 'package:flowery/feature/profile/data/models/profile_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_client.g.dart';

@injectable
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  // TODO: ضيفي `profile` في AppEndPoints بنفس اسم الـ endpoint عندك في الـ backend
  // مثال: static const String profile = '/user/profile';
  @GET(AppEndPoints.profile)
  Future<ProfileResponseModel> getProfile();
}