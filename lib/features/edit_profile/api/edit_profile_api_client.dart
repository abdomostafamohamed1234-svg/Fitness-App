import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery/config/api/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../data/models/request/edit_profile_request_model.dart';
import '../data/models/response/profile_response_model.dart';

part 'edit_profile_api_client.g.dart';

@injectable
@RestApi()
abstract class EditProfileApiClient {
  @factoryMethod
  factory EditProfileApiClient(Dio dio) = _EditProfileApiClient;

  @GET(AppEndPoints.profileData)
  Future<ProfileResponseModel> getProfile();

  @PUT(AppEndPoints.editProfile)
  Future<ProfileResponseModel> editProfile(@Body() EditProfileRequestModel request);

  @PUT(AppEndPoints.uploadPhoto)
  @MultiPart()
  Future<ProfileResponseModel> uploadPhoto(@Part(name: 'photo') File photo);
}
