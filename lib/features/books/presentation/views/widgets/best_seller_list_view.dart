import 'package:bookly/features/books/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';

import 'best_seller_list_view_item.dart';

class NewestBooksListView extends StatelessWidget {
  const NewestBooksListView({super.key, required this.books});
  final List<BookEntity> books;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: BookListViewItem(
              book: books[index],
            ),
          );
        },
        childCount: books.length,
      ),
    );
  }
}
