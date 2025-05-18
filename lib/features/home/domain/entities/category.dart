class Category {
  Category({
    required this.categoryId,
    required this.category,
    required this.imageUrl,
  });

  String categoryId;
  String category;
  String imageUrl;

  Category copyWith({
    String? categoryId,
    String? category,
    String? imageUrl,
  }) {
    return Category(
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
