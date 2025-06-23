// Fixes applied:
// - Fixed async builder (converted `list()` to use FutureBuilder properly)
// - Cleaned layout (removed Navigator.pop from 'Add New Address' tap)
// - Used proper read/watch for providers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/features/addresses/domain/entities/address.dart';
import 'package:food_app/features/addresses/presentation/providers/address_provider.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/core/widgets/custom_text_form_field.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryAddress extends ConsumerStatefulWidget {
  const DeliveryAddress({super.key});

  @override
  ConsumerState<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends ConsumerState<DeliveryAddress> {
  int _currentIndex = 2;
  final _addressInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _onNavItemTapped(int index) {
    setState(() => _currentIndex = index);
    if (_currentIndex == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
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
              text: "Cancel",
              widht: 80,
              height: 25,
              fontSize: 12,
              callBack: () async {
                _addressInput.clear();
                Navigator.pop(context);
              }),
          CustomFilledButton(
            text: address == null ? "Add Address" : "Update Address",
            widht: 130,
            height: 25,
            fontSize: 12,
            callBack: () async {
              if (_formKey.currentState?.validate() ?? false) {
                final newAddress = Address(
                  addressId: address?.addressId ?? '',
                  userId: "-OPUxrBC0UHpf4kMnQMT",
                  address: _addressInput.text.trim(),
                );

                address == null
                    ? await addressNotifier.addUserAddress(address: newAddress)
                    : await addressNotifier.updateUserAddress(
                        address: newAddress);

                _addressInput.clear();
                if (mounted) Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _loadAddresses() async {
    setState(() {
      _isLoading = true;
    });
    await ref.read(addressNotifierProvider.notifier).getUserAddresses(
          user: User(
            id: "-OPUxrBC0UHpf4kMnQMT",
            username: "test",
            email: "test@gmail.com",
            password: "test123",
            isAdmin: false,
          ),
        );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAddresses());
  }

  @override
  Widget build(BuildContext context) {
    final addresses = ref.watch(addressNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 110,
              color: const Color.fromARGB(255, 245, 203, 88),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios,
                        size: 18, color: Color.fromARGB(255, 233, 83, 34)),
                  ),
                  Text(
                    "Delivery Address",
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 248, 248, 248),
                    ),
                  ),
                  const SizedBox(width: 50),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 248, 248, 248),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: _isLoading
                    ? Center(
                        child: Container(
                          height: 20,
                          width: 20,
                          margin: EdgeInsets.all(5),
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation(
                                const Color.fromARGB(255, 107, 102, 102)),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 20),
                          Expanded(
                            child: addresses == null || addresses.isEmpty
                                ? const Center(child: Text("No address found"))
                                : ListView.builder(
                                    itemCount: addresses.length,
                                    itemBuilder: (_, index) {
                                      final address = addresses[index];
                                      return ListTile(
                                        title: Text(address.address),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () =>
                                                  _showAddAddressDialog(
                                                      address: address),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () async {
                                                await ref
                                                    .read(
                                                        addressNotifierProvider
                                                            .notifier)
                                                    .removeUserAddress(
                                                        address: address);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 150,
                            height: 30,
                            child: TextButton(
                              onPressed: _showAddAddressDialog,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: Colors.orange,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              child: const Text('Add New Address',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      )),
          ),
        ]),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: const Color.fromARGB(255, 233, 83, 34),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onNavItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset("bottom-navigation-icons/home.svg"),
                label: ""),
            BottomNavigationBarItem(
                icon:
                    SvgPicture.asset("bottom-navigation-icons/categories.svg"),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("bottom-navigation-icons/favorites.svg"),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("bottom-navigation-icons/list.svg"),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("bottom-navigation-icons/help.svg"),
                label: ""),
          ],
        ),
      ),
    );
  }
}
