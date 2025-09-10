import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'collected_pokemon.g.dart';

@HiveType(typeId: 2)
class CollectedPokemon {
  @HiveField(0)
  final int id;

  @HiveField(1)
  bool isCaptured;

  @HiveField(2)
  bool? isShiny;

  Pokemon? pokemon;

  CollectedPokemon({
    required this.id,
    this.isCaptured = false,
    this.isShiny = false,
  });

  CollectedPokemon._({
    required this.id,
    required this.isCaptured,
    this.isShiny,
    this.pokemon,
  });

  CollectedPokemon copyWith({
    int? id,
    bool? isCaptured,
    bool? isShiny,
    Pokemon? pokemon,
  }) {
    return CollectedPokemon._(
      id: id ?? this.id,
      isCaptured: isCaptured ?? this.isCaptured,
      isShiny: isShiny ?? this.isShiny,
      pokemon: pokemon ?? this.pokemon,
    );
  }

  @override
  String toString() =>
      'CollectedPokemon - id: $id, name: ${pokemon?.name}, isCaptured: $isCaptured, isShiny: $isShiny';
}
