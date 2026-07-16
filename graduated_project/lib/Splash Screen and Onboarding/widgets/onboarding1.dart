import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 60.0,
            left: 40.0,
            right: 40.0,
            bottom: 60.0,
          ),
          child: Image.asset("assets/images/Background.png"),
        ),
        Text(
          "Find Your Medicine",
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(17, 24, 39, 1),
            letterSpacing: -.75,
          ),
        ),
        SizedBox(height: 16.dg),
        SizedBox(
          child: Text(
            textAlign: TextAlign.center,
            """Search and discover high-quality
healthcare products and medicines from
trusted local pharmacies at your
fingertips.""",
            style: GoogleFonts.inter(
              fontSize: 16.dg,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(107, 114, 128, 1),
              letterSpacing: -.75,
            ),
          ),
        ),
      ],
    );
  }
}
