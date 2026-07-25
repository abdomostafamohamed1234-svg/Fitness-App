
// import 'package:flowery/features/home/domian/entities/food_for_you_model.dart';
// import 'package:flowery/features/home/domian/entities/recommendation_model.dart';
// import 'package:flowery/features/home/domian/entities/work_out_model.dart';

// abstract class HomeRepositoryContract {

//   Future<BaseResponse<RecommendationModel>> getRecommendationData();
//   Future<BaseResponse<FoodForYouModel>> getFoodData();
//   Future<BaseResponse<WorkOutModel>> getWorkOutData();
// }



import 'package:flowery/features/home/domian/entities/food_for_you_model.dart';
import 'package:flowery/features/home/domian/entities/recommendation_model.dart';
import 'package:flowery/features/home/domian/entities/work_out_model.dart';
import 'package:flowery/core/base/base_response.dart';

abstract class HomeRepositoryContract {
  Future<Result<RecommendationModel>> getRecommendationData();
  Future<Result<FoodForYouModel>> getFoodData();
  Future<Result<WorkOutModel>> getWorkOutData();
}