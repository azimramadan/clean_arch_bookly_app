class BookEntity {
  final String bookId;
  final String title;
  final String author;
  final num price;
  final String rating;
  final String imageUrl;

  BookEntity({
    required this.bookId,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });
}
