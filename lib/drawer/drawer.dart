import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/utils/rout.dart';
// import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class CustomeDrawer extends StatelessWidget {
  const CustomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: Text("Sign Out"),
            leading: Icon(Icons.output_outlined),
            onTap: () async {
              FirebaseAuth.instance.currentUser ??
                  await FirebaseAuth.instance.signOut().then((value) =>
                      GoRouter.of(context).push(Routes.kSigninScreen));
            },
          )
        ],
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// // }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final _advancedDrawerController = AdvancedDrawerController();

//   @override
//   Widget build(BuildContext context) {
//     return AdvancedDrawer(
//       backdrop: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
//           ),
//         ),
//       ),
//       controller: _advancedDrawerController,
//       animationCurve: Curves.easeInOut,
//       animationDuration: const Duration(milliseconds: 300),
//       animateChildDecoration: true,
//       rtlOpening: false,
//       // openScale: 1.0,
//       disabledGestures: false,
//       childDecoration: const BoxDecoration(
//         // NOTICE: Uncomment if you want to add shadow behind the page.
//         // Keep in mind that it may cause animation jerks.
//         // boxShadow: <BoxShadow>[
//         //   BoxShadow(
//         //     color: Colors.black12,
//         //     blurRadius: 0.0,
//         //   ),
//         // ],
//         borderRadius: const BorderRadius.all(Radius.circular(16)),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Advanced Drawer Example'),
//           leading: IconButton(
//             onPressed: _handleMenuButtonPressed,
//             icon: ValueListenableBuilder<AdvancedDrawerValue>(
//               valueListenable: _advancedDrawerController,
//               builder: (_, value, __) {
//                 return AnimatedSwitcher(
//                   duration: Duration(milliseconds: 250),
//                   child: Icon(
//                     value.visible ? Icons.clear : Icons.menu,
//                     key: ValueKey<bool>(value.visible),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         body: Container(),
//       ),
//       drawer: SafeArea(
//         child: Container(
//           child: ListTileTheme(
//             textColor: Colors.white,
//             iconColor: Colors.white,
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Container(
//                   width: 128.0,
//                   height: 128.0,
//                   margin: const EdgeInsets.only(
//                     top: 24.0,
//                     bottom: 64.0,
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     color: Colors.black26,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Image.asset(
//                     'assets/images/flutter_logo.png',
//                   ),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: Icon(Icons.home),
//                   title: Text('Home'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: Icon(Icons.account_circle_rounded),
//                   title: Text('Profile'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: Icon(Icons.favorite),
//                   title: Text('Favourites'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: Icon(Icons.settings),
//                   title: Text('Settings'),
//                 ),
//                 Spacer(),
//                 DefaultTextStyle(
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.white54,
//                   ),
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                       vertical: 16.0,
//                     ),
//                     child: Text('Terms of Service | Privacy Policy'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _handleMenuButtonPressed() {
//     // NOTICE: Manage Advanced Drawer state through the Controller.
//     // _advancedDrawerController.value = AdvancedDrawerValue.visible();
//     _advancedDrawerController.showDrawer();
//   }
// }
