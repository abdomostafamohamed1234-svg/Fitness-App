import 'package:flowery/features/exercises/data/models/exercises_response.dart';
import 'package:flowery/features/exercises/data/models/levels_response.dart';
import 'package:flowery/features/exercises/domain/entities/exercises_entity.dart';
import 'package:flowery/features/exercises/domain/entities/levels_entity.dart';

extension ExercisesMapper on ExercisesResponse {
  ExercisesEntity toDomain() {
    return ExercisesEntity(
      message: message,
      totalExercises: totalExercises,
      totalPages: totalPages,
      currentPage: currentPage,
      exercises: exercises?.map((e) => e.toDomain()).toList(),
    );
  }
}

extension ExerciseMapper on Exercise {
  ExerciseEntity toDomain() {
    return ExerciseEntity(
      id: id,
      exercise: exercise,
      shortYoutubeDemonstration: shortYoutubeDemonstration,
      inDepthYoutubeExplanation: inDepthYoutubeExplanation,
      difficultyLevel: difficultyLevel,
      targetMuscleGroup: targetMuscleGroup,
      primeMoverMuscle: primeMoverMuscle,
      secondaryMuscle: secondaryMuscle,
      tertiaryMuscle: tertiaryMuscle,
      primaryEquipment: primaryEquipment,
      primaryItems: primaryItems,
      secondaryEquipment: secondaryEquipment,
      secondaryItems: secondaryItems,
      posture: posture,
      singleOrDoubleArm: singleOrDoubleArm,
      continuousOrAlternatingArms: continuousOrAlternatingArms,
      grip: grip,
      loadPositionEnding: loadPositionEnding,
      continuousOrAlternatingLegs: continuousOrAlternatingLegs,
      footElevation: footElevation,
      combinationExercises: combinationExercises,
      movementPattern1: movementPattern1,
      movementPattern2: movementPattern2,
      movementPattern3: movementPattern3,
      planeOfMotion1: planeOfMotion1,
      planeOfMotion2: planeOfMotion2,
      planeOfMotion3: planeOfMotion3,
      bodyRegion: bodyRegion,
      forceType: forceType,
      mechanics: mechanics,
      laterality: laterality,
      primaryExerciseClassification: primaryExerciseClassification,
      shortYoutubeDemonstrationLink: shortYoutubeDemonstrationLink,
      inDepthYoutubeExplanationLink: inDepthYoutubeExplanationLink,
    );
  }
}

extension LevelsMapper on LevelsResponse {
  LevelsEntity toDomain() {
    return LevelsEntity(
      message: message,
      totalLevels: totalLevels,
      difficultyLevels: difficultyLevels?.map((e) => e.toDomain()).toList(),
    );
  }
}

extension DifficultyLevelMapper on DifficultyLevel {
  DifficultyLevelEntity toDomain() {
    return DifficultyLevelEntity(id: id, name: name);
  }
}
