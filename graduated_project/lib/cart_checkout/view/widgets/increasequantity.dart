// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// class Increasequantity extends StatelessWidget {
//   const Increasequantity({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//               width: 100,
//               height: 31,
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 255, 255, 255),
//                 borderRadius: BorderRadius.circular(6),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                     spreadRadius: 0,
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     InkWell(
//                       onTap: () {
                      
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(6.0),
//                         child: Icon(Icons.remove, color: Color(0xffF55540)),
//                       ),
//                     ),
                    
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 2),
//                       child: Text(
//                           '1',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                     ),
                
//                     InkWell(
//                       onTap: () {
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(6.0),
//                         child: Icon(Icons.add, color: Color(0xffF55540)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//   }
// }