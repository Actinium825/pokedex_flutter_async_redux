import 'package:flutter/material.dart';
import 'package:pokedex_flutter_async_redux/utils/extension.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokedex',
          style: context.themeData.textTheme.displayMedium,
        ),
      ),
    );
  }
}
