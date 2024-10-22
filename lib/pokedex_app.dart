import 'package:flutter/material.dart';
import 'package:pokedex_flutter_async_redux/utils/router.dart';
import 'package:pokedex_flutter_async_redux/utils/themes.dart';

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: PokedexTheme.themeRegular,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
