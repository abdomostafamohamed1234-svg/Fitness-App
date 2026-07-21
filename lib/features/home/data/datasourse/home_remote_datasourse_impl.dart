// import 'package:flowery/features/home/data/models/food_for_you_response_dto.dart';
// import 'package:flowery/features/home/data/models/recommendation_to_day_response_dto.dart';
// import 'package:flowery/features/home/data/models/work_out_response_dto.dart';


// abstract class HomeRemoteDataSourceContract {
//   Future<BaseResponse<FoodForYouResponseDto>> getFoodData();
//   Future<BaseResponse<WorkOutResponseDto>> getWorkOutData();
//   Future<BaseResponse<RecommendationToDayResponseDto>> getRecommendationData();
// }




import 'package:flowery/features/home/data/models/food_for_you_response_dto.dart';
import 'package:flowery/features/home/data/models/recommendation_to_day_response_dto.dart';
import 'package:flowery/features/home/data/models/work_out_response_dto.dart';
import 'package:flowery/core/base/base_response.dart';

abstract class HomeRemoteDataSourceContract {
  Future<Result<FoodForYouResponseDto>> getFoodData();
  Future<Result<WorkOutResponseDto>> getWorkOutData();
  Future<Result<RecommendationToDayResponseDto>> getRecommendationData();
}