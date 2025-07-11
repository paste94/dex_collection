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

  @HiveField(4)
  bool? isHidden;

  Collection({
    required this.name,
    this.color = 0xff03a9f4,
    this.pokemons = const [],
  }) : id = Uuid().v4(),
       isHidden = false;

  Collection._({
    required this.id,
    required this.name,
    this.color = 0xff03a9f4,
    this.pokemons = const [],
    this.isHidden = false,
  });

  @override
  String toString() => 'Collection - name: $name';

  Collection copyWith({
    String? name,
    int? color,
    List<PokemonCollection>? pokemons,
    bool? isHidden,
  }) {
    return Collection._(
      id: id,
      name: name ?? this.name,
      color: color ?? this.color,
      pokemons: pokemons ?? this.pokemons,
      isHidden: isHidden ?? this.isHidden,
    );
  }
}
