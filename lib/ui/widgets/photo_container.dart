import 'package:flutter/material.dart';

class PhotoContainer extends StatelessWidget {
  const PhotoContainer({
    super.key,
    required this.imageProvider,
  });

  final ImageProvider<Object> imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
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
