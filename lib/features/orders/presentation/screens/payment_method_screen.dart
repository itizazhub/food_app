import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  Future<void> _showAddressDialog(List<Address> addresses) async {
    String? tempSelected = selectedAddress;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Address'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 400,
                      child: ListView.builder(
                        itemCount: addresses.length,
                        itemBuilder: (_, index) {
                          final address = addresses[index];
                          return RadioListTile<String>(
                            value: address.address,
                            groupValue: tempSelected,
                            title: Text(address.address),
                            onChanged: (value) {
                              setDialogState(() => tempSelected = value);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomFilledButton(
                      text: "Add New Address",
                      widht: 150,
                      height: 30,
                      fontSize: 12,
                      callBack: () async {
                        Navigator.pop(context);
                        _showAddAddressDialog();
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        selectedAddress = tempSelected;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Confirm')),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showAddAddressDialog() async {
    final addressNotifier = ref.read(addressNotifierProvider.notifier);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Enter New Address'),
        content: Form(
          key: _formKey,
          child: CustomTextFormField(
            controller: _addressInput,
            background: const Color.fromARGB(255, 243, 233, 181),
            radius: 12,
            width: double.infinity,
            fontSize: 20,
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'Address cannot be empty'
                : null,
          ),
        ),
        actions: [
          CustomFilledButton(
            text: "Add Address",
            widht: 150,
            height: 30,
            fontSize: 12,
            callBack: () async {
              if (_formKey.currentState?.validate() ?? false) {
                await addressNotifier.addUserAddress(
                  address: Address(
                    addressId: "",
                    userId: "-OPUxrBC0UHpf4kMnQMT",
                    address: _addressInput.text.trim(),
                  ),
                );
                if (mounted) Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userAddresses = ref.watch(addressNotifierProvider);
    final addressNotifier = ref.read(addressNotifierProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopHeader(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 248, 248, 248),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShippingAddressSection(
                          userAddresses, addressNotifier),
                      const SizedBox(height: 25),
                      Text(
                        "Order Summary",
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Divider(),
                      // TODO: Add ConfirmOrderListView or other summary widgets
                    ],
                  ),
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
              color: const Color.fromARGB(255, 248, 248, 248),
            ),
          ),
          const SizedBox(width: 50),
        ],
      ),
    );
  }

  Widget _buildShippingAddressSection(
      List<Address> addresses, addressNotifier) {
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
              onTap: () async {
                await addressNotifier.getUserAddresses(
                  user: User(
                    id: "-OPUxrBC0UHpf4kMnQMT",
                    username: "test",
                    email: "test@gmailc.com",
                    password: "test123",
                    isAdmin: false,
                  ),
                );
                if (addresses.isNotEmpty) {
                  _showAddressDialog(addresses);
                }
              },
              child: const Icon(Icons.edit, size: 18),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 35,
          width: double.infinity,
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
      icon: SvgPicture.asset("bottom-navigation-icons/$iconName.svg"),
      label: '',
    );
  }
}
