import 'package:dex_collection/config/config.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'pokemon.g.dart';

@HiveType(typeId: 1)
class Pokemon {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? img;

  @HiveField(3)
  String? generation;

  @HiveField(4)
  List<String>? regions;

  @HiveField(5)
  int? color;

  @HiveField(6)
  String? shinyImg;

  Pokemon({
    required this.id,
    required this.name,
    this.img,
    this.generation,
    this.color,
    this.shinyImg,
  }) : regions = getRegionsFromName(name);

  factory Pokemon.fromJson(Map<String, dynamic> data) {
    var jsonId = data['id'];
    var jsonName = data['name'];
    var jsonImg = data['img'];
    var shinyImg = data['img_shiny'];
    var generation = data['generation'];
    var color = (POKEAPI_COLORS[data['color']] ?? Colors.white).toARGB32();
    return Pokemon(
      id: jsonId,
      name: jsonName,
      img: jsonImg,
      generation: generation,
      color: color,
      shinyImg: shinyImg,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'img': img};

  static List<String> getRegionsFromName(String name) {
    return REGIONAL_FORMS.where((region) => name.contains(region)).toList();
  }

  @override
  String toString() =>
      'id: $id, name: $name, img: $img, generation: $generation, color: $color';
}
