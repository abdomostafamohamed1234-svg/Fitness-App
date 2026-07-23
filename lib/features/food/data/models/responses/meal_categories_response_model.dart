import 'package:flowery/features/food/domain/entities/meal_categories_entity.dart';
import 'package:flowery/features/food/domain/entities/meal_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'meal_categories_response_model.g.dart';

MealCategoriesResponseModel mealCategoriesResponseModelFromJson(String str) =>
    MealCategoriesResponseModel.fromJson(json.decode(str));

String mealCategoriesResponseModelToJson(MealCategoriesResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class MealCategoriesResponseModel {
  @JsonKey(name: "categories")
  List<Category>? categories;

  MealCategoriesResponseModel({this.categories});

  factory MealCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MealCategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealCategoriesResponseModelToJson(this);

  MealCategoriesEntity toEntity() {
    return MealCategoriesEntity(
      categories:
          categories
              ?.map(
                (category) => MealEntity(
                  id: category.idCategory ?? "",
                  img: category.strCategoryThumb ?? "",
                  title: category.strCategory ?? "",
                ),
              )
              .toList() ??
          [],
    );
  }
}

@JsonSerializable()
class Category {
  @JsonKey(name: "idCategory")
  String? idCategory;
  @JsonKey(name: "strCategory")
  String? strCategory;
  @JsonKey(name: "strCategoryThumb")
  String? strCategoryThumb;
  @JsonKey(name: "strCategoryDescription")
  String? strCategoryDescription;

  Category({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
