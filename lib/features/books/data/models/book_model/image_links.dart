import 'package:hive/hive.dart';

part 'image_links.g.dart';

@HiveType(typeId: 5)
class ImageLinks {
  @HiveField(0)
  String? smallThumbnail;
  @HiveField(1)
  String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
        smallThumbnail: json['smallThumbnail'] as String?,
        thumbnail: json['thumbnail'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'smallThumbnail': smallThumbnail,
        'thumbnail': thumbnail,
      };
}
