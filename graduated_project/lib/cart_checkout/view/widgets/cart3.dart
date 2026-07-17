import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/home.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/products_view.dart';

class Cart3 extends StatelessWidget {
  const Cart3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 248, 247, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16.dg,
          children: [
            Image.asset("assets/SuccessIllustration.png"),
            Center(
              child: Text(
                "Order Placed Successfully!",
                style: GoogleFonts.inter(
                  fontSize: 20.dg,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(31, 41, 55, 1),
                ),
              ),
            ),
            Text(
              "Your order has been confirmed and is being processed. You will receive an email confirmation shortly.",
              style: GoogleFonts.inter(
                fontSize: 14.dg,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(107, 114, 128, 1),
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            Container(
              width: 215.dg,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.dg),
                color: Color.fromRGBO(234, 245, 241, 1),
                border: Border.all(
                  color: Color.fromRGBO(45, 159, 117, 0.1),
                  width: 1.dg,
                ),
              ),

              child: Center(
                child: Text(
                  "Order ID : SP-8829410",
                  style: GoogleFonts.inter(
                    color: Color(0xff2D9F75),
                    fontSize: 14.dg,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => Home(index: 2)));
              },
              child: Container(
                height: 56.dg,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.dg),
                  color: Color(0xff2D9F75),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 4.dg,
                      spreadRadius: -2,
                      offset: const Offset(0, 2),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 6.dg,
                      spreadRadius: -1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Orders History",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.dg,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => ProductsView()));
              },
              child: Container(
                height: 56.dg,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.dg),
                  border: Border.all(
                    color: Color.fromRGBO(229, 231, 235, 1),
                    width: 1.dg,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue Shopping",
                        style: GoogleFonts.inter(
                          color: Color.fromRGBO(55, 65, 81, 1),
                          fontSize: 16.dg,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
