import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    Key? key,
    required this.photo,
    this.onTap,
    this.width,
  }) : super(key: key);

  final String photo;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: Offset(0.0, 0.0),
          blurRadius: 6.0,
          color: Colors.blueGrey.withOpacity(0.8),
        )
      ]),
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
