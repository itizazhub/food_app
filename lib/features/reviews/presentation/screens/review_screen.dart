import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/features/core/widgets/custom_filled_button.dart';
import 'package:food_app/features/home/presentation/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  int _currentIndex = 3;

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
    // Handle other indices as needed
  }

  List<bool> starStates = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Top section (AppBar style)
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
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        size: 18,
                        Icons.arrow_back_ios,
                        color: Color.fromARGB(255, 233, 83, 34),
                      ),
                    ),
                    Text(
                      "Leave a Review",
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

            // Main content area
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 248, 248, 248),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "dessert-images/1.jpg",
                          width: 160,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Product Name",
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 20, 19, 19),
                        ),
                      ),
                      Text(
                        "We'd love to know what you think of your dish",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 20, 19, 19),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Leave us your comment!",
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 20, 19, 19),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // ⭐ Stars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          starStates.length,
                          (index) => IconButton(
                            icon: Icon(
                              Icons.star,
                              color: starStates[index]
                                  ? Colors.orange
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                for (int i = 0; i < starStates.length; i++) {
                                  starStates[i] = i <= index;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // ✍️ Text Field
                      Form(
                        child: TextFormField(
                          minLines: 6,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: "Write review...",
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
                      ),
                      const SizedBox(height: 20),

                      // 🟠 Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomFilledButton(
                            widht: 120,
                            height: 30,
                            fontSize: 20,
                            text: "Cancel",
                            callBack: () async {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: 20),
                          CustomFilledButton(
                            widht: 120,
                            height: 30,
                            fontSize: 20,
                            text: "Submit",
                            callBack: () async {
                              // Add review submission logic here
                            },
                          ),
                        ],
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
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
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
              icon: SvgPicture.asset("bottom-navigation-icons/home.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("bottom-navigation-icons/categories.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("bottom-navigation-icons/favorites.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("bottom-navigation-icons/list.svg"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("bottom-navigation-icons/help.svg"),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
