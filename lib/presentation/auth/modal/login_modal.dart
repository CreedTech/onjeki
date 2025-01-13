import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onjeki/core/utils/image_constant.dart';
import 'package:onjeki/theme/theme_helper.dart';
import 'package:onjeki/widgets/custom_button.dart';
import 'package:onjeki/widgets/custom_image_view.dart';
import 'package:onjeki/widgets/custom_text_field_widget.dart';

import '../../../domain/providers/auth_providers.dart';

class LoginModal extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();

  LoginModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);
    return Material(
        child: Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (childContext) => Builder(
          builder: (childContext2) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                backgroundColor: colorWhite,
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10, horizontal: 20),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close_outlined,
                    size: 20,
                  ),
                ),
                middle: const Text(
                  'Login or Sign up',
                  style: TextStyle(color: colorsBlack, fontSize: 16),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: SafeArea(
                bottom: false,
                child: ListView(
                  shrinkWrap: true,
                  controller: ModalScrollController.of(childContext2),
                  children: [
                    CustomTextFormField(
                      controller: _emailController,
                      hintText: 'Enter your mail',
                      // borderDecoration: ,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      // isDisabled: true,
                  onPressed: authState.isLoading
                  ? null
                  : () async {
                      await authNotifier.login(
                        _emailController.text.trim()
                      );

                      if (authState.isAuthenticated) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else if (authState.errorMessage != null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content: Text(authState.errorMessage!),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                      text: 'Continue',
                      buttonStyle: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: colorPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            55,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        // Left Divider
                        Expanded(
                          child: Divider(
                            thickness: 1, // Thickness of the line
                            color: Colors.grey, // Color of the line
                          ),
                        ),
                        // The "or" Text
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0), // Space around the text
                          child: Text(
                            "or",
                            style: TextStyle(
                              fontSize: 16, // Font size for the text
                              color: Colors.grey, // Color of the text
                            ),
                          ),
                        ),
                        // Right Divider
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      // isDisabled: false,
                      leftIcon: const Padding(
                        padding: EdgeInsets.only(right: 3),
                        child: Icon(
                          Icons.apple_outlined,
                          size: 24,
                          color: colorsBlack,
                        ),
                      ),
                      buttonTextStyle: const TextStyle(
                        color: colorsBlack,
                        fontSize: 18,
                      ),
                      onPressed: () {},
                      text: 'Continue with Apple',
                      buttonStyle: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: colorsBlack, width: 1),
                          borderRadius: BorderRadius.circular(
                            55,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      // isDisabled: false,
                      leftIcon: Padding(
                        padding: const EdgeInsets.only(right: 3),
                        child: CustomImageView(
                          height: 24,
                          width: 24,
                          imagePath: ImageConstant.googleIcon,
                        ),
                      ),
                      buttonTextStyle: const TextStyle(
                        color: colorsBlack,
                        fontSize: 18,
                      ),
                      onPressed: () {},
                      text: 'Continue with Google',
                      buttonStyle: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: colorsBlack, width: 1),
                          borderRadius: BorderRadius.circular(
                            55,
                          ),
                        ),
                      ),
                    ),
                  ],
                  // ListTile.divideTiles(
                  //   context: childContext2,
                  //   tiles: List.generate(
                  //       100,
                  //       (index) => ListTile(
                  //             title: const Text('Item'),
                  //             onTap: () {
                  //               Navigator.of(childContext2).push(
                  //                 MaterialPageRoute(
                  //                   builder: (context) => CupertinoPageScaffold(
                  //                     navigationBar: const CupertinoNavigationBar(
                  //                       middle: Text('New Page'),
                  //                     ),
                  //                     child: Stack(
                  //                       fit: StackFit.expand,
                  //                       children: <Widget>[
                  //                         MaterialButton(
                  //                           onPressed: () =>
                  //                               Navigator.of(context).pop(),
                  //                           child: const Text('touch here'),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //               );
                  //             },
                  //           )),
                  // ).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
