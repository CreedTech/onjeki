import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:onjeki/domain/providers/auth_providers.dart';
import 'package:onjeki/presentation/auth/login_screen.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

import 'core/utils/navigator_service.dart';
import 'core/utils/size_utils.dart';
import 'domain/states/auth_state.dart';
import 'presentation/home/home_screen.dart';
import 'routes/app_routes.dart';
import 'theme/theme_helper.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          title: 'OnJeki',
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: AppRoutes().router,
          
          // initialRoute: AppRoutes.initialRoute,
          // navigatorKey: NavigatorService.navigatorKey,
          // getPages: AppRoutes.routes,
          // initialRoute: '/',
          // navigatorKey: NavigatorService.navigatorKey,
          // getPages: [
          //   GetPage(name: '/', page: () => const MyAppWrapper()),
          //   GetPage(name: '/login', page: () => const LoginScreen()),
          //   GetPage(name: '/home', page: () => const HomeScreen()),
          // ],
        );
      },
    );
  }
}

class MyAppWrapper extends ConsumerStatefulWidget {
  const MyAppWrapper({super.key});

  @override
  ConsumerState<MyAppWrapper> createState() => _MyAppWrapperState();
}

class _MyAppWrapperState extends ConsumerState<MyAppWrapper> {
  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.initializeAuth();

    final authState = ref.read(authNotifierProvider);

    // Use contextless navigation to switch screens
    if (authState.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home_screen'); // Navigate to HomeScreen
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
       context.go('/home_screen');
// Navigate to LoginScreen
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // While authentication initializes, show loading indicator
    return const Center(child: CircularProgressIndicator());
  }
}
