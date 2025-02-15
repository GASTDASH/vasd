import 'package:flutter/material.dart';

class PhotoContainer extends StatelessWidget {
  const PhotoContainer({
    super.key,
    required this.imageProvider,
    required this.margin,
  });

  final ImageProvider<Object> imageProvider;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: imageProvider,
        ),
      ),
    );
  }
}
