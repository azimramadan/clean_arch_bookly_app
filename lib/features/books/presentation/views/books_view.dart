import 'package:bookly/features/books/presentation/views/widgets/books_view_body.dart';
import 'package:bookly/features/books/presentation/views/widgets/glassmorphism_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BooksView extends StatelessWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          SafeArea(child: BooksViewBody()),
          GlassmorphismBottomNavigationBar(),
        ],
      ),
    );
  }
}
