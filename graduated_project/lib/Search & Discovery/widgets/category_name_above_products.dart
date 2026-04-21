import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryNameAboveProducts extends StatelessWidget {
  final String categoryName;
  final String howToShow;
  final Function() onTapped;
  const CategoryNameAboveProducts({
    super.key,
    required this.categoryName,
    required this.howToShow,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            categoryName,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 18.dg,
              color: Color.fromRGBO(17, 24, 39, 1),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: onTapped,
            child: Text(
              howToShow,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 14.dg,
                color: Color.fromRGBO(45, 159, 117, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
