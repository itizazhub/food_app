import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/auth/presentation/widgets/bottom_navbar_item.dart';
import 'package:food_app/features/carts/domain/entities/cart_item.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/helper_functions/status_bar_background_color.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:food_app/features/recommended/presentation/widgets/favorite_button.dart';
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
          style: AppTextStyles.textStyleParagraph2,
        ),
        const Spacer(),
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: AppTextStyles.textStyleParagraph2,
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

    final cartItems = ref.watch(cartNotifierProvider).cart?.items ?? [];
    final cartNotifier = ref.read(cartNotifierProvider.notifier);
    final existingCartItem = cartItems
        .where((item) => item.productId == widget.product.productId)
        .firstOrNull;
    int quantity = existingCartItem?.quantity ?? _quantity;
    print(quantity);

    // final currentUser = ref.watch(authUserNotifierProvider).user;
    final currentUser = User(
        id: "-OPUxrBC0UHpf4kMnQMT",
        username: "test",
        email: "test@gmail.com",
        password: "testUpdatedAgain1/",
        isAdmin: false);

    statusBarBackgroundColor();
    return Scaffold(
      backgroundColor: AppColors.fontLight,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppHorizentalPaddingds.padding32),
                decoration: const BoxDecoration(color: AppColors.yellowDark),
                height: AppContainerHeights.height170,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizedBoxHeights.height76),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            'assets/back-arrow-icons/back-arrow-icon.svg',
                            width: AppSvgWidths.width4,
                            height: AppSvgHeights.height9,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.product.productName,
                          style: AppTextStyles.textStyleAppBarTitle,
                        ),
                        const Spacer(),
                        FavoriteButton(
                            product: widget.product, user: currentUser),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 130.h,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppRadiuses.radius30),
                    topRight: Radius.circular(AppRadiuses.radius30),
                  ),
                  color: AppColors.fontLight,
                ),
                padding: EdgeInsets.only(
                  left: AppHorizentalPaddingds.padding32,
                  right: AppHorizentalPaddingds.padding32,
                  top: AppVerticalPaddingds.padding35,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(36.r),
                        child: Image.asset(
                          widget.product.imageUrl,
                          fit: BoxFit.cover,
                          height: 230.h,
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(height: AppSizedBoxHeights.height32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "\$${widget.product.price.toStringAsFixed(2)}",
                                style: AppTextStyles.textStyleAppBodyTitle5,
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
                                      widget.product.rating.toStringAsFixed(1),
                                      style: GoogleFonts.leagueSpartan(
                                        color: bgColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                        "assets/rating-icons/rating.svg"),
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
                              Text(
                                "$quantity",
                                style: AppTextStyles.textStyleParagraph8,
                              ),
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
                      const Divider(color: AppColors.orangeLight),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.product.description,
                          style: AppTextStyles.textStyleParagraph8,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Toppings",
                          style: AppTextStyles.textStyleAppBodyTitle2,
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
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadiuses.radius30),
          topRight: Radius.circular(AppRadiuses.radius30),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppColors.orangeDark,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onNavItemTapped,
          items: [
            item("assets/bottom-navigation-icons/home.svg"),
            item("assets/bottom-navigation-icons/categories.svg"),
            item("assets/bottom-navigation-icons/favorites.svg"),
            item("assets/bottom-navigation-icons/list.svg"),
            item("assets/bottom-navigation-icons/help.svg"),
          ],
        ),
      ),
    );
  }
}
