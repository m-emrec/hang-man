import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hang_man/Theme/theme_manager.dart';
import 'package:hang_man/logger.dart';
import 'package:provider/provider.dart';

import '../../Theme/theme.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(builder: (context, value, child) {
      bool isLight = value.isLight;

      return FlutterSwitch(
        value: isLight,
        activeIcon: const Icon(Icons.light_mode_outlined,
            color: AppColorsLight.canvasColor),
        inactiveIcon: const Icon(Icons.dark_mode_outlined,
            color: AppColorsLight.canvasColor),
        activeColor: AppColorsLight.buttonColor.withOpacity(0.5),
        inactiveColor: Colors.grey.shade800,
        inactiveToggleColor: Colors.grey.shade600,
        activeToggleColor: AppColorsLight.buttonColor.withOpacity(0.6),
        onToggle: (val) => setState(() {
          isLight = !isLight;
          value.changeTheme();
        }),
      );
    });
  }
}
