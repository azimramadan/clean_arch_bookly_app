import 'dart:ui';

import 'package:bookly/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GlassmorphismBottomNavigationBar extends StatelessWidget {
  const GlassmorphismBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 30, left: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(20),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      Assets.imagesBooks,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      Assets.imagesSaved,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      Assets.imagesAudio,
                    ),
                    onPressed: () {},
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      "https://i.pravatar.cc/150?img=3",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
