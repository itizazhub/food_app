import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/cart/presentation/providers/cart_provider.dart';
import 'package:food_app/features/orders/presentation/screens/order_confirmed_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:food_app/features/addresses/domain/entities/address.dart';
import 'package:food_app/features/addresses/presentation/providers/address_provider.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
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
  String? selectedAddress;
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
    await addressNotifier.getUserAddresses(
      user: User(
        id: "-OPUxrBC0UHpf4kMnQMT",
        username: "test",
        email: "test@gmail.com",
        password: "test123",
        isAdmin: false,
      ),
    );

    final addresses = ref.watch(addressNotifierProvider);
    String? tempSelected = selectedAddress;

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
                                selectedAddress = address.address;
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
                          userId: "-OPUxrBC0UHpf4kMnQMT",
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
      MaterialPageRoute(builder: (context) => OrderConfirmedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartNotifierProvider);
    ref.watch(cartNotifierProvider.notifier).getUserCart(
            user: User(
          id: "-OPUxrBC0UHpf4kMnQMT",
          username: "test",
          email: "test@gmail.com",
          password: "test123",
          isAdmin: false,
        ));
    final cartItems = cart!.items ?? [];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 0, child: _buildTopHeader()),
            Positioned(
              top: 100,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 248, 248, 248),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
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
                        SingleChildScrollView(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cartItems.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("${cartItems[index].productId}"),
                                  trailing: Text(
                                      "${cartItems[index].quantity} items"),
                                );
                              }),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text("\$${(cart.total + 8).toString()}"),
                            ]),
                        Divider(),
                        Text(
                          "Payment Method",
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        RadioListTile(
                            title: Text("Cash on Delivery"),
                            value: "Cash",
                            groupValue: paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                paymentMethod = "Cash";
                              });
                            }),
                        RadioListTile(
                            title: Text("Card at Door Step"),
                            value: "Card",
                            groupValue: paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                paymentMethod = "Card";
                              });
                            }),
                        Divider(),
                        Text(
                          "Delivery Time",
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Estimated Delivery"),
                            Text("25 mins")
                          ],
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: CustomFilledButton(
                            text: "Order Now",
                            callBack: goToOrderConfirmedScreen,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildTopHeader() {
    return Container(
      height: 110,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(color: Color.fromARGB(255, 245, 203, 88)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                size: 18, color: Color.fromARGB(255, 233, 83, 34)),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            "Payment Method",
            style: GoogleFonts.leagueSpartan(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 50),
        ],
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
            selectedAddress ?? "Tap on edit icon",
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

  Widget _buildBottomNavBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 233, 83, 34),
        items: [
          _navItem("home"),
          _navItem("categories"),
          _navItem("favorites"),
          _navItem("list"),
          _navItem("help"),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navItem(String iconName) {
    return BottomNavigationBarItem(
      icon:
          SvgPicture.asset("bottom-navigation-icons/$iconName.svg", height: 24),
      label: '',
    );
  }
}
