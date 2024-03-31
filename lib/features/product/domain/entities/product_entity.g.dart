// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductResponseEntityAdapter extends TypeAdapter<ProductResponseEntity> {
  @override
  final int typeId = 0;

  @override
  ProductResponseEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductResponseEntity(
      products: (fields[0] as List).cast<ProductEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductResponseEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductResponseEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductEntityAdapter extends TypeAdapter<ProductEntity> {
  @override
  final int typeId = 1;

  @override
  ProductEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductEntity(
      id: fields[0] as String,
      title: fields[1] as String,
      price: fields[2] as String,
      description: fields[3] as String,
      category: fields[4] as String,
      image: fields[5] as String,
      rate: fields[6] as String,
      count: fields[7] as String,
      qty: fields[8] as int?,
      createdAt: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.rate)
      ..writeByte(7)
      ..write(obj.count)
      ..writeByte(8)
      ..write(obj.qty)
      ..writeByte(9)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
