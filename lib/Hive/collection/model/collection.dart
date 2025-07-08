import 'package:dex_collection/Hive/pokemon_collection/model/pokemon_collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'collection.g.dart';

@HiveType(typeId: 0)
class Collection extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  int color;

  @HiveField(3)
  List<PokemonCollection>? pokemons;

  Collection({required this.name, this.color = 0xff03a9f4, this.pokemons})
    : id = Uuid().v4();

  @override
  String toString() => 'Collection - name: $name';

  Collection copyWith({
    String? name,
    int? color,
    List<PokemonCollection>? pokemons,
  }) {
    return Collection(
      name: name ?? this.name,
      color: color ?? this.color,
      pokemons: pokemons ?? this.pokemons,
    );
  }
}
