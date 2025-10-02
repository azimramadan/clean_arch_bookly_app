import 'package:bookly/Features/home/presentation/views/widgets/glassmorphism_bottom_navigation_bar.dart';
import 'package:bookly/Features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          SafeArea(child: HomeViewBody()),
          GlassmorphismBottomNavigationBar(),
        ],
      ),
    );
  }
}
