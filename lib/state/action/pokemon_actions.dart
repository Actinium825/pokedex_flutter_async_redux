import 'package:async_redux/async_redux.dart';
import 'package:pokedex_flutter_async_redux/apis/api_service.dart';
import 'package:pokedex_flutter_async_redux/model/dto/pokemon_dto.dart';
import 'package:pokedex_flutter_async_redux/model/dto/simple_pokemon_dto.dart';
import 'package:pokedex_flutter_async_redux/state/action/actions.dart';
import 'package:pokedex_flutter_async_redux/state/app_state.dart';

/// Gets the pokemon list at the start to display
/// Gets the simple pokemon list first before getting each individual details
/// Clears the state's search result list for refreshing when searching
class InitPokemonListPageAction extends LoadingAction {
  InitPokemonListPageAction() : super(actionKey: waitKey);

  static const waitKey = 'init-pokemon-list-page';

  @override
  Future<AppState> reduce() async {
    await dispatchAndWait(GetSimplePokemonListAction());
    await dispatchAndWait(GetPokemonListAction(simplePokemonList: state.simplePokemonList.simplePokemonList));
    return state.copyWith(searchResultList: List.empty());
  }
}

/// Gets the simple pokemon list to be used for getting all individual pokemon details
/// Use the provided [nextPageUrl] if getting the next page's list
/// Clear the state's pokemon list if refreshing
class GetSimplePokemonListAction extends ReduxAction<AppState> {
  GetSimplePokemonListAction({this.nextPageUrl});

  final String? nextPageUrl;

  @override
  Future<AppState> reduce() async {
    final simplePokemonList = await ApiService.pokemonApi.getSimplePokemonList(nextPageUrl: nextPageUrl);
    return state.copyWith(
      simplePokemonList: simplePokemonList,
      pokemonList: nextPageUrl == null ? List.empty() : state.pokemonList,
    );
  }
}

/// Get all details of the provided [simplePokemonList]
/// Adds to the existing state's pokemon list
class GetPokemonListAction extends ReduxAction<AppState> {
  GetPokemonListAction({required this.simplePokemonList});

  final List<SimplePokemonDto> simplePokemonList;

  @override
  Future<AppState> reduce() async {
    final receivedPokemonList = await ApiService.pokemonApi.getPokemonList(simplePokemonList);
    final updatedPokemonList = [...state.pokemonList, ...receivedPokemonList];

    return state.copyWith(pokemonList: updatedPokemonList);
  }
}

/// Get more pokemon when reaching end of page
/// Avoid dispatching when already getting more
class GetMorePokemonAction extends LoadingAction {
  GetMorePokemonAction() : super(actionKey: waitKey);

  static const waitKey = 'get-more-pokemon';

  @override
  bool abortDispatch() => state.wait.isWaiting(waitKey);

  @override
  Future<AppState> reduce() async {
    await dispatchAndWait(GetSimplePokemonListAction(nextPageUrl: state.simplePokemonList.next));
    await dispatchAndWait(GetPokemonListAction(simplePokemonList: state.simplePokemonList.simplePokemonList));
    return state;
  }
}

/// Search a pokemon with the provided [searchText]
/// Avoid dispatching when already searching
class SearchPokemonAction extends LoadingAction {
  SearchPokemonAction({required this.searchText}) : super(actionKey: waitKey);

  static const waitKey = 'search-pokemon';

  final String searchText;

  @override
  bool abortDispatch() => state.wait.isWaiting(waitKey);

  @override
  Future<AppState> reduce() async {
    if (searchText.isEmpty) return state.copyWith(searchResultList: List.empty());

    final searchResultList = await ApiService.pokemonApi.searchPokemon(searchText.trim());

    return state.copyWith(searchResultList: searchResultList);
  }
}

/// Selects the provided [selectedPokemon] to be viewed on the pokemon info page
class SelectPokemonAction extends ReduxAction<AppState> {
  SelectPokemonAction({required this.selectedPokemon});

  final PokemonDto? selectedPokemon;

  @override
  AppState reduce() => state.copyWith(selectedPokemon: selectedPokemon);
}
