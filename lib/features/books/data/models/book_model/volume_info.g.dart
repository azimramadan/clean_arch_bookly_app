// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VolumeInfoAdapter extends TypeAdapter<VolumeInfo> {
  @override
  final int typeId = 1;

  @override
  VolumeInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VolumeInfo(
      title: fields[0] as String?,
      subtitle: fields[1] as String?,
      authors: (fields[2] as List?)?.cast<String>(),
      publishedDate: fields[3] as String?,
      industryIdentifiers: (fields[4] as List?)?.cast<IndustryIdentifier>(),
      readingModes: fields[5] as ReadingModes?,
      pageCount: fields[6] as int?,
      printType: fields[7] as String?,
      categories: (fields[8] as List?)?.cast<String>(),
      maturityRating: fields[9] as String?,
      allowAnonLogging: fields[10] as bool?,
      contentVersion: fields[11] as String?,
      panelizationSummary: fields[12] as PanelizationSummary?,
      imageLinks: fields[13] as ImageLinks?,
      language: fields[14] as String?,
      previewLink: fields[15] as String?,
      infoLink: fields[16] as String?,
      canonicalVolumeLink: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VolumeInfo obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.authors)
      ..writeByte(3)
      ..write(obj.publishedDate)
      ..writeByte(4)
      ..write(obj.industryIdentifiers)
      ..writeByte(5)
      ..write(obj.readingModes)
      ..writeByte(6)
      ..write(obj.pageCount)
      ..writeByte(7)
      ..write(obj.printType)
      ..writeByte(8)
      ..write(obj.categories)
      ..writeByte(9)
      ..write(obj.maturityRating)
      ..writeByte(10)
      ..write(obj.allowAnonLogging)
      ..writeByte(11)
      ..write(obj.contentVersion)
      ..writeByte(12)
      ..write(obj.panelizationSummary)
      ..writeByte(13)
      ..write(obj.imageLinks)
      ..writeByte(14)
      ..write(obj.language)
      ..writeByte(15)
      ..write(obj.previewLink)
      ..writeByte(16)
      ..write(obj.infoLink)
      ..writeByte(17)
      ..write(obj.canonicalVolumeLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VolumeInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
