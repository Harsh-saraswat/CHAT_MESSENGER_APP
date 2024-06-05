import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Welcome",
                style: GoogleFonts.bebasNeue(
                    textStyle: TextStyle(
                        height: 1, color: Colors.black, fontSize: 90)),
              ),
            ),
            Text(
              "Back",
              style: GoogleFonts.bebasNeue(
                  textStyle: TextStyle(color: Colors.black, fontSize: 70)),
            ),
          ],
        ),
      ),
    );
  }
}
