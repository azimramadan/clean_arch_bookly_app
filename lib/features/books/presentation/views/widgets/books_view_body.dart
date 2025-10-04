import 'package:bookly/core/utils/styles.dart';
import 'package:bookly/features/books/presentation/views/widgets/custom_sliver_app_bar.dart';
import 'package:bookly/features/books/presentation/views/widgets/featured_books_list_view.dart';
import 'package:flutter/material.dart';

import 'best_seller_list_view.dart';

class BooksViewBody extends StatelessWidget {
  const BooksViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        CustomSliverAppBar(),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              FeaturedBooksListView(),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Best Seller',
                  style: Styles.textStyle18,
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        BestSellerListView(),
      ],
    );
  }
}
