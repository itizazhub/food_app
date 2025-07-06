import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/best_sellers/presentation/providers/best_seller_products_provider.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/products/presentation/screens/product_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class BestSellerListView extends ConsumerStatefulWidget {
  BestSellerListView({super.key});

  @override
  ConsumerState<BestSellerListView> createState() => _BestSellerListViewState();
}

class _BestSellerListViewState extends ConsumerState<BestSellerListView> {
  void goToProductScreen({required Product product}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductScreen(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bestSellersState = ref.watch(bestSellersNotifierProvider);

    if (bestSellersState.isLoading) {
      return const CircularProgressIndicator();
    }

    if (bestSellersState.failure != null) {
      return Text("Error: ${bestSellersState.failure!.message}");
    }
    final bestSellersProducts = bestSellersState.products;

    return SizedBox(
      height: 108.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bestSellersProducts.length,
          itemBuilder: (context, index) {
            final product = bestSellersProducts[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => goToProductScreen(product: product),
                child: Stack(
                  children: [
                    Container(
                      height: 108.h,
                      width: 70.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Image.asset(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16.h,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(top: 2, left: 2),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 233, 83, 34),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                bottomLeft: Radius.circular(30.r))),

                        // Optional: Adds a background to the text for better readability
                        child: Text(
                          "\$${product.price.toString()}",
                          style: AppTextStyles.textStyleParagraph7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
