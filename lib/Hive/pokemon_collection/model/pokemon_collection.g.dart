// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_collection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonCollectionAdapter extends TypeAdapter<PokemonCollection> {
  @override
  final int typeId = 2;

  @override
  PokemonCollection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonCollection(
      id: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonCollection obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isCaptured);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonCollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
