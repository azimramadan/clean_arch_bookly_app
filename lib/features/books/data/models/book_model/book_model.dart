import 'package:bookly/features/books/domain/entities/book_entity.dart';

import 'access_info.dart';
import 'sale_info.dart';
import 'volume_info.dart';

class BookModel extends BookEntity {
  String? kind;
  String? id;
  String? etag;
  String? selfLink;
  VolumeInfo? volumeInfo;
  SaleInfo? saleInfo;
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
          rating: volumeInfo?.maturityRating ?? "N/A",
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
