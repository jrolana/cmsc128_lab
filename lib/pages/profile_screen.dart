import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import '../utils/styles.dart';
import 'package:cmsc128_lab/pages/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: StyleColor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.lexendDeca().fontFamily),
            title: const Text(
              "Your Profile",
            ),
            leading: IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              icon: const Icon(IconlyBold.arrow_left),
              onPressed: () {
                print("Pressed back");
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Avatar Section
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue[900],
                    child: const Icon(
                      Icons.pets, // Rabbit icon placeholder
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "User Nickname",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.lexendDeca().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Joined last MM/DD/YYYY",
                    style: TextStyle(
                      fontSize: 14,
                      color: StyleColor.secondary,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.lexendDeca().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Profile Details Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profile Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.lexendDeca().fontFamily,
                            color: StyleColor.secondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Nickname",
                          style: TextStyle(
                            fontSize: 14,
                            color: StyleColor.primaryText,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.lexendDeca().fontFamily,),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: "My nickname",
                            hintStyle: TextStyle(
                            fontFamily: GoogleFonts.lexendDeca().fontFamily,
                            fontSize: 16,
                            color: StyleColor.primaryText,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 14, 
                            color: StyleColor.primaryText,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.lexendDeca().fontFamily,),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: "My email",
                            hintStyle: TextStyle(
                            fontFamily: GoogleFonts.lexendDeca().fontFamily,
                            fontSize: 16,
                            color: StyleColor.primaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Sign Out Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(), // Replace with your LogInScreen widget
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                              'You are signed out.')));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: StyleColor.primary, // Background color
                      padding: const EdgeInsets.symmetric(
                        horizontal: 26.0,
                        vertical: 15.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded edges
                      ),
                    ),
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.lexendDeca().fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}