import 'package:flutter/material.dart';
import 'package:static_map/static_map.dart';
import 'package:universe/universe.dart';

class PackageMap extends StatefulWidget {
  const PackageMap({
    super.key,
    required this.center,
    required this.path,
    required this.pointFrom,
    required this.pointTo,
    this.pointNow,
    this.height,
    this.width,
    this.zoom,
  });

  final double? width;
  final double? height;
  final double? zoom;
  final List<double> center;
  final List<StaticMapLocation> path;
  final List<double> pointFrom;
  final List<double> pointTo;
  final List<double>? pointNow;

  @override
  State<PackageMap> createState() => _PackageMapState();
}

class _PackageMapState extends State<PackageMap> {
  @override
  Widget build(BuildContext context) {
    return U.GoogleMap(
      interactive: widget.width != null && widget.height != null ? false : true,
      size: widget.width != null && widget.height != null ? Size(widget.width!, widget.height!) : null,
      center: widget.center,
      zoom: widget.zoom ?? 7,
      polylines: widget.path.isNotEmpty
          ? U.PolylineLayer([
              ...widget.path.map(
                (p) => [p.latitude, p.longitude],
              ),
            ], strokeColor: Colors.indigo)
          : null,
      markers: U.MarkerLayer(
        [
          U.Marker(
            widget.pointFrom,
            widget: const Padding(
              padding: EdgeInsets.only(top: 18),
              child: Icon(
                Icons.location_on,
                size: 24,
                color: Colors.pinkAccent,
              ),
            ),
          ),
          widget.pointNow != null
              ? U.Marker(
                  widget.pointNow,
                  widget: const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Icon(
                      Icons.local_shipping,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                )
              : U.Marker([0, 0]),
          U.Marker(
            widget.pointTo,
            widget: const Padding(
              padding: EdgeInsets.only(top: 18),
              child: Icon(
                Icons.location_on,
                size: 24,
                color: Colors.deepOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
