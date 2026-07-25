import 'package:dio/dio.dart';

import 'package:flowery/config/api/api_endpoints.dart';
import 'package:flowery/features/home/data/models/food_for_you_response_dto.dart';
import 'package:flowery/features/home/data/models/recommendation_to_day_response_dto.dart';
import 'package:flowery/features/home/data/models/work_out_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_client.g.dart';

@injectable
@RestApi()
abstract class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio) = _HomeApiClient;

  @GET(AppEndPoints.recommendationToDay)
   Future<RecommendationToDayResponseDto> getRecommendationData();

  @GET(AppEndPoints.upcomingWorkOut)
   Future<WorkOutResponseDto> getWorkOutData();

  @GET(AppEndPoints.foodForYou)
   Future<FoodForYouResponseDto> getFoodData();
}