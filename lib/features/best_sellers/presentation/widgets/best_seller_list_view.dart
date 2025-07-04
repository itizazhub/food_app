import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/best_sellers/presentation/providers/best_seller_products_provider.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
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
      height: 125,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bestSellersProducts.length,
          itemBuilder: (context, index) {
            final product = bestSellersProducts[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                // onTap: () =>
                //     goToProductScreen(product: product),
                child: Stack(
                  children: [
                    Container(
                      height: 108,
                      width: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            23), // Optional: Adds rounded corners to the image
                        child: Image.asset(
                          product.imageUrl,
                          fit: BoxFit
                              .cover, // Optional: Ensures the image covers the entire container
                        ),
                      ),
                    ),
                    Positioned(
                      bottom:
                          10, // Adjust the bottom position to place text appropriately
                      right:
                          0, // Adjust the left position to place text appropriately
                      child: Container(
                        padding: const EdgeInsets.only(top: 2, left: 2),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 233, 83, 34),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6))),

                        // Optional: Adds a background to the text for better readability
                        child: Text(
                          "\$${product.price.toString()}",
                          style: GoogleFonts.leagueSpartan(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
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
