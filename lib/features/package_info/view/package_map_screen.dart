import 'package:flutter/material.dart';
import 'package:static_map/static_map.dart';
import 'package:vasd/features/package_info/widgets/package_map.dart';

class PackageMapScreen extends StatefulWidget {
  const PackageMapScreen({
    super.key,
    required this.center,
    required this.path,
    required this.pointFrom,
    required this.pointTo,
    this.pointNow,
  });

  final List<double> center;
  final List<StaticMapLocation> path;
  final List<double> pointFrom;
  final List<double> pointTo;
  final List<double>? pointNow;

  @override
  State<PackageMapScreen> createState() => _PackageMapScreenState();
}

class _PackageMapScreenState extends State<PackageMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PackageMap(
        center: widget.center,
        path: widget.path,
        pointFrom: widget.pointFrom,
        pointTo: widget.pointTo,
        pointNow: widget.pointNow,
      ),
    );
  }
}
