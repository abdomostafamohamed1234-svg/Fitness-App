class AppEndPoints {
  // ===================== Base URLs =====================
  static const String baseUrl = "https://fitness.elevateegy.com/api/v1";
  static const String mealsBaseUrl = "https://www.themealdb.com/api/json/v1/1";

  // ===================== Authentication =====================
  static const String signup = "/auth/signup";
  static const String signin = "/auth/signin";
  static const String changePassword = "/auth/change-password";
  static const String uploadPhoto = "/auth/upload-photo";
  static const String profileData = "/auth/profile-data";
  static const String logout = "/auth/logout";
  static const String forgotPassword = "/auth/forgotPassword";
  static const String verifyResetCode = "/auth/verifyResetCode";
  static const String resetPassword = "/auth/resetPassword";
  static const String deleteMe = "/auth/deleteMe";
  static const String editProfile = "/auth/editProfile";

  // ===================== Levels =====================
  static const String levels = "/levels";
  static const String difficultyLevelsByPrimeMover =
      "/levels/difficulty-levels/by-prime-mover";

  // ===================== Muscles =====================
  static const String muscles = "/muscles";
  static const String musclesByGroup = "/musclesGroup";
  static const String randomMuscles = "/muscles/random";
  static const String primeMoverByMuscleGroup =
      "/musclesGroup/by-muscle-group";

  // ===================== Exercises =====================
  static const String exercises = "/exercises";
  static const String exercisesByMuscleDifficulty =
      "/exercises/by-muscle-difficulty";
  static const String randomExercises = "/exercises/random";

  // ===================== Meals (TheMealDB) =====================
  static const String mealCategories = "/categories.php";
  static const String mealsByCategory = "/filter.php";
  static const String mealDetails = "/lookup.php";
}