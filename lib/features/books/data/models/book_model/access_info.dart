import 'package:hive/hive.dart';

import 'epub.dart';
import 'pdf.dart';

part 'access_info.g.dart';

@HiveType(typeId: 7)
class AccessInfo {
  @HiveField(0)
  String? country;
  @HiveField(1)
  String? viewability;
  @HiveField(2)
  bool? embeddable;
  @HiveField(3)
  bool? publicDomain;
  @HiveField(4)
  String? textToSpeechPermission;
  @HiveField(5)
  Epub? epub;
  @HiveField(6)
  Pdf? pdf;
  @HiveField(7)
  String? webReaderLink;
  @HiveField(8)
  String? accessViewStatus;
  @HiveField(9)
  bool? quoteSharingAllowed;

  AccessInfo({
    this.country,
    this.viewability,
    this.embeddable,
    this.publicDomain,
    this.textToSpeechPermission,
    this.epub,
    this.pdf,
    this.webReaderLink,
    this.accessViewStatus,
    this.quoteSharingAllowed,
  });

  factory AccessInfo.fromJson(Map<String, dynamic> json) => AccessInfo(
        country: json['country'] as String?,
        viewability: json['viewability'] as String?,
        embeddable: json['embeddable'] as bool?,
        publicDomain: json['publicDomain'] as bool?,
        textToSpeechPermission: json['textToSpeechPermission'] as String?,
        epub: json['epub'] == null
            ? null
            : Epub.fromJson(json['epub'] as Map<String, dynamic>),
        pdf: json['pdf'] == null
            ? null
            : Pdf.fromJson(json['pdf'] as Map<String, dynamic>),
        webReaderLink: json['webReaderLink'] as String?,
        accessViewStatus: json['accessViewStatus'] as String?,
        quoteSharingAllowed: json['quoteSharingAllowed'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'country': country,
        'viewability': viewability,
        'embeddable': embeddable,
        'publicDomain': publicDomain,
        'textToSpeechPermission': textToSpeechPermission,
        'epub': epub?.toJson(),
        'pdf': pdf?.toJson(),
        'webReaderLink': webReaderLink,
        'accessViewStatus': accessViewStatus,
        'quoteSharingAllowed': quoteSharingAllowed,
      };
}
