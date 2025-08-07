import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'collected_pokemon.g.dart';

@HiveType(typeId: 2)
class CollectedPokemon {
  @HiveField(0)
  final int id;

  @HiveField(1)
  bool isCaptured;

  Pokemon? pokemon;

  CollectedPokemon({required this.id, this.isCaptured = false});
}
