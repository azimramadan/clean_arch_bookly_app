import 'package:bookly/constants.dart';
import 'package:bookly/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      snap: false,
      backgroundColor: kPrimaryColor,
      surfaceTintColor: Colors.transparent,
      elevation: 1,
      automaticallyImplyLeading: false,
      toolbarHeight: 65,
      title: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: SvgPicture.asset(
          Assets.imagesLogo,
        ),
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              Assets.imagesIcSearch,
            ),
          ),
        ),
      ],
    );
  }
}
