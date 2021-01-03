// import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:grocery_manager/widgets/auth/register_page.dart';
// import 'package:grocery_manager/widgets/auth/signin_page.dart';
//
// /// Provides a UI to select a authentication type page
// class AuthTypeSelector extends StatelessWidget {
//   // Navigates to a new page
//   void _pushPage(BuildContext context, Widget page) {
//     Navigator.of(context).push(
//       MaterialPageRoute<void>(builder: (_) => page),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Firebase Example App"),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             child: SignInButtonBuilder(
//               icon: Icons.person_add,
//               backgroundColor: Colors.indigo,
//               text: 'Registration',
//               onPressed: () => _pushPage(context, RegisterPage()),
//             ),
//             padding: const EdgeInsets.all(16),
//             alignment: Alignment.center,
//           ),
//           Container(
//             child: SignInButtonBuilder(
//               icon: Icons.verified_user,
//               backgroundColor: Colors.orange,
//               text: 'Sign In',
//               onPressed: () => _pushPage(context, SignInPage()),
//             ),
//             padding: const EdgeInsets.all(16),
//             alignment: Alignment.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
