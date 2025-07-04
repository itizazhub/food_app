import 'package:food_app/features/categories/domain/entities/category.dart';

class CategoryModel {
  CategoryModel({
    required this.categoryId,
    required this.category,
    required this.imageUrl,
  });
  String categoryId;
  String category;
  String imageUrl;

  factory CategoryModel.fromJson(
      {required String key, required Map<String, dynamic> json}) {
    return CategoryModel(
      categoryId: key,
      category: json["category"],
      imageUrl: json["image_url"],
    );
  }
  factory CategoryModel.fromEntity({required Category category}) {
    return CategoryModel(
        categoryId: category.categoryId,
        category: category.category,
        imageUrl: category.imageUrl);
  }

  Map<String, dynamic> toJson({required CategoryModel category}) {
    return {
      "category": category.category,
      "image_url": category.imageUrl,
    };
  }

  Category toEntity() {
    return Category(
      categoryId: categoryId,
      category: category,
      imageUrl: imageUrl,
    );
  }
}
