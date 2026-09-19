import 'package:equatable/equatable.dart';

class LevelsEntity extends Equatable {
  final String? message;
  final int? totalLevels;
  final List<DifficultyLevelEntity>? difficultyLevels;

  const LevelsEntity({this.message, this.totalLevels, this.difficultyLevels});

  @override
  List<Object?> get props => [message, totalLevels, difficultyLevels];
}

class DifficultyLevelEntity extends Equatable {
  final String? id;
  final String? name;

  const DifficultyLevelEntity({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
