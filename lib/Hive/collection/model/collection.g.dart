// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectionAdapter extends TypeAdapter<Collection> {
  @override
  final int typeId = 0;

  @override
  Collection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Collection(
      name: fields[1] as String?,
      color: fields[2] as int,
      pokemons: (fields[3] as List?)?.cast<PokemonCollection>(),
    )
      ..id = fields[0] as String
      ..isHidden = fields[4] as bool?;
  }

  @override
  void write(BinaryWriter writer, Collection obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.pokemons)
      ..writeByte(4)
      ..write(obj.isHidden);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
