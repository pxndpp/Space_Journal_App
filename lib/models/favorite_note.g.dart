// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteNoteAdapter extends TypeAdapter<FavoriteNote> {
  @override
  final typeId = 0;

  @override
  FavoriteNote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteNote(
      date: fields[0] as String,
      title: fields[1] as String,
      imgURL: fields[2] as String,
      userNote: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteNote obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imgURL)
      ..writeByte(3)
      ..write(obj.userNote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteNoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
