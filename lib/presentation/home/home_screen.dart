import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onjeki/presentation/auth/login_screen.dart';
import 'package:onjeki/presentation/explore/explore_screen.dart';
import 'package:onjeki/presentation/history/history_screen.dart';
import 'package:onjeki/presentation/inbox/inbox_screen.dart';
import 'package:onjeki/presentation/profile/profile_screen.dart';
import 'package:onjeki/presentation/wishlist/wishlist_screen.dart';
import 'package:onjeki/widgets/custom_bottom_bar.dart';

import '../../domain/providers/auth_providers.dart';
import '../../routes/app_routes.dart';
import '../auth/modal/login_modal.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  // Define the screens for each tab
  final List<Widget> _screens = const [
    ExploreScreen(),
    WishListScreen(),
    InboxScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  // Define the routes corresponding to the tabs
  // final List<String> _routes = [
  //   AppRoutes.exploreScreen,
  //   AppRoutes.wishlistScreen,
  //   AppRoutes.inboxScreen,
  //   AppRoutes.historyScreen,
  //   AppRoutes.profileScreen,
  // ];

  Future<void> _initializeAuth() async {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.initializeAuth();

    final authState = ref.read(authNotifierProvider);

    if (!authState.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Navigate to login screen if not authenticated
        // context.go('/login')
        showCupertinoModalBottomSheet(
          topRadius: const Radius.circular(30),
          expand: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => LoginModal(),
        );
        // context.go('/login_screen');
        // Navigator.of(context).pushReplacementNamed(AppRoutes.loginScreen);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // _initializeAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          setState(() {
            _currentIndex = type.index;
          });

          // Update URL if you're using deep linking
          // context.go(_routes[type.index]);
        },
      ),
    );
  }
}
