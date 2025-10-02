import 'package:bookly/Features/home/presentation/views/widgets/custom_book_item.dart';
import 'package:bookly/core/utils/assets.dart';
import 'package:flutter/material.dart';

class FeaturedBooksListView extends StatefulWidget {
  const FeaturedBooksListView({
    super.key,
    this.onPageChanged,
  });

  final Function(int)? onPageChanged;

  @override
  FeaturedBooksListViewState createState() => FeaturedBooksListViewState();
}

class FeaturedBooksListViewState extends State<FeaturedBooksListView> {
  late ScrollController _scrollController;

  int _currentIndex = 0;
  double _currentScrollOffset = 0;

  final List<String> bookImages =
      List.generate(10, (index) => Assets.imagesBookImage);

  // معايير التخطيط
  final double _baseItemWidth = 140;
  final double _largeItemWidth = 160;
  final double _itemSpacing = 4;
  final double _sidePadding = 16;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _currentScrollOffset = _scrollController.offset;

      // حساب العنصر المحوري بناءً على الربع الأول من الشاشة
      double screenWidth = MediaQuery.of(context).size.width;
      double quarterScreen = screenWidth * 0.25;

      // العثور على العنصر الذي يقع في الربع الأول
      int newFocusedIndex = -1;
      double minDistance = double.infinity;

      for (int i = 0; i < bookImages.length; i++) {
        double itemPosition = _getItemPosition(i);
        // التحقق من أن العنصر في الربع الأول من الشاشة
        if (itemPosition >= 0 && itemPosition <= quarterScreen) {
          double distanceFromQuarter = (itemPosition - quarterScreen / 2).abs();
          if (distanceFromQuarter < minDistance) {
            minDistance = distanceFromQuarter;
            newFocusedIndex = i;
          }
        }
      }

      // إذا لم نجد عنصر في الربع الأول، نأخذ الأقرب للبداية
      if (newFocusedIndex == -1) {
        double totalItemWidth = _baseItemWidth + _itemSpacing;
        newFocusedIndex = (_currentScrollOffset / totalItemWidth).round();
        newFocusedIndex = newFocusedIndex.clamp(0, bookImages.length - 1);
      }

      // عند تغيير العنصر المحوري
      if (newFocusedIndex != _currentIndex) {
        _currentIndex = newFocusedIndex;

        // استدعاء callback إذا كان موجود
        if (widget.onPageChanged != null) {
          widget.onPageChanged!(_currentIndex);
        }
      }
    });
  }

  // حساب موقع العنصر على الشاشة
  double _getItemPosition(int index) {
    double totalItemWidth = _baseItemWidth + _itemSpacing;
    return (index * totalItemWidth) - _currentScrollOffset + _sidePadding;
  }

  // حساب عرض العنصر
  double _getItemWidth(int index) {
    if (index == _currentIndex) {
      return _largeItemWidth;
    } else {
      return _baseItemWidth;
    }
  }

  // التمرير إلى عنصر معين
  void scrollToIndex(int index) {
    double totalItemWidth = _baseItemWidth + _itemSpacing;
    double targetOffset = index * totalItemWidth;

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(
          left: _sidePadding,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: bookImages.length,
        itemBuilder: (BuildContext context, int index) {
          bool isActive = index == _currentIndex;
          double width = _getItemWidth(index);

          return Container(
            width: isActive ? width - 20 : width,
            margin: EdgeInsets.only(
              right: isActive ? 6 : 0,
              left: isActive && index != 0 ? 6 : 0,
            ),
            child: GestureDetector(
              onTap: () {
                scrollToIndex(index);
              },
              child: CustomBookImage(
                scale: isActive ? .95 : 0.80,
                imagePath: bookImages[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
