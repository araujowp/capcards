import 'package:hive/hive.dart';
import 'card_dto.dart'; // ajuste o path se necessário

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
      id: fields[0] as int? ?? -1, // fallback se antigo
      frontDescription: fields[1] as String? ?? "",
      backDescription: fields[2] as String? ?? "",
      deckId: fields[3] as int? ?? -1,
      revisionDate: fields[4] as DateTime? ?? CardDTO.defaultDate,
    );
  }

  @override
  void write(BinaryWriter writer, CardDTO obj) {
    writer
      ..writeByte(5) // número de campos
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.frontDescription)
      ..writeByte(2)
      ..write(obj.backDescription)
      ..writeByte(3)
      ..write(obj.deckId)
      ..writeByte(4)
      ..write(obj.revisionDate);
  }
}
