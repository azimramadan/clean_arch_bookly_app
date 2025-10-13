import 'package:hive/hive.dart';

part 'epub.g.dart';

@HiveType(typeId: 8)
class Epub {
  @HiveField(0)
  bool? isAvailable;

  Epub({this.isAvailable});

  factory Epub.fromJson(Map<String, dynamic> json) => Epub(
        isAvailable: json['isAvailable'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'isAvailable': isAvailable,
      };
}
