import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_flutter_async_redux/apis/model/pokemon_info.dart';

part 'pokemon_move.freezed.dart';
part 'pokemon_move.g.dart';

@freezed
class PokemonMove with _$PokemonMove {
  const factory PokemonMove({
    @JsonKey(name: 'move') PokemonInfo? moveInfo,
  }) = _PokemonMove;

  factory PokemonMove.fromJson(Map<String, dynamic> json) => _$PokemonMoveFromJson(json);
}