import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/providers/auth_providers.dart';
import '../../routes/app_routes.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  @override
  void initState() {
    super.initState();
    // _initializeAuth();
  }

  // Future<void> _initializeAuth() async {
  //   final authNotifier = ref.read(authNotifierProvider.notifier);
  //   await authNotifier.initializeAuth();

  //   final authState = ref.read(authNotifierProvider);

  //   if (!authState.isAuthenticated) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       context.go('login_screen');
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
        onPressed: () => context.go('/login'),
        child: const Text('Generate Playlist'),
      ),
      ),
    );
  }
}
