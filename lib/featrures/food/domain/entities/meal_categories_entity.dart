import 'package:equatable/equatable.dart';

class MealCategoriesEntity extends Equatable{
  final List<String> categories;

  const MealCategoriesEntity({required this.categories});
  
  @override
  List<Object?> get props => [categories];
}
