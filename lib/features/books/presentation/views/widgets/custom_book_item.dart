import 'dart:ui';

import 'package:bookly/core/utils/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBookImage extends StatelessWidget {
  final double scale;
  final String imagePath;

  const CustomBookImage({
    Key? key,
    this.scale = 1.0,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 2.6 / 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.red,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: CachedNetworkImageProvider(imagePath),
            ),
          ),
          child: const Align(
            alignment: Alignment.bottomRight,
            child: GradientPlayButton(),
          ),
        ),
      ),
    );
  }
}

class GradientPlayButton extends StatelessWidget {
  const GradientPlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withAlpha(20),
            ),
            child: Center(
                child: SvgPicture.asset(
              Assets.imagesStartIc,
              width: 20,
            )),
          ),
        ),
      ),
    );
  }
}
