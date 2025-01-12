import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: _SharedAppBarHero(
      //   appbar: AppBar(
      //     leading: IconButton(
      //       onPressed: () => context.go('/'),
      //       icon: const Icon(Icons.close),
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Hello there!\n"
                "I'm your AI music assistant. "
                "Ready to create the perfect playlist for you. 😊",
                textAlign: TextAlign.center,
                // style: Theme.of(context).textTheme.headlineMediumBold,
              ),
              SizedBox(height: 64),
              // FilledButton(
              //   onPressed: () => context.go('/intro/genre'),
              //   style: _largeFilledButtonStyle,
              //   child: const Text('Continue'),
              // ),
              SizedBox(height: 16),
              // TextButton(
              //   onPressed: () => context.go('/'),
              //   style: _largeTextButtonStyle,
              //   child: const Text('No, thanks'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
