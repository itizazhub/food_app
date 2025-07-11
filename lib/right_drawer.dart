import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/features/addresses/presentation/screens/delivery_address.dart';
import 'package:food_app/features/orders/presentation/screens/my_orders_screen.dart';
import 'package:food_app/features/profile/presentation/screens/my_profile_screen.dart';

class RightDrawer extends StatefulWidget {
  const RightDrawer({super.key});

  @override
  State<RightDrawer> createState() => _RightDrawerState();
}

class _RightDrawerState extends State<RightDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
          onPressed: () {
            showRightDrawer(context: context, child: cartDrawer());
          },
          child: Text("click me")),
    );
  }

  void showRightDrawer({
    required BuildContext context,
    required Widget child,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'RightDrawer',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          width: MediaQuery.of(context).size.width * 0.75,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Material(
            color: Colors.amber,
            child: child,
          ),
        ),
      ),
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        );
      },
    );
  }

  Widget cartDrawer() {
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
                                child: Text(
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
                                onPressed: () {
                                  // your logic
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
                                child: Text(
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


// SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: TextButton(
//                         onPressed: () {
//                           // your logic
//                         },
//                         style: TextButton.styleFrom(
//                           padding: EdgeInsets.zero, // no internal padding
//                           backgroundColor: Colors.orange, // filled background
//                           minimumSize: Size.zero, // prevent default min size
//                           tapTargetSize: MaterialTapTargetSize
//                               .shrinkWrap, // compact touch area
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(4), // optional rounding
//                           ),
//                         ),
//                         child: Text(
//                           'Go',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),