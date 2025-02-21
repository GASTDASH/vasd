import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCustom extends StatelessWidget {
  const ShimmerCustom({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.child,
  });

  final double? height;
  final double? width;
  final double? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child ??
          Container(
            height: height ?? 300,
            width: width,
            decoration: BoxDecoration(
              color: const Color(0xFF98a8b8),
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
          ),
    );
  }
}
