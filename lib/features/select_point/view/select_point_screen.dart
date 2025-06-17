import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:universe/universe.dart';
import 'package:vasd/repositories/point/point.dart';
import 'package:vasd/ui/ui.dart';

class SelectPointScreen extends StatefulWidget {
  const SelectPointScreen({super.key});

  @override
  State<SelectPointScreen> createState() => _SelectPointScreenState();
}

class _SelectPointScreenState extends State<SelectPointScreen> {
  final mapController = U.MapController();
  List<double> lastCoordinates = [55.811049, 38.970480];
  final addressController = TextEditingController();

  void moveToAddress(String address, List<Point> points) {
    Point target = points.firstWhere(
      (p) => p.address == address,
    );

    mapController.move([target.lat, target.lng], zoom: 10, animate: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder(
      builder: (context, snapshot) => Scaffold(
          bottomSheet: Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 10)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Autocomplete<String>(
                        optionsViewOpenDirection: OptionsViewOpenDirection.up,
                        optionsBuilder: (textEditingValue) async {
                          if (!snapshot.hasData) return [];
                          return snapshot.data!.map((p) => p.address).where(
                                (p) => (p.toLowerCase()).contains(textEditingValue.text.toLowerCase()),
                              );
                        },
                        onSelected: (option) => moveToAddress(option, snapshot.data!),
                        fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                          return TextFieldCustom(
                            onEditingComplete: onFieldSubmitted,
                            focusNode: focusNode,
                            label: "Адрес пункта",
                            hintText: "Начните вводить адрес",
                            controller: textEditingController,
                            // onChanged: (text) {
                            //   if (text != state.delivery.cityFrom && state.delivery.cityFrom != "") {
                            //   _bloc.add(CalculateSetCity(cityFrom: ""));
                            //   }
                            // },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: (snapshot.hasData)
              ? U.GoogleMap(
                  controller: mapController,
                  center: lastCoordinates,
                  zoom: 10,
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
                )
              : (snapshot.hasError)
                  ? Center(
                      child: Text("${snapshot.error}"),
                    )
                  : const Center(
                      child: LoadingIndicator(indicatorType: Indicator.ballRotate),
                    )),
      future: Future(() async {
        return await GetIt.I<PointSupabaseRepo>().getPointList();
      }),
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
