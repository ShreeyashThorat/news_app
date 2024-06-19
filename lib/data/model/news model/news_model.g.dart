// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsModelAdapter extends TypeAdapter<NewsModel> {
  @override
  final int typeId = 1;

  @override
  NewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsModel(
      author: fields[0] as String?,
      content: fields[1] as String?,
      date: fields[2] as String?,
      id: fields[3] as String?,
      imageUrl: fields[4] as String?,
      readMoreUrl: fields[5] as String?,
      time: fields[6] as String?,
      title: fields[7] as String?,
      url: fields[8] as String?,
      category: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NewsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.author)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.readMoreUrl)
      ..writeByte(6)
      ..write(obj.time)
      ..writeByte(7)
      ..write(obj.title)
      ..writeByte(8)
      ..write(obj.url)
      ..writeByte(9)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
