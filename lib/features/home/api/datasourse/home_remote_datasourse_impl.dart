// import 'package:flowery/features/home/api/api_client/home_api_client.dart';
// import 'package:flowery/features/home/data/datasourse/home_remote_datasourse_impl.dart';
// import 'package:flowery/features/home/data/models/food_for_you_response_dto.dart';
// import 'package:flowery/features/home/data/models/recommendation_to_day_response_dto.dart';
// import 'package:flowery/features/home/data/models/work_out_response_dto.dart';
// import 'package:injectable/injectable.dart';

// @Injectable(as: HomeRemoteDataSourceContract)
// class HomeRemoteDataSourceImpl implements HomeRemoteDataSourceContract {
//   HomeRemoteDataSourceImpl(HomeApiClient homeApiClient)
//       : _homeApiClient = homeApiClient;

//   final HomeApiClient _homeApiClient;

//   @override
//   Future<BaseResponse<FoodForYouResponseDto>> getFoodData() async {
//     try {
//       final FoodForYouResponseDto response =
//           await _homeApiClient.getFoodData();
//       return SuccessResponse<FoodForYouResponseDto>(data: response);
//     } on Exception catch (e) {
//       return ErrorResponse<FoodForYouResponseDto>(error: e);
//     }
//   }

//   @override
//   Future<BaseResponse<WorkOutResponseDto>> getWorkOutData() async {
//     try {
//       final WorkOutResponseDto response =
//           await _homeApiClient.getWorkOutData();
//       return SuccessResponse<WorkOutResponseDto>(data: response);
//     } on Exception catch (e) {
//       return ErrorResponse<WorkOutResponseDto>(error: e);
//     }
//   }

//   @override
//   Future<BaseResponse<RecommendationToDayResponseDto>>
//       getRecommendationData() async {
//     try {
//       final RecommendationToDayResponseDto response =
//           await _homeApiClient.getRecommendationData();
//       return SuccessResponse<RecommendationToDayResponseDto>(data: response);
//     } on Exception catch (e) {
//       return ErrorResponse<RecommendationToDayResponseDto>(error: e);
//     }
//   }
// }












import 'package:flowery/features/home/api/api_client/home_api_client.dart';
import 'package:flowery/features/home/data/datasourse/home_remote_datasourse_impl.dart';
import 'package:flowery/features/home/data/models/food_for_you_response_dto.dart';
import 'package:flowery/features/home/data/models/recommendation_to_day_response_dto.dart';
import 'package:flowery/features/home/data/models/work_out_response_dto.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSourceContract)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSourceContract {
  HomeRemoteDataSourceImpl(HomeApiClient homeApiClient)
      : _homeApiClient = homeApiClient;

  final HomeApiClient _homeApiClient;

  @override
  Future<Result<FoodForYouResponseDto>> getFoodData() async {
    try {
      final FoodForYouResponseDto response =
          await _homeApiClient.getFoodData();
      return Success<FoodForYouResponseDto>(data: response);
    } on Exception catch (e) {
      return Error<FoodForYouResponseDto>(exception: e);
    }
  }

  @override
  Future<Result<WorkOutResponseDto>> getWorkOutData() async {
    try {
      final WorkOutResponseDto response =
          await _homeApiClient.getWorkOutData();
      return Success<WorkOutResponseDto>(data: response);
    } on Exception catch (e) {
      return Error<WorkOutResponseDto>(exception: e);
    }
  }

  @override
  Future<Result<RecommendationToDayResponseDto>>
      getRecommendationData() async {
    try {
      final RecommendationToDayResponseDto response =
          await _homeApiClient.getRecommendationData();
      return Success<RecommendationToDayResponseDto>(data: response);
    } on Exception catch (e) {
      return Error<RecommendationToDayResponseDto>(exception: e);
    }
  }
}