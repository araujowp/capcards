// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardDTOAdapter extends TypeAdapter<CardDTO> {
  @override
  final int typeId = 0;

  @override
  CardDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardDTO(
      id: fields[0] as int,
      frontDescription: fields[1] as String,
      backDescription: fields[2] as String,
      deckId: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CardDTO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.frontDescription)
      ..writeByte(2)
      ..write(obj.backDescription)
      ..writeByte(3)
      ..write(obj.deckId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
