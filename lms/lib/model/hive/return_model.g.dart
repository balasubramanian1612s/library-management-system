// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReturnBookModelAdapter extends TypeAdapter<ReturnBookModel> {
  @override
  final int typeId = 2;

  @override
  ReturnBookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReturnBookModel(
      bookName: fields[6] as String?,
      dueDate: fields[2] as DateTime?,
      edition: fields[3] as int?,
      issueDate: fields[4] as DateTime?,
      rollNumber: fields[5] as String?,
      serialNumber: fields[1] as int?,
      author: fields[0] as String?,
      dueFee: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ReturnBookModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.author)
      ..writeByte(1)
      ..write(obj.serialNumber)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.edition)
      ..writeByte(4)
      ..write(obj.issueDate)
      ..writeByte(5)
      ..write(obj.rollNumber)
      ..writeByte(6)
      ..write(obj.bookName)
      ..writeByte(7)
      ..write(obj.dueFee);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReturnBookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
