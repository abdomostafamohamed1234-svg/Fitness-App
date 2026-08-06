/// Holds all the data collected during the multi-step register survey
/// (gender, age, weight, height, goal, activity level).
///
/// This is shared between normal email/password register and any
/// social register flow (Google, Facebook, ...), since the survey
/// steps are identical regardless of how the user authenticates.
class RegisterSurveyData {
  String? gender;
  int? age;
  int? weight;
  int? height;
  String? goal;
  String? physicalActivityLevel;

  RegisterSurveyData({
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.physicalActivityLevel,
  });

  /// Converts the survey data to the keys expected by the register API.
  Map<String, dynamic> toJson() => {
        'gender': gender,
        'height': height,
        'weight': weight,
        'age': age,
        'goal': goal,
        'activityLevel': physicalActivityLevel,
      };

  /// True once the user has answered every step.
  bool get isComplete =>
      gender != null &&
      age != null &&
      weight != null &&
      height != null &&
      goal != null &&
      physicalActivityLevel != null;

  RegisterSurveyData copyWith({
    String? gender,
    int? age,
    int? weight,
    int? height,
    String? goal,
    String? physicalActivityLevel,
  }) {
    return RegisterSurveyData(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      physicalActivityLevel:
          physicalActivityLevel ?? this.physicalActivityLevel,
    );
  }

  /// Resets all fields back to null (useful after a failed/cancelled flow).
  void clear() {
    gender = null;
    age = null;
    weight = null;
    height = null;
    goal = null;
    physicalActivityLevel = null;
  }
}