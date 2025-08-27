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

  @override
  String toString() =>
      'CollectedPokemon - id: $id, name: ${pokemon?.name}, isCaptured: $isCaptured, isShiny: $isShiny';
}
