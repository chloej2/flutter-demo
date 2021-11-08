import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class GalleryAnimation extends StatelessWidget {
  final Widget galleryWidget;
  final int index;
  const GalleryAnimation(
      {Key? key, required this.galleryWidget, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      columnCount: 2,
      duration: const Duration(milliseconds: 475),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: galleryWidget,
          ),
        ),
      ),
    );
  }
}
