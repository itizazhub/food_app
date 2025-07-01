import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/features/addresses/presentation/screens/delivery_address.dart';
import 'package:food_app/features/carts/presentation/providers/cart_provider.dart';
import 'package:food_app/features/core/screens/splash_screen2.dart';
import 'package:food_app/features/orders/presentation/screens/my_orders_screen.dart';
import 'package:food_app/features/profile/presentation/screens/my_profile_screen.dart';

class ProfileDrawer extends ConsumerStatefulWidget {
  const ProfileDrawer({super.key});

  @override
  ConsumerState<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends ConsumerState<ProfileDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 40,
              child: Icon(Icons.person)),
          title: Text("User Name"),
          subtitle: Text("user@gmail.com"),
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.list_alt),
          title: Text("My Orders"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return MyOrdersScreen();
            }));
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("My Profile"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return MyProfileScreen();
            }));
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Delivery Address"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DeliveryAddress();
            }));
          },
        ),
        Spacer(),
        ListTile(
          leading: Icon(Icons.login_outlined),
          title: Text("Log Out"),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    height: 150,
                    child: Column(
                      children: [
                        const Text("Are you sure you want to log out?"),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 30,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  padding:
                                      EdgeInsets.zero, // no internal padding
                                  backgroundColor:
                                      Colors.orange, // filled background
                                  minimumSize:
                                      Size.zero, // prevent default min size
                                  tapTargetSize: MaterialTapTargetSize
                                      .shrinkWrap, // compact touch area
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        4), // optional rounding
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 100,
                              height: 30,
                              child: TextButton(
                                onPressed: () async {
                                  await ref
                                      .watch(cartNotifierProvider.notifier)
                                      .updateUserCart();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SplashScreen2()));
                                },
                                style: TextButton.styleFrom(
                                  padding:
                                      EdgeInsets.zero, // no internal padding
                                  backgroundColor:
                                      Colors.orange, // filled background
                                  minimumSize:
                                      Size.zero, // prevent default min size
                                  tapTargetSize: MaterialTapTargetSize
                                      .shrinkWrap, // compact touch area
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        4), // optional rounding
                                  ),
                                ),
                                child: const Text(
                                  'Yes, log out',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          },
        ),
      ],
    );
  }
}
