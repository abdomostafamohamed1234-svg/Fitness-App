// To parse this JSON data, do
//
//     final mealsFromCategoryResponseModel = mealsFromCategoryResponseModelFromJson(jsonString);

import 'package:flowery/featrures/food/domain/entities/meal_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'meals_from_category_response_model.g.dart';

MealsFromCategoryResponseModel mealsFromCategoryResponseModelFromJson(
  String str,
) => MealsFromCategoryResponseModel.fromJson(json.decode(str));

String mealsFromCategoryResponseModelToJson(
  MealsFromCategoryResponseModel data,
) => json.encode(data.toJson());

@JsonSerializable()
class MealsFromCategoryResponseModel {
  @JsonKey(name: "meals")
  List<Meal>? meals;

  MealsFromCategoryResponseModel({this.meals});

  factory MealsFromCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MealsFromCategoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealsFromCategoryResponseModelToJson(this);

  List<MealEntity> toEntity() =>
      meals
          ?.map(
            (meal) => MealEntity(
              title: meal.strMeal ?? "",
              img: meal.strMealThumb ?? "",
              id: meal.idMeal ?? "",
            ),
          )
          .toList() ??
      [];
}

@JsonSerializable()
class Meal {
  @JsonKey(name: "strMeal")
  String? strMeal;
  @JsonKey(name: "strMealThumb")
  String? strMealThumb;
  @JsonKey(name: "idMeal")
  String? idMeal;
  @JsonKey(name: "strArea")
  String? strArea;
  @JsonKey(name: "strCountry")
  String? strCountry;

  Meal({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
    this.strArea,
    this.strCountry,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}
