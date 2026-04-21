import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

OutlineInputBorder outlineBorder() => OutlineInputBorder(
  borderRadius: BorderRadius.circular(12.dg),
  borderSide: const BorderSide(color: Color.fromRGBO(243, 244, 246, 1)),
);

Widget buildIcon(String path) => Container(
  padding: const EdgeInsets.all(12),
  child: Image.asset(path, width: 12.dg, height: 12.dg),
);
