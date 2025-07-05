class Recommended {
  Recommended({
    required this.recommendedId,
    required this.productId,
  });

  String recommendedId;
  String productId;

  Recommended copyWith({
    String? recommendedId,
    String? productId,
  }) {
    return Recommended(
      recommendedId: recommendedId ?? this.recommendedId,
      productId: productId ?? this.productId,
    );
  }
}
