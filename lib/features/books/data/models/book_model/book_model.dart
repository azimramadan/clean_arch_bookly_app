import 'package:bookly/features/books/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

import 'access_info.dart';
import 'sale_info.dart';
import 'volume_info.dart';

part 'book_model.g.dart';

@HiveType(typeId: 0)
class BookModel extends BookEntity {
  @HiveField(0)
  String? kind;
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? etag;
  @HiveField(3)
  String? selfLink;
  @HiveField(4)
  VolumeInfo? volumeInfo;
  @HiveField(5)
  SaleInfo? saleInfo;
  @HiveField(6)
  AccessInfo? accessInfo;

  BookModel({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
  }) : super(
          bookId: id ?? "unknown_id",
          title: volumeInfo?.title ?? "Untitled",
          author: extractAuthor(volumeInfo),
          imageUrl: volumeInfo?.imageLinks?.thumbnail ?? "",
          price: extractPrice(saleInfo),
          rating: volumeInfo?.maturityRating ?? "NotAvailable",
        );

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        kind: json['kind'] as String?,
        id: json['id'] as String?,
        etag: json['etag'] as String?,
        selfLink: json['selfLink'] as String?,
        volumeInfo: json['volumeInfo'] == null
            ? null
            : VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
        saleInfo: json['saleInfo'] == null
            ? null
            : SaleInfo.fromJson(json['saleInfo'] as Map<String, dynamic>),
        accessInfo: json['accessInfo'] == null
            ? null
            : AccessInfo.fromJson(json['accessInfo'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'kind': kind,
        'id': id,
        'etag': etag,
        'selfLink': selfLink,
        'volumeInfo': volumeInfo?.toJson(),
        'saleInfo': saleInfo?.toJson(),
        'accessInfo': accessInfo?.toJson(),
      };

  static String extractAuthor(VolumeInfo? volumeInfo) {
    final authors = volumeInfo?.authors;
    if (authors != null && authors.isNotEmpty) {
      return authors.first;
    }
    return "Unknown Author";
  }

  static num extractPrice(SaleInfo? saleInfo) {
    return 0.0;
  }
}
