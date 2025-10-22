// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectionAdapter extends TypeAdapter<Collection> {
  @override
  final typeId = 0;

  @override
  Collection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Collection(
        name: fields[1] as String?,
        color: fields[2] == null ? 0xff03a9f4 : (fields[2] as num).toInt(),
        pokemons: fields[3] == null
            ? const []
            : (fields[3] as List?)?.cast<CollectedPokemon>(),
      )
      ..id = fields[0] as String
      ..isHidden = fields[4] as bool?
      ..order = fields[5] == null ? 0 : (fields[5] as num?)?.toInt()
      ..visualizationMode = fields[6] == null
          ? VisualizationMode.grid2
          : fields[6] as VisualizationMode?;
  }

  @override
  void write(BinaryWriter writer, Collection obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.pokemons)
      ..writeByte(4)
      ..write(obj.isHidden)
      ..writeByte(5)
      ..write(obj.order)
      ..writeByte(6)
      ..write(obj.visualizationMode);
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

class VisualizationModeAdapter extends TypeAdapter<VisualizationMode> {
  @override
  final typeId = 3;

  @override
  VisualizationMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return VisualizationMode.list;
      case 1:
        return VisualizationMode.grid2;
      default:
        return VisualizationMode.list;
    }
  }

  @override
  void write(BinaryWriter writer, VisualizationMode obj) {
    switch (obj) {
      case VisualizationMode.list:
        writer.writeByte(0);
      case VisualizationMode.grid2:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisualizationModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
