import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/carts/domain/entities/cart_item.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/home/domain/entities/favorite.dart';
import 'package:food_app/features/home/domain/entities/product.dart';
import 'package:food_app/features/home/presentation/providers/favorite_provider.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key, required this.product});
  final Product product;

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  int _currentIndex = 0;
  List<String> selectedToppings = [];
  int _quantity = 1;

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (_currentIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
    // Add handling for other nav indices if needed
  }

  Widget buildToppingOption(String label, double price) {
    final isSelected = selectedToppings.contains(label);
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.leagueSpartan(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 51, 29, 22),
          ),
        ),
        const Spacer(),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              isSelected
                  ? selectedToppings.remove(label)
                  : selectedToppings.add(label);
            });
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? const Color.fromARGB(255, 233, 83, 34)
                  : Colors.transparent,
              border: Border.all(
                color: const Color.fromARGB(255, 233, 83, 34),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const mainColor = Color.fromARGB(255, 233, 83, 34);
    const bgColor = Color.fromARGB(255, 248, 248, 248);

    final cartItems = ref.watch(cartNotifierProvider)?.items ?? [];
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final existingCartItem = cartItems
        .where((item) => item.productId == widget.product.productId)
        .firstOrNull;
    int quantity = existingCartItem?.quantity ?? _quantity;

    final favs = ref.watch(favoriteNotifierProvider);
    final currentUser = ref.watch(authUserNotifierProvider).user;
    final favoriteNotifier = ref.read(favoriteNotifierProvider.notifier);
    final isFavorite =
        favs.any((fav) => fav.productId == widget.product.productId);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 110,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 245, 203, 88),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                            color: mainColor,
                          ),
                        ),
                        Text(
                          widget.product.productName,
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: bgColor,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: InkWell(
                        onTap: () async {
                          if (currentUser == null) return;

                          if (isFavorite) {
                            final toRemove = favs.firstWhere(
                              (fav) =>
                                  fav.productId == widget.product.productId,
                            );
                            await favoriteNotifier.removeUserFavorite(
                                favorite: toRemove);
                          } else {
                            await favoriteNotifier.addUserFavorite(
                              favorite: Favorite(
                                favoriteId: '',
                                productId: widget.product.productId,
                                userId: currentUser.id,
                              ),
                            );
                          }

                          await favoriteNotifier.getUserFavorite(
                              user: currentUser);
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white.withOpacity(0.5),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 16,
                            color: isFavorite ? Colors.red : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 100,
              child: Container(
                decoration: const BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          widget.product.imageUrl,
                          fit: BoxFit.cover,
                          height: 320,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "\$${widget.product.price}",
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: mainColor,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: mainColor,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "3.5",
                                      style: GoogleFonts.leagueSpartan(
                                        color: bgColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11,
                                      ),
                                    ),
                                    SvgPicture.asset("rating-icons/rating.svg"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cartNotifier.decreaseItemQuantity(
                                      widget.product.productId);
                                },
                                child: const CircleAvatar(
                                  radius: 10.5,
                                  backgroundColor:
                                      Color.fromARGB(180, 168, 121, 93),
                                  child: Icon(Icons.remove,
                                      size: 16, color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text("$quantity"),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  cartNotifier.addItemToCart(
                                    cartItem: CartItem(
                                      productId: widget.product.productId,
                                      quantity: quantity,
                                      price: widget.product.price,
                                      imageUrl: widget.product.imageUrl,
                                      productName: widget.product.productName,
                                    ),
                                    maxQuantity: widget.product.stockQuantity,
                                  );
                                },
                                child: const CircleAvatar(
                                  radius: 10.5,
                                  backgroundColor:
                                      Color.fromARGB(180, 209, 91, 22),
                                  child: Icon(Icons.add,
                                      size: 16, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.product.description,
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 51, 29, 22),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Toppings",
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 51, 29, 22),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      buildToppingOption("Guacamole", 2.99),
                      const SizedBox(height: 8),
                      buildToppingOption("Jalapeños", 2.99),
                      const SizedBox(height: 8),
                      buildToppingOption("Cheese", 1.49),
                      const SizedBox(height: 20),
                      InkWell(
                        child: const CustomFilledButton(
                          text: "Add to Cart",
                          height: 33,
                          widht: 180,
                          fontSize: 20,
                          foregroundcolor: Colors.white,
                        ),
                        onTap: () {
                          final isAlreadyInCart = cartItems.any(
                            (item) =>
                                item.productId == widget.product.productId,
                          );
                          if (!isAlreadyInCart) {
                            cartNotifier.addItemToCart(
                              cartItem: CartItem(
                                productId: widget.product.productId,
                                quantity: quantity,
                                price: widget.product.price,
                                imageUrl: widget.product.imageUrl,
                                productName: widget.product.productName,
                              ),
                              maxQuantity: widget.product.stockQuantity,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: mainColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onNavItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home), // Replace with actual asset if needed
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
