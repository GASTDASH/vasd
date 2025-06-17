import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universe/universe.dart';
import 'package:vasd/repositories/point/point.dart' as point_repo;
import 'package:vasd/repositories/user_location/user_location_repo.dart';
import 'package:vasd/ui/ui.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class SetCurrentLocationScreen extends StatefulWidget {
  const SetCurrentLocationScreen({super.key});

  @override
  State<SetCurrentLocationScreen> createState() => _SetCurrentLocationScreenState();
}

class _SetCurrentLocationScreenState extends State<SetCurrentLocationScreen> {
  final mapController = U.MapController();
  String address = "";
  List<double> lastCoordinates = [55.811049, 38.970480];
  double lastZoom = 16;
  final addressController = TextEditingController();
  final YandexGeocoder geo = YandexGeocoder(apiKey: '113bba24-0265-43bc-9589-e7b7e88285da');

  Future<point_repo.Point?> getAddress() async {
    final lat = mapController.center?.lat;
    final lng = mapController.center?.lng;

    if (lat != null && lng != null) {
      final address = await geo.getGeocode(ReverseGeocodeRequest(pointGeocode: (lat: lat, lon: lng)));

      setState(() {
        this.address = address.firstAddress?.formatted.toString() ?? "";
        addressController.text = this.address;

        lastCoordinates = [lat, lng];
        lastZoom = mapController.zoom ?? 16;
      });

      return point_repo.Point(id: 0, address: this.address, lat: lat, lng: lng);
    }
    return null;
  }

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
              address.isNotEmpty
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.hintColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextField(
                              controller: addressController,
                              canRequestFocus: false,
                              decoration: const InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                width: address.isEmpty ? null : 60,
                child: Material(
                  child: ButtonBase(
                    text: address.isEmpty ? "Определить адрес" : "",
                    prefixIcon: address.isEmpty
                        ? null
                        : const Icon(
                            Icons.refresh_rounded,
                            color: Colors.white,
                          ),
                    onTap: () async {
                      var repo = context.read<UserLocationRepo>();

                      var point = await getAddress();
                      if (point != null) repo.updateLocation(point);
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
