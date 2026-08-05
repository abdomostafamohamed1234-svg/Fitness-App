
import 'package:flowery/features/home/domian/entities/recommendation_model.dart';
import 'package:flowery/features/home/domian/entities/work_out_model.dart';
import 'package:flowery/features/home/domian/repository/home_repository_contract.dart';
import 'package:flowery/core/base/base_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepositoryContract)
class HomeRepositoryImpl implements HomeRepositoryContract {
  HomeRepositoryImpl(HomeRemoteDataSourceContract homeRemoteDataSource)
      : _homeRemoteDataSource = homeRemoteDataSource;

  final HomeRemoteDataSourceContract _homeRemoteDataSource;

  @override
  Future<Result<FoodForYouModel>> getFoodData() async {
    final response = await _homeRemoteDataSource.getFoodData();
    return switch (response) {
      Success(:final data) => Success(data: data?.toEntity()),
      Error(:final exception) => Error(exception: exception),
    };
  }

  @override
  Future<Result<WorkOutModel>> getWorkOutData() async {
    final response = await _homeRemoteDataSource.getWorkOutData();
    return switch (response) {
      Success(:final data) => Success(data: data?.toEntity()),
      Error(:final exception) => Error(exception: exception),
    };
  }

  @override
  Future<Result<RecommendationModel>> getRecommendationData() async {
    final response = await _homeRemoteDataSource.getRecommendationData();
    return switch (response) {
      Success(:final data) => Success(data: data?.toEntity()),
      Error(:final exception) => Error(exception: exception),
    };
  }

  @override
  Future<Result<ProfileModel>> getProfileData() async {
    final response = await _homeRemoteDataSource.getProfileData();
    return switch (response) {
      Success(:final data) => Success(data: data?.toEntity()),
      Error(:final exception) => Error(exception: exception),
    };
  }
}