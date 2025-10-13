import 'package:hive/hive.dart';

part 'industry_identifier.g.dart';

@HiveType(typeId: 2)
class IndustryIdentifier {
  @HiveField(0)
  String? type;
  @HiveField(1)
  String? identifier;

  IndustryIdentifier({this.type, this.identifier});

  factory IndustryIdentifier.fromJson(Map<String, dynamic> json) {
    return IndustryIdentifier(
      type: json['type'] as String?,
      identifier: json['identifier'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'identifier': identifier,
      };
}
