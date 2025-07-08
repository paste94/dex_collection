import 'package:dex_collection/Hive/pokemon/model/pokemon.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'pokemon_collection.g.dart';

@HiveType(typeId: 2)
class PokemonCollection {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final bool isCaptured = false;

  Pokemon? pokemon;

  PokemonCollection({required this.id});
}
