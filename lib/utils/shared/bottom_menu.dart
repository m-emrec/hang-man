import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hang_man/Theme/theme.dart';
import 'package:hang_man/extensions/context_extension.dart';
import 'package:hang_man/extensions/img_extension.dart';
import 'package:hang_man/extensions/text_extension.dart';
import 'package:hang_man/logger.dart';

import '../BottomMenu/theme_switch.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    /// Check the platform and return a platform specific BottomSheet.
    return context.theme.platform == TargetPlatform.android

        /// Android
        ? const AndroidBottomMenu()

        /// IOS
        : const IosBottomMenu();
  }

  Widget body() {
    return const BottomMenuBody();
  }
}

class IosBottomMenu extends BottomMenu {
  const IosBottomMenu({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      cancelButton: TextButton(
        style: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(
            Colors.red,
          ),
        ),
        child: const Text("Cancel"),
        onPressed: () => context.pop(),
      ),
      actions: [
        Material(
          color: Colors.transparent,
          child: body(),
        )
      ],
    );
  }
}

class AndroidBottomMenu extends BottomMenu {
  const AndroidBottomMenu({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      showDragHandle: true,
      enableDrag: false,
      backgroundColor: AppColorsLight.canvasColor,
      onClosing: () {
        logger.i("message");
      },
      builder: (_) {
        return body();
      },
    );
  }
}

class BottomMenuBody extends StatelessWidget {
  const BottomMenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = context.width;
    final double h = context.height;
    return SizedBox(
      width: w,
      // height: h * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ////            Title
            Text(
              "Settings",
              style: context.textTheme.titleLarge,
            ),
            const Divider(),

            /// Theme
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Theme").labelLarge(context),
                const ThemeSwitch(),
              ],
            ),

            /// Text Size
          ],
        ),
      ),
    );
  }
}
