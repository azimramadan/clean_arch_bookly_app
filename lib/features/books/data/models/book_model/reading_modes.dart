import 'package:hive/hive.dart';

part 'reading_modes.g.dart';

@HiveType(typeId: 3)
class ReadingModes {
  @HiveField(0)
  bool? text;
  @HiveField(1)
  bool? image;

  ReadingModes({this.text, this.image});

  factory ReadingModes.fromJson(Map<String, dynamic> json) => ReadingModes(
        text: json['text'] as bool?,
        image: json['image'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'image': image,
      };
}
