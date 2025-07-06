// product_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/categories/domain/entities/category.dart';
import 'package:food_app/features/products/domain/entities/product.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/theme/text_styles.dart';
import 'package:food_app/features/core/widgets/custom_icon.dart';
import 'package:food_app/features/recommended/presentation/widgets/favorite_button.dart';
import 'package:food_app/features/products/presentation/screens/product_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Category category;
  final User currentUser;

  const ProductCard({
    super.key,
    required this.product,
    required this.category,
    required this.currentUser,
  });

  void goToProductScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToProductScreen(context),
      child: Card(
        elevation: 0,
        color: const Color.fromARGB(255, 248, 248, 248),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    height: 140.h,
                    width: 160.w,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: CustomIcon(
                    width: 26.w,
                    height: 26.h,
                    radius: 9.r,
                    path: "assets/${category.imageUrl}",
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: FavoriteButton(product: product, user: currentUser),
                ),
                Positioned(
                  bottom: 15,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(top: 2, left: 2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 83, 34),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        bottomLeft: Radius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      "\$${product.price.toStringAsFixed(2)}",
                      style: AppTextStyles.textStyleParagraph7,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizedBoxHeights.height10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.productName,
                    style: AppTextStyles.textStyleAppBodyTitle4,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27.r),
                    color: const Color.fromARGB(255, 233, 83, 34),
                  ),
                  child: Row(
                    children: [
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: AppTextStyles.textStyleParagraph7,
                      ),
                      SvgPicture.asset("assets/rating-icons/rating.svg")
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 115.w,
                  child: Text(
                    product.description,
                    style: AppTextStyles.textStyleParagraph5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const CircleAvatar(
                  radius: 10,
                  backgroundColor: Color.fromARGB(255, 233, 83, 34),
                  foregroundColor: Color.fromARGB(255, 248, 248, 248),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
