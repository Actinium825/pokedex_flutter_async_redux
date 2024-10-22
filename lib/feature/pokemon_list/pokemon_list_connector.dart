import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter_async_redux/feature/pokemon_list/pokemon_list_page.dart';
import 'package:pokedex_flutter_async_redux/feature/pokemon_list/pokemon_list_vm.dart';
import 'package:pokedex_flutter_async_redux/state/app_state.dart';

class PokemonListConnector extends StatelessWidget {
  const PokemonListConnector({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PokemonListVm>(
      vm: PokemonListVmFactory.new,
      builder: (_, vm) => PokemonListPage(
        savedThemeMode: vm.savedThemeMode,
        onSetTheme: vm.onSetTheme,
      ),
    );
  }
}
