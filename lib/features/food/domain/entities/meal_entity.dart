import 'package:equatable/equatable.dart';

class MealEntity extends Equatable {
  final String title;
  final String img;
  final String id;

  const MealEntity({required this.title, required this.img, required this.id});

  @override
  List<Object?> get props => [title, img, id];
}
