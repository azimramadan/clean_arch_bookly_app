class BookEntity {
  final String title;
  final String author;
  final num price;
  final num rating;
  final String imageUrl;

  BookEntity({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });
}
