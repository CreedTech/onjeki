import 'dart:async';

import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:onjeki/main.dart';
import 'package:onjeki/presentation/explore/explore_screen.dart';
import 'package:onjeki/presentation/history/history_screen.dart';
import 'package:onjeki/presentation/home/home_screen.dart';
import 'package:onjeki/presentation/inbox/inbox_screen.dart';
import 'package:onjeki/presentation/profile/profile_screen.dart';
import 'package:onjeki/presentation/wishlist/wishlist_screen.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

import '../presentation/auth/login_screen.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String homeScreen = '/home_screen';
  static const String exploreScreen = '/explore_screen';
  static const String wishlistScreen = '/wishlist_screen';
  static const String inboxScreen = '/inbox_screen';
  static const String historyScreen = '/history_screen';
  static const String profileScreen = '/profile_screen';
  static const String loginScreen = '/login_screen';


  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutes.initialRoute,
        builder: (context, state) =>
            const MyAppWrapper(), // Regular homepage route
        // routes: [_sheetShellRoute],
      ),
      GoRoute(
        path: '/home_screen',
        name: AppRoutes.homeScreen,
        builder: (context, state) =>
            const HomeScreen(), // Regular homepage route
        // routes: [_loginRoute],
      ),
      GoRoute(
        path: '/explore_screen',
        name: AppRoutes.exploreScreen,
        builder: (context, state) =>
            const ExploreScreen(), // Regular homepage route
      ),
      GoRoute(
        path: '/wishlist_screen',
        name: AppRoutes.wishlistScreen,
        builder: (context, state) =>
            const WishListScreen(), // Regular homepage route
      ),
      GoRoute(
        path: '/inbox_screen',
        name: AppRoutes.inboxScreen,
        builder: (context, state) =>
            const InboxScreen(), // Regular homepage route
      ),
      GoRoute(
        path: '/history_screen',
        name: AppRoutes.historyScreen,
        builder: (context, state) =>
            const HistoryScreen(), // Regular homepage route
      ),
      GoRoute(
        path: '/profile_screen',
        name: AppRoutes.profileScreen,
        builder: (context, state) =>
            const ProfileScreen(), // Regular homepage route
      ),
      GoRoute(
        path: '/login_screen',
        name: AppRoutes.loginScreen,
        builder: (context, state) =>
            const LoginScreen(), // Regular homepage route
      ),
    ],
  );
}

// final _loginRoute = GoRoute(
//   path: 'login_screen',
//   name: AppRoutes.loginScreen,
//   pageBuilder: (context, state) {
//     // Modal sheet for the login page
//     return const DraggableNavigationSheetPage(
//       child: LoginScreen(),
//     );
//   },
// );

// final sheetTransitionObserver = NavigationSheetTransitionObserver();
// final _sheetShellRoute = ShellRoute(
//   observers: [sheetTransitionObserver],
//   pageBuilder: (context, state, navigator) {
//     // Use ModalSheetPage to show a modal sheet.
//     return ModalSheetPage(
//       swipeDismissible: true,
//       child: _SheetShell(
//         navigator: navigator,
//         transitionObserver: sheetTransitionObserver,
//       ),
//     );
//   },
//   routes: [
//     GoRoute(
//       path: 'login',
//       pageBuilder: (context, state) {
//         return const DraggableNavigationSheetPage(
//           child: LoginScreen(),
//         );
//       },
//     ),
//   ],
// );

// class _SheetShell extends StatelessWidget {
//   const _SheetShell({
//     required this.transitionObserver,
//     required this.navigator,
//   });

//   final NavigationSheetTransitionObserver transitionObserver;
//   final Widget navigator;

//   @override
//   Widget build(BuildContext context) {
//     Future<bool?> showCancelDialog() {
//       return showDialog<bool?>(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Are you sure?'),
//             content:
//                 const Text('Do you want to cancel the playlist generation?'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, true),
//                 child: const Text('Yes'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, false),
//                 child: const Text('No'),
//               ),
//             ],
//           );
//         },
//       );
//     }

//     return SafeArea(
//       bottom: false,
//       child: PopScope(
//         canPop: false,
//         onPopInvoked: (didPop) async {
//           if (!didPop) {
//             final shouldPop = await showCancelDialog() ?? false;
//             if (shouldPop && context.mounted) {
//               context.go('/');
//             }
//           }
//         },
//         child: Text('yo'),
//         // child: NavigationSheet(
//         //   transitionObserver: sheetTransitionObserver,
//         //   child: Material(
//         //     // Add circular corners to the sheet.
//         //     borderRadius: BorderRadius.circular(16),
//         //     clipBehavior: Clip.antiAlias,
//         //     color: Theme.of(context).colorScheme.surface,
//         //     child: navigator,
//         //   ),
//         // ),
//       ),
//     );
//   }
// }
