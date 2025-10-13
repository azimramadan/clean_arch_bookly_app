import 'package:hive/hive.dart';

part 'pdf.g.dart';

@HiveType(typeId: 9)
class Pdf {
  @HiveField(0)
  bool? isAvailable;

  Pdf({this.isAvailable});

  factory Pdf.fromJson(Map<String, dynamic> json) => Pdf(
        isAvailable: json['isAvailable'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'isAvailable': isAvailable,
      };
}
