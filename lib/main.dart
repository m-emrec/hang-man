import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hang_man/Theme/theme.dart';
import 'package:hang_man/Theme/theme_manager.dart';
import 'package:hang_man/apis/random_word_api.dart';
import 'package:hang_man/provider/game_provider.dart';
import 'package:hang_man/provider/local_storage_provider.dart';
import 'package:hang_man/provider/screen_size.dart';
import 'package:provider/provider.dart';

import 'screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => Game(),
        ),
        ChangeNotifierProvider(
          create: (_) => WordProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScreenSize(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocalStorage(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Provider.of<ThemeManager>(context).getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ThemeManager>(context, listen: false).getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: Provider.of<ThemeManager>(context).themeMode,
      home: const HomePage(),
    );
  }
}
