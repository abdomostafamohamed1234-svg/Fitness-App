class WorkOutModel {
  final String message;
  final List<MuscleGroupModel> musclesGroup;

  WorkOutModel({
    required this.message,
    required this.musclesGroup,
  });
}

class MuscleGroupModel {
  final String id;
  final String name;

  MuscleGroupModel({
    required this.id,
    required this.name,
  });
}