import 'package:flutter/material.dart';
import 'package:universe/universe.dart';
import 'package:vasd/ui/ui.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  final mapController = U.MapController();
  List<double> lastCoordinates = [55.811049, 38.970480];
  double lastZoom = 16;
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: Container(
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
              // address.isNotEmpty
              //     ? Expanded(
              //         child: Padding(
              //           padding: const EdgeInsets.only(right: 12),
              //           child: Container(
              //             decoration: BoxDecoration(
              //               color: theme.hintColor.withOpacity(0.5),
              //               borderRadius: BorderRadius.circular(16),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 12),
              //               child: TextField(
              //                 controller: addressController,
              //                 canRequestFocus: false,
              //                 decoration: const InputDecoration(border: InputBorder.none),
              //               ),
              //             ),
              //           ),
              //         ),
              //       )
              //     : const SizedBox.shrink(),
              SizedBox(
                child: Material(
                  child: ButtonBase(
                    text: "Выбрать",
                    onTap: () async {
                      final lat = mapController.center?.lat;
                      final lng = mapController.center?.lng;

                      if (lat != null && lng != null) {
                        Navigator.pop(context, [lat, lng]);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: U.GoogleMap(
        controller: mapController,
        centerMarker: const Icon(Icons.place, size: 42, color: Colors.red),
        showCenterMarker: true,
        center: lastCoordinates,
        zoom: lastZoom,
      ),
    );
  }
}
