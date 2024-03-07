import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login your account",
              style: GoogleFonts.getFont(
                'Lato',
                color: const Color(0xFF0d120E),
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
                fontSize: 23,
              ),
            ),
            Text(
              "To explore the world exclusives",
              style: GoogleFonts.getFont(
                'Lato',
                color: const Color(0xFF0d120E),
                fontSize: 14,
                letterSpacing: 0.2,
              ),
            ),
            Image.asset(
              'lib/assets/images/Illustration.png',
              width: 200,
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
