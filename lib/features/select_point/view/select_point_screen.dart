import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:universe/universe.dart';
import 'package:vasd/repositories/point/point.dart';

class SelectPointScreen extends StatefulWidget {
  const SelectPointScreen({super.key});

  @override
  State<SelectPointScreen> createState() => _SelectPointScreenState();
}

class _SelectPointScreenState extends State<SelectPointScreen> {
  final mapController = U.MapController();
  List<double> lastCoordinates = [55.811049, 38.970480];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return U.GoogleMap(
              controller: mapController,
              center: lastCoordinates,
              zoom: 14,
              markers: U.MarkerLayer(
                snapshot.data!
                    .map(
                      (point) => marker(
                        color: theme.primaryColor,
                        point: point,
                      ),
                    )
                    .toList(),
                onTap: (latlng, data) {
                  if (data is Point) Navigator.of(context).pop(data);
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else {
            return const Center(
              child: LoadingIndicator(indicatorType: Indicator.ballRotate),
            );
          }
        },
        future: Future(() async {
          return await GetIt.I<PointSupabaseRepo>().getPointList();
        }),
      ),
    );
  }

  Marker marker({
    required Color color,
    required Point point,
  }) {
    return U.Marker(
      [point.lat, point.lng],
      data: point,
      widget: Icon(
        Icons.place,
        size: 42,
        color: color,
      ),
    );
  }
}
