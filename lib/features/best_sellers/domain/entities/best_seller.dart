class BestSeller {
  BestSeller({
    required this.bestSellerId,
    required this.productId,
  });

  String bestSellerId;
  String productId;

  BestSeller copyWith({
    String? bestSellerId,
    String? productId,
  }) {
    return BestSeller(
      bestSellerId: bestSellerId ?? this.bestSellerId,
      productId: productId ?? this.productId,
    );
  }
}
