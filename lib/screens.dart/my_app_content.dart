import 'package:flutter/material.dart';

import 'age_selection.dart';
import 'home.dart';

class MyAppContent extends StatelessWidget {
  final bool isFirstLaunch;

  const MyAppContent({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isFirstLaunch ? '/age_selection' : '/home',
      routes: {
        '/age_selection': (context) => const AgeSelection(),
        '/home': (context) => const Home(),
      },
    );
  }
}
