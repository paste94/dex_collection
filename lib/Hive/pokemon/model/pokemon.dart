import 'package:hive/hive.dart';
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

  Pokemon({required this.id, required this.name, this.img, this.generation});

  Pokemon.fromJson(Map<String, dynamic> data)
    : id = data['id'],
      name = data['name'],
      img = data['sprites']['front_default'],
      generation = data['sprites']['front_default'];
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'img': img};

  @override
  String toString() =>
      'id: $id, name: $name, img: $img, generation: $generation';
}
