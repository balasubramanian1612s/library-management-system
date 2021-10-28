// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrow_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BorrowedBookModelAdapter extends TypeAdapter<BorrowedBookModel> {
  @override
  final int typeId = 1;

  @override
  BorrowedBookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BorrowedBookModel(
      serialNumber: fields[1] as int?,
      dueDate: fields[2] as DateTime?,
      edition: fields[3] as int?,
      issueDate: fields[4] as DateTime?,
      rollNumber: fields[5] as String?,
      bookName: fields[6] as String?,
      author: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BorrowedBookModel obj) {
    writer
      ..writeByte(7)
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
      ..write(obj.bookName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BorrowedBookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
