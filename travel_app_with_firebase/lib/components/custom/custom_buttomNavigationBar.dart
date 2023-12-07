// import 'package:flutter/material.dart';
// import 'package:travel_guide_app/components/custom/custom_search.dart';

// class CustomButtomAppBar extends StatelessWidget {
//   const CustomButtomAppBar({
//     super.key,
//     required this.onPressed,
//   });

//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       elevation: 0,
//       color: Colors.white,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             onPressed: () {
//               Scrollable.ensureVisible(CustomSearch.searchKey.currentContext!);
//             },
//             icon: const Icon(
//               Icons.search,
//               color: Colors.black,
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               print('favorite clicked');
//             },
//             icon: const Icon(
//               Icons.favorite,
//               color: Colors.black,
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               print('Profile button tap');
//             },
//             icon: const Icon(
//               Icons.person,
//               color: Colors.black,
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               print('Setting button tap');
//             },
//             icon: const Icon(
//               Icons.settings,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
