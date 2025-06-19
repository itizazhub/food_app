import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/addresses/domain/entities/address.dart';
import 'package:food_app/features/addresses/presentation/providers/address_provider.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/core/widgets/custom_text_form_field.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:food_app/features/orders/presentation/screens/payment_method_screen.dart';
import 'package:food_app/features/orders/presentation/widgets/confirm_order_list_view.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmOrderScreen extends ConsumerStatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  ConsumerState<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends ConsumerState<ConfirmOrderScreen> {
  int _currentIndex = 0;

  final _formKey = GlobalKey<FormState>();
  final _addressInput = TextEditingController();

  var cartItems;
  var cart;

  // String? selectedAddress;
  String? paymentMethod = "";

  @override
  void dispose() {
    _addressInput.dispose();
    super.dispose();
  }

  // Function to handle navigation
  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Add your custom navigation logic here
    // For now, we will navigate to a different screen based on the index
    if (_currentIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (_currentIndex == 1) {
      // Handle second navigation, e.g., go to Categories
    } else if (_currentIndex == 2) {
      // Handle third navigation, e.g., go to Favorites
    } else if (_currentIndex == 3) {
      // Handle fourth navigation, e.g., go to List
    } else if (_currentIndex == 4) {
      // Handle fifth navigation, e.g., go to Help
    }
  }

  Future<void> goToPaymentMethodScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentMethodScreen()),
    );
  }

  Future<void> _showAddressDialog() async {
    final addressNotifier = ref.read(addressNotifierProvider.notifier);
    final selectedAddressNotifier =
        ref.watch(selectedAddressNotifierProvider.notifier);

    await addressNotifier.getUserAddresses(
      user: ref.watch(authUserNotifierProvider)!,
    );

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
                          userId: ref.watch(authUserNotifierProvider)!.id,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 245, 203, 88),
      resizeToAvoidBottomInset: true, // Ensure UI adjusts with keyboard
      body: SafeArea(
        child: Stack(children: [
          // Top section (title, back button)
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 110,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 245, 203, 88),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      // Go back to the previous screen
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      size: 18,
                      Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 233, 83, 34),
                    ),
                  ),
                  Text(
                    "Confirm Order",
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 248, 248, 248),
                    ),
                  ),
                  SizedBox(width: 50), // You can remove this if not needed
                ],
              ),
            ),
          ),

          // Bottom section with rounded corners
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 100,
            child: Container(
              height: MediaQuery.of(context).size.height * .8,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 248, 248, 248),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              // Adjust height to avoid overlap with keyboard
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShippingAddressSection(),
                    const SizedBox(height: 25),
                    Text(
                      "Order Summary",
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Divider(),
                    ConfirmOrderListView(),
                    Row(
                      children: [
                        Text("Subtotal"),
                        Spacer(),
                        Text(
                            "\$${ref.watch(cartNotifierProvider)!.total.toStringAsFixed(2)}")
                      ],
                    ),
                    Row(
                      children: [
                        Text("Tax and fees"),
                        Spacer(),
                        Text("\$5.00")
                      ],
                    ),
                    Row(
                      children: [Text("Delivery"), Spacer(), Text("\$3.00")],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text("Total"),
                        Spacer(),
                        Text(
                            "\$${(ref.watch(cartNotifierProvider)!.total + 8).toStringAsFixed(2)}")
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomFilledButton(
                        text: "Place Order",
                        height: 36,
                        widht: 150,
                        fontSize: 20,
                        foregroundcolor: Colors.white,
                        callBack: goToPaymentMethodScreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12), // Round top-left corner
          topRight: Radius.circular(12), // Round top-right corner
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color.fromARGB(255, 233, 83, 34),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onNavItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/home.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/categories.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/favorites.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/list.svg",
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "bottom-navigation-icons/help.svg",
                ),
                label: "")
          ],
        ),
      ),
    );
  }

  Widget _buildShippingAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Shipping Address",
              style: GoogleFonts.leagueSpartan(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 233, 83, 34),
              ),
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
            style: GoogleFonts.leagueSpartan(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 15, 15, 14),
            ),
          ),
        ),
      ],
    );
  }
}
