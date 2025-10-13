import 'package:hive/hive.dart';

import 'image_links.dart';
import 'industry_identifier.dart';
import 'panelization_summary.dart';
import 'reading_modes.dart';

part 'volume_info.g.dart';

@HiveType(typeId: 1)
class VolumeInfo {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? subtitle;
  @HiveField(2)
  List<String>? authors;
  @HiveField(3)
  String? publishedDate;
  @HiveField(4)
  List<IndustryIdentifier>? industryIdentifiers;
  @HiveField(5)
  ReadingModes? readingModes;
  @HiveField(6)
  int? pageCount;
  @HiveField(7)
  String? printType;
  @HiveField(8)
  List<String>? categories;
  @HiveField(9)
  String? maturityRating;
  @HiveField(10)
  bool? allowAnonLogging;
  @HiveField(11)
  String? contentVersion;
  @HiveField(12)
  PanelizationSummary? panelizationSummary;
  @HiveField(13)
  ImageLinks? imageLinks;
  @HiveField(14)
  String? language;
  @HiveField(15)
  String? previewLink;
  @HiveField(16)
  String? infoLink;
  @HiveField(17)
  String? canonicalVolumeLink;

  VolumeInfo({
    this.title,
    this.subtitle,
    this.authors,
    this.publishedDate,
    this.industryIdentifiers,
    this.readingModes,
    this.pageCount,
    this.printType,
    this.categories,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.panelizationSummary,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
        title: json['title'] as String?,
        subtitle: json['subtitle'] as String?,
        authors: json['authors'] as List<String>?,
        publishedDate: json['publishedDate'] as String?,
        industryIdentifiers: (json['industryIdentifiers'] as List<dynamic>?)
            ?.map((e) => IndustryIdentifier.fromJson(e as Map<String, dynamic>))
            .toList(),
        readingModes: json['readingModes'] == null
            ? null
            : ReadingModes.fromJson(
                json['readingModes'] as Map<String, dynamic>),
        pageCount: json['pageCount'] as int?,
        printType: json['printType'] as String?,
        categories: json['categories'] as List<String>?,
        maturityRating: json['maturityRating'] as String?,
        allowAnonLogging: json['allowAnonLogging'] as bool?,
        contentVersion: json['contentVersion'] as String?,
        panelizationSummary: json['panelizationSummary'] == null
            ? null
            : PanelizationSummary.fromJson(
                json['panelizationSummary'] as Map<String, dynamic>),
        imageLinks: json['imageLinks'] == null
            ? null
            : ImageLinks.fromJson(json['imageLinks'] as Map<String, dynamic>),
        language: json['language'] as String?,
        previewLink: json['previewLink'] as String?,
        infoLink: json['infoLink'] as String?,
        canonicalVolumeLink: json['canonicalVolumeLink'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'authors': authors,
        'publishedDate': publishedDate,
        'industryIdentifiers':
            industryIdentifiers?.map((e) => e.toJson()).toList(),
        'readingModes': readingModes?.toJson(),
        'pageCount': pageCount,
        'printType': printType,
        'categories': categories,
        'maturityRating': maturityRating,
        'allowAnonLogging': allowAnonLogging,
        'contentVersion': contentVersion,
        'panelizationSummary': panelizationSummary?.toJson(),
        'imageLinks': imageLinks?.toJson(),
        'language': language,
        'previewLink': previewLink,
        'infoLink': infoLink,
        'canonicalVolumeLink': canonicalVolumeLink,
      };
}
