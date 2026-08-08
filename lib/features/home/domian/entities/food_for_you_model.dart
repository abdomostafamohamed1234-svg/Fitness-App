class FoodForYouModel {
  final List<CategoryModel> categories;

  FoodForYouModel({required this.categories});
}

class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final String description;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });
}