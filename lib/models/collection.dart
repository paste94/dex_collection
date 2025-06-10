import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'collection.g.dart';

@HiveType(typeId: 0)
class Collection {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  late int color;

  Collection({required this.name, this.color = 0xff03a9f4}) : id = Uuid().v4();

  @override
  String toString() => 'Collection - name: $name';
}
