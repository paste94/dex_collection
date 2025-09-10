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

  @HiveField(3)
  String? customId;

  Pokemon? pokemon;

  CollectedPokemon({
    required this.id,
    this.isCaptured = false,
    this.isShiny = false,
  }) : customId = '#${id.toString().padLeft(4, '0')}';

  CollectedPokemon._({
    required this.id,
    required this.isCaptured,
    this.isShiny,
    this.pokemon,
    this.customId,
  });

  CollectedPokemon copyWith({
    int? id,
    bool? isCaptured,
    bool? isShiny,
    Pokemon? pokemon,
    String? customId,
  }) {
    return CollectedPokemon._(
      id: id ?? this.id,
      isCaptured: isCaptured ?? this.isCaptured,
      isShiny: isShiny ?? this.isShiny,
      pokemon: pokemon ?? this.pokemon,
      customId: customId ?? this.customId,
    );
  }

  @override
  String toString() =>
      'CollectedPokemon - id: $id, name: ${pokemon?.name}, isCaptured: $isCaptured, isShiny: $isShiny';
}
