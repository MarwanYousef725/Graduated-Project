import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduated_project/Search%20&%20Discovery/models/product_model.dart';
import 'package:graduated_project/Search%20&%20Discovery/view/product_details.dart';
import 'package:graduated_project/Search%20&%20Discovery/widgets/build_add_button.dart';

class BuildProductCard extends StatelessWidget {
  final PharmacyProducts item;
  final BuildContext context;
  const BuildProductCard({
    super.key,
    required this.item,
    required this.context,
  });

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: item),
          ),
        );
      },
      child: GestureDetector(
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
          height: 120.dg,
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
                child: Image.network(
                  item.images![0],
                  width: 100.dg,
                  height: 100.dg,
                  cacheHeight: 100,
                  cacheWidth: 100,
                  loadingBuilder: (context, child, loadingProgress) {
                    return loadingProgress == null
                        ? child
                        : const Center(child: CircularProgressIndicator());
                  },

                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
                ),
              ),
              SizedBox(width: 12.dg),
              Expanded(
                child: Column(
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
                        Expanded(
                          flex: 5,
                          child: Text(
                            "\$${item.priceUsd}",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.dg,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: BuildAddButton(item: item)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
