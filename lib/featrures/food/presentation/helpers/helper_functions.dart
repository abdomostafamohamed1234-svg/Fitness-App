abstract class HelperFunctions {
  static Map<String, String> removeEmptyMapValues(Map<String, String> map) {
    final int mapSize = (map.length / 2).toInt();
    for (int i = 1; i <= mapSize; i++) {
      final ingredient = map["strIngredient$i"];
      final measure = map["strMeasure$i"];
      if ((ingredient == null || ingredient.trim().isEmpty) &&
          (measure == null || measure.trim().isEmpty)) {
        map.remove("strIngredient$i");
        map.remove("strMeasure$i");
      }
    }
    return map;
  }
}
