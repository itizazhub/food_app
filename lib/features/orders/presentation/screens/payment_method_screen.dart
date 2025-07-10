import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/auth/presentation/widgets/bottom_navbar_item.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';
import 'package:food_app/features/core/constants/sizes.dart';
import 'package:food_app/features/core/date_functions/get_current_formatted_date.dart';
import 'package:food_app/features/core/helper_functions/status_bar_background_color.dart';
import 'package:food_app/features/core/theme/text_styles.dart';

import 'package:food_app/features/orders/domain/entities/order.dart';
import 'package:food_app/features/orders/presentation/providers/order_provider.dart';
import 'package:food_app/features/orders/presentation/screens/order_confirmed_screen.dart';
import 'package:food_app/features/payment_methods/presentation/providers/payment_methods_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:food_app/features/addresses/domain/entities/address.dart';
import 'package:food_app/features/addresses/presentation/providers/address_provider.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/core/widgets/custom_text_form_field.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';

class PaymentMethodScreen extends ConsumerStatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  ConsumerState<PaymentMethodScreen> createState() =>
      _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends ConsumerState<PaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressInput = TextEditingController();
  int _currentIndex = 0;

  var cartItems;
  var cart;

  // String? selectedAddress;
  String? paymentMethod = "";

  @override
  void dispose() {
    _addressInput.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    setState(() => _currentIndex = index);
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  Future<void> _showAddressDialog() async {
    final addressNotifier = ref.read(addressNotifierProvider.notifier);
    final selectedAddressNotifier =
        ref.watch(selectedAddressNotifierProvider.notifier);

    // await addressNotifier.getUserAddresses(
    //   user: ref.watch(authUserNotifierProvider).user!,
    // );

    final addresses = ref.watch(addressNotifierProvider);
    // String? tempSelected = selectedAddress;

    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Address'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (addresses != null && addresses.isNotEmpty)
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: ListView.builder(
                        itemCount: addresses.length,
                        itemBuilder: (_, index) {
                          final address = addresses[index];
                          return ListTile(
                            title: Text(address.address),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await _showAddAddressDialog(
                                          address: address);
                                    },
                                    child: Icon(Icons.edit)),
                                InkWell(
                                    onTap: () async {
                                      await addressNotifier.removeUserAddress(
                                          address: Address(
                                              addressId: address.addressId,
                                              userId: address.userId,
                                              address: address.address));
                                      Navigator.pop(context);
                                      await _showAddressDialog();
                                    },
                                    child: Icon(Icons.delete)),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                selectedAddressNotifier.selectAddress(address);
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    )
                  else
                    const Center(child: Text("No address found")),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 150,
                    height: 35,
                    child: CustomFilledButton(
                      text: "Add New Address",
                      widht: 150,
                      height: 35,
                      fontSize: 12,
                      callBack: () async {
                        Navigator.pop(context);
                        await _showAddAddressDialog();
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                CustomFilledButton(
                    text: "cancel",
                    widht: 80,
                    height: 25,
                    fontSize: 12,
                    callBack: () async {
                      Navigator.pop(context);
                    }),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showAddAddressDialog({Address? address}) async {
    final addressNotifier = ref.read(addressNotifierProvider.notifier);
    if (address != null) {
      _addressInput.text = address.address;
    }

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(address == null ? 'Enter New Address' : 'Update Address'),
        content: Form(
          key: _formKey,
          child: CustomTextFormField(
            controller: _addressInput,
            background: const Color.fromARGB(255, 243, 233, 181),
            radius: 12,
            width: double.infinity,
            height: 45,
            fontSize: 20,
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'Address cannot be empty'
                : null,
          ),
        ),
        actions: [
          CustomFilledButton(
              text: "cancel",
              widht: 80,
              height: 25,
              fontSize: 12,
              callBack: () async {
                _addressInput.clear();
                if (mounted) {
                  Navigator.pop(context);
                  await _showAddressDialog();
                }
              }),
          CustomFilledButton(
            text: address == null ? "Add Address" : "Update Address",
            widht: 130,
            height: 25,
            fontSize: 12,
            callBack: () async {
              if (_formKey.currentState?.validate() ?? false) {
                address == null
                    ? await addressNotifier.addUserAddress(
                        address: Address(
                          addressId: "",
                          userId: ref.watch(authUserNotifierProvider).user!.id,
                          address: _addressInput.text.trim(),
                        ),
                      )
                    : await addressNotifier.updateUserAddress(
                        address: Address(
                          addressId: address.addressId,
                          userId: address.userId,
                          address: _addressInput.text.trim(),
                        ),
                      );
                _addressInput.clear();
                if (mounted) {
                  Navigator.pop(context);
                  await _showAddressDialog();
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> goToOrderConfirmedScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrderConfirmedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartNotifierProvider);
    // ref
    //     .watch(cartNotifierProvider.notifier)
    //     .getUserCart(user: ref.watch(authUserNotifierProvider).user!);
    cartItems = cartState.cart!.items ?? [];
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            "Payment Method",
                            style: AppTextStyles.textStyleAppBarTitle,
                          ),
                          const Spacer(),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildShippingAddressSection(),
                          const SizedBox(height: 25),
                          Text(
                            "Order Summary",
                            style: AppTextStyles.textStyleAppBodyTitle2,
                          ),
                          const Divider(color: AppColors.orangeLight),
                          SingleChildScrollView(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      "${cartItems[index].productName}",
                                      style:
                                          AppTextStyles.textStyleAppBodyTitle2,
                                    ),
                                    trailing: Text(
                                      "${cartItems[index].quantity} items",
                                      style: AppTextStyles.textStyleParagraph8
                                          .copyWith(
                                              color: AppColors.orangeDark),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(height: AppSizedBoxHeights.height20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: AppTextStyles.textStyleAppBodyTitle2,
                                ),
                                Text(
                                  "\$${(cartState.cart!.total + 8).toString()}",
                                  style: AppTextStyles.textStyleAppBodyTitle2,
                                ),
                              ]),
                          const Divider(color: AppColors.orangeLight),
                          SizedBox(height: AppSizedBoxHeights.height10),
                          Text(
                            "Payment Method",
                            style: AppTextStyles.textStyleAppBodyTitle2,
                          ),
                          RadioListTile(
                              title: Text("Cash on Delivery",
                                  style: AppTextStyles.textStyleAppBodyTitle4),
                              value: "Cash",
                              groupValue: paymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  paymentMethod = "Cash";
                                });
                              }),
                          RadioListTile(
                              title: Text("Card at Door Step",
                                  style: AppTextStyles.textStyleAppBodyTitle4),
                              value: "Card",
                              groupValue: paymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  paymentMethod = "Card";
                                });
                              }),
                          const Divider(color: AppColors.orangeLight),
                          Text(
                            "Delivery Time",
                            style: AppTextStyles.textStyleAppBodyTitle2,
                          ),
                          SizedBox(height: AppSizedBoxHeights.height10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Estimated Delivery",
                                  style: AppTextStyles.textStyleAppBodyTitle4),
                              Text("25 mins",
                                  style: AppTextStyles.textStyleAppBodyTitle4)
                            ],
                          ),
                          SizedBox(height: AppSizedBoxHeights.height32),
                          Align(
                            alignment: Alignment.center,
                            child: CustomFilledButton(
                              text: "Order Now",
                              callBack: () async {
                                await ref
                                    .watch(
                                        paymentMethodsNotifierProvider.notifier)
                                    .getPaymentMethods();
                                final paymentMethods = await ref
                                    .watch(paymentMethodsNotifierProvider);
                                final _paymentMethod =
                                    paymentMethods.firstWhere((element) {
                                  return element.payment == paymentMethod;
                                });

                                await ref
                                    .watch(orderNotifierProvider.notifier)
                                    .addOrder(
                                        order: Order(
                                      addressId: ref
                                          .watch(
                                              selectedAddressNotifierProvider)!
                                          .addressId,
                                      items: cartItems,
                                      orderDate: getCurrentFormattedDate(),
                                      orderId: "",
                                      orderStatus:
                                          "-OPVnopZWgoqB8b3oK8I", // statusId
                                      orderType: "delivery",
                                      paymentMethodId: _paymentMethod.paymentId,
                                      total: cartState.cart!.total,
                                      userId: "-OPUxrBC0UHpf4kMnQMT", // ref
                                      // .watch(authUserNotifierProvider)
                                      //.user!
                                      //.id,
                                    ));
                                ref
                                    .watch(cartNotifierProvider.notifier)
                                    .clearCart();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OrderConfirmedScreen()),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: AppSizedBoxHeights.height32),
                        ]),
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
        ));
  }

  Widget _buildShippingAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Shipping Address",
              style: AppTextStyles.textStyleAppBarTitle3
                  .copyWith(color: AppColors.fontDark),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: _showAddressDialog,
              child: const Icon(Icons.edit, size: 18),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 40,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 211, 182, 51),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            ref.watch(selectedAddressNotifierProvider) == null
                ? "Tap on edit icon"
                : ref.watch(selectedAddressNotifierProvider)!.address,
            style: AppTextStyles.textStyleParagraph8.copyWith(
              fontWeight: AppFontWeights.regular,
            ),
          ),
        ),
      ],
    );
  }
}
