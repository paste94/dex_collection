import 'package:dex_collection/Hive/collected_pokemon/model/collected_pokemon.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'collection.g.dart';

enum VisualizationMode { list, grid2 }

@HiveType(typeId: 0)
class Collection extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  int color;

  @HiveField(3)
  List<CollectedPokemon>? pokemons;

  @HiveField(4)
  bool? isHidden;

  @HiveField(5, defaultValue: 0)
  int? order;

  @HiveField(6, defaultValue: VisualizationMode.grid2)
  VisualizationMode? visualizationMode;

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
    this.order,
    this.visualizationMode,
  });

  @override
  String toString() => 'Collection - id: $id, name: $name, order: $order';

  Collection copyWith({
    String? name,
    int? color,
    List<CollectedPokemon>? pokemons,
    bool? isHidden,
    int? order,
    VisualizationMode? visualizationMode,
  }) {
    return Collection._(
      id: id,
      name: name ?? this.name,
      color: color ?? this.color,
      pokemons: pokemons ?? this.pokemons,
      isHidden: isHidden ?? this.isHidden,
      order: order ?? this.order,
      visualizationMode: visualizationMode ?? this.visualizationMode,
    );
  }
}
