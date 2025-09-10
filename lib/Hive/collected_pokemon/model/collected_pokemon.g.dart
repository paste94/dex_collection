// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collected_pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectedPokemonAdapter extends TypeAdapter<CollectedPokemon> {
  @override
  final typeId = 2;

  @override
  CollectedPokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollectedPokemon(
      id: (fields[0] as num).toInt(),
      isCaptured: fields[1] == null ? false : fields[1] as bool,
      isShiny: fields[2] == null ? false : fields[2] as bool?,
    )..customId = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, CollectedPokemon obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isCaptured)
      ..writeByte(2)
      ..write(obj.isShiny)
      ..writeByte(3)
      ..write(obj.customId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectedPokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
