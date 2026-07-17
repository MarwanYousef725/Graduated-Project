import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/product_details.dart';
// import 'package:graduated_project/Search%20&%20Discovery/widgets/build_add_button.dart';
import 'package:graduated_project/cart_checkout/view/widgets/build_add_to_cart.dart';

class BuildProductCard extends StatelessWidget {
  final PharmacyProducts item;
  final BuildContext context;
  const BuildProductCard({
    super.key,
    required this.item,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final productImages = item.images;
    final fallbackImage = (productImages != null && productImages.isNotEmpty)
        ? productImages[0]
        : '';
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: item),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.dg),
        padding: EdgeInsets.all(12.dg),
        // height: 120.dg,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.dg),
          border: Border.all(color: const Color.fromRGBO(243, 244, 246, 1)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.dg),
              child: CachedNetworkImage(
                imageUrl: fallbackImage,
                width: 80.dg,
                height: 80.dg,
                fit: BoxFit.cover,
                errorWidget: (context, error, stackTrace) {
                  return Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image_rounded,
                      color: Colors.red,
                      size: 32.dg,
                    ),
                  );
                },
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(5, 150, 105, 1),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.dg),
            Expanded(
              child: Column(
                spacing: 8.dg,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.category.toString().toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 10.dg,
                      color: const Color(0xFF2D9F75),
                    ),
                  ),
                  Text(
                    item.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.dg,
                    ),
                  ),
                  Text(
                    item.description ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.dg,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${item.priceUsd ?? 0.0}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.dg,
                          color: Colors.black,
                        ),
                      ),
                      BuildAddToCart(item: item),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
