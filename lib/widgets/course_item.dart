// import 'package:flutter/material.dart';
//
// import '../core/domain/dtos/set_dto.dart';
// import '../core/navigation/routers.dart';
//
// class CourseItem extends StatelessWidget {
//   final SetDto item;
//
//   const CourseItem({super.key,  required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.7,
//       margin: EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: InkWell(
//         onTap: () {
//           AppRouter.router.navigateTo(context, "/coursepage");
//         },
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 item.name,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '${item.cardCount} thuật ngữ',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               SizedBox(height: 12),
//               Row(
//                 children: [
//                   Container(
//                     width: 32,
//                     height: 32,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Center(
//                       child: Text(
//                         '👤',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     '${item.description}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }