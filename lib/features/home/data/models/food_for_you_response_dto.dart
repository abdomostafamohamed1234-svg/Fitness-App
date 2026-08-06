import 'package:json_annotation/json_annotation.dart';

part 'food_for_you_response_dto.g.dart';

@JsonSerializable()
class FoodForYouResponseDto {
  final List<Category> categories;

  FoodForYouResponseDto({
    required this.categories,
  });

  factory FoodForYouResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FoodForYouResponseDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FoodForYouResponseDtoToJson(this);
}

@JsonSerializable()
class Category {
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  Category({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryToJson(this);
}