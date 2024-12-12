import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:cmsc128_lab/pages/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String nickname = "User Nickname";
  String email = "My email";
  String joinedDate = "MM/DD/YYYY";

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data on screen initialization
  }

  Future<void> fetchUserData() async {
    try {
      // Get the current logged-in user
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Debug: Print the UID of the current user
        print("Current User UID: ${currentUser.uid}");

        // Fetch the user's document based on their UID
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            nickname = userDoc['nickname'] ?? "User Nickname";
            email = userDoc['email'] ?? "My email";
            Timestamp timestamp = userDoc['signupDate'] ?? Timestamp.now();
            DateTime date = timestamp.toDate();
            joinedDate = "${date.month}/${date.day}/${date.year}";
          });
        } else {
          print("User document not found!");
        }
      } else {
        print("No user is logged in!");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }



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
            title: const Text("Your Profile"),
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
                    backgroundColor: StyleColor.primary,
                    child: const Icon(
                      Icons.pets, // Rabbit icon placeholder
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    nickname, // Display fetched nickname
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.lexendDeca().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Joined last $joinedDate", // Display fetched date
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
                      border: Border.all(color: StyleColor.secondary),
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
                            color: StyleColor.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Nickname",
                          style: TextStyle(
                            fontSize: 14,
                            color: StyleColor.secondary,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.lexendDeca().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          nickname, // Display fetched nickname
                          style: TextStyle(
                            fontSize: 16,
                            color: StyleColor.primaryText,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 14,
                            color: StyleColor.secondary,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.lexendDeca().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          email, // Display fetched email
                          style: TextStyle(
                            fontSize: 16,
                            color: StyleColor.primaryText,
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
                          builder: (context) => const WelcomeScreen(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('You are signed out.')));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: StyleColor.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 26.0,
                        vertical: 15.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
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
