import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/auth/domain/entities/user.dart';
import 'package:food_app/features/auth/presentation/providers/auth_provider.dart';

import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileScreen extends ConsumerStatefulWidget {
  const MyProfileScreen({super.key});

  @override
  ConsumerState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends ConsumerState<MyProfileScreen> {
  int _currentIndex = 2;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  User currentUser = User(
    id: "-OPUxrBC0UHpf4kMnQMT",
    username: "test",
    email: "test@gmail.com",
    password: "test123",
    isAdmin: false,
  );

  bool isPasswordStrong(String password) {
    return RegExp(
            r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$%^&*()_\-=\[\]{};:\"\\|,.<>\/?]).{8,}$')
        .hasMatch(password);
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
              decoration: const BoxDecoration(
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
                    icon: const Icon(
                      size: 18,
                      Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 233, 83, 34),
                    ),
                  ),
                  Text(
                    "My Profile",
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 248, 248, 248),
                    ),
                  ),
                  const SizedBox(
                      width: 50), // You can remove this if not needed
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
                    Form(
                        key: _formKey1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 50,
                                child: Icon(Icons.person),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 60,
                                height: 30,
                                child: TextButton(
                                  onPressed: () {
                                    // Navigator.of(context).pop();
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
                                    'Edit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "User Name",
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            TextFormField(
                              minLines: 1,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Username cannot be empty';
                                }
                                return null;
                              },
                              onChanged: (value) => _username = value.trim(),
                              onSaved: (value) => _username = value!.trim(),
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintText: currentUser.username,
                                filled: true,
                                fillColor: const Color(0xFFFFF9C4),
                                contentPadding: const EdgeInsets.all(16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.orange),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Email",
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            TextFormField(
                              minLines: 1,
                              maxLines: null,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) => _email = value.trim(),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Email cannot be empty';
                                }
                                if (!RegExp(r'^\S+@\S+\.\S+$')
                                    .hasMatch(value.trim())) {
                                  return 'Enter a valid email';
                                }

                                return null;
                              },
                              onSaved: (value) => _email = value!.trim(),
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintText: currentUser.email,
                                filled: true,
                                fillColor: const Color(0xFFFFF9C4),
                                contentPadding: const EdgeInsets.all(16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.orange),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 150,
                                height: 30,
                                child: TextButton(
                                  onPressed: () async {
                                    if (_formKey1.currentState!.validate()) {
                                      _formKey1.currentState!.save();

                                      final message = await ref
                                          .watch(
                                              authUserNotifierProvider.notifier)
                                          .updateUserProfile(
                                              user: User(
                                                  id: "-OPUxrBC0UHpf4kMnQMT",
                                                  username: _username,
                                                  email: _email,
                                                  password: "test123",
                                                  isAdmin: false));
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Message'),
                                            content: Text(message),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
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
                                    'Update Profile',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        )),
                    const Divider(
                      color: Color.fromARGB(255, 243, 116, 31),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: _formKey2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Password",
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          TextFormField(
                            // obscureText: true,
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter current password'
                                : null,
                            onSaved: (value) =>
                                _currentPassword = value!.trim(),
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintText: "Enter Current Password",
                              filled: true,
                              fillColor: const Color(0xFFFFF9C4),
                              contentPadding: const EdgeInsets.all(16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Colors.orange),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "New Password",
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          TextFormField(
                            // obscureText: true,
                            validator: (value) {
                              if (value != null) {
                                _newPassword = value!.trim();
                              }
                              if (value == null || value.isEmpty) {
                                return 'Enter new password';
                              }
                              if (!isPasswordStrong(value)) {
                                return 'Password must be 8+ chars, include number, letter, special char';
                              }
                              return null;
                            },
                            onChanged: (value) => _newPassword = value.trim(),
                            onSaved: (value) => _newPassword = value!.trim(),
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintText: "Enter New Password",
                              filled: true,
                              fillColor: const Color(0xFFFFF9C4),
                              contentPadding: const EdgeInsets.all(16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Colors.orange),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Confirm Password",
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          TextFormField(
                            // obscureText: true,
                            validator: (value) {
                              if (value!.trim() != _newPassword) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            onChanged: (value) =>
                                _confirmPassword = value.trim(),
                            onSaved: (value) =>
                                _confirmPassword = value!.trim(),
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintText: "Re-Enter New Password",
                              filled: true,
                              fillColor: const Color(0xFFFFF9C4),
                              contentPadding: const EdgeInsets.all(16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Colors.orange),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 150,
                              height: 30,
                              child: TextButton(
                                onPressed: () async {
                                  if (_formKey2.currentState!.validate()) {
                                    _formKey2.currentState!.save();

                                    final message = await ref
                                        .watch(
                                            authUserNotifierProvider.notifier)
                                        .updateUserPassword(
                                            user: User(
                                                id: "-OPUxrBC0UHpf4kMnQMT",
                                                username: "test",
                                                email: "test@gmail.com",
                                                password: _confirmPassword,
                                                isAdmin: false));
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Message'),
                                          content: Text(message),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
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
                                  'Change Password',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12), // Round top-left corner
          topRight: Radius.circular(12), // Round top-right corner
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: const Color.fromARGB(255, 233, 83, 34),
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
}
