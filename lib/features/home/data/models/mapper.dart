// food_for_you_mapper.dart

import 'package:flowery/features/home/data/models/food_for_you_response_dto.dart';
import 'package:flowery/features/home/data/models/recommendation_to_day_response_dto.dart';
import 'package:flowery/features/home/data/models/work_out_response_dto.dart';
import 'package:flowery/features/home/domian/entities/food_for_you_model.dart';
import 'package:flowery/features/home/domian/entities/recommendation_model.dart';
import 'package:flowery/features/home/domian/entities/work_out_model.dart';

extension FoodForYouMapper on FoodForYouResponseDto {
  FoodForYouModel toEntity() => FoodForYouModel(
        categories: categories.map((e) => e.toEntity()).toList(),
      );
}

extension CategoryMapper on Category {
  CategoryModel toEntity() => CategoryModel(
        id: idCategory,
        name: strCategory,
        imageUrl: strCategoryThumb,
        description: strCategoryDescription,
      );
}

// work_out_mapper.dart
extension WorkOutMapper on WorkOutResponseDto {
  WorkOutModel toEntity() => WorkOutModel(
        message: message,
        musclesGroup: musclesGroup.map((e) => e.toEntity()).toList(),
      );
}

extension MuscleGroupMapper on MuscleGroup {
  MuscleGroupModel toEntity() => MuscleGroupModel(
        id: id,
        name: name,
      );
}



// recommendation_mapper.dart
extension RecommendationMapper on RecommendationToDayResponseDto {
  RecommendationModel toEntity() => RecommendationModel(
        message: message,
        totalMuscles: totalMuscles,
        muscles: muscles.map((e) => e.toEntity()).toList(),
      );
}

extension MuscleMapper on Muscle {  // الـ DTO اللي جاي من API
  MuscleModel toEntity() => MuscleModel(
        id: id,
        name: name,
        image: image,
      );
}