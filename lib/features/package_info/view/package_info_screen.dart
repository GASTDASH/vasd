import 'package:another_stepper/another_stepper.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:static_map/static_map.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/features/package_info/view/barcode_screen.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
import 'package:vasd/repositories/tracking/tracking.dart';
import 'package:vasd/ui/widgets/delivery_item_widget.dart';

class PackageInfoScreen extends StatefulWidget {
  const PackageInfoScreen({super.key});

  @override
  State<PackageInfoScreen> createState() => _PackageInfoScreenState();
}

class _PackageInfoScreenState extends State<PackageInfoScreen> {
  List<List<double>>? polylinesPoints;
  int zoom = 6;

  Future<List<StaticMapLocation>> getPath({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  }) async {
    final response = await GetIt.I<Dio>().get(
      'https://api.openrouteservice.org/v2/directions/driving-car',
      queryParameters: {
        "api_key": "5b3ce3597851110001cf6248a4e374cc9a9c40d7bcf7bdd1245d71bf",
        "start": "$lng1,$lat1",
        "end": "$lng2,$lat2",
      },
    );

    List<dynamic> coordinates =
        response.data["features"][0]["geometry"]["coordinates"];

    var pathPoints =
        coordinates.map((c) => StaticMapLatLng(c[1], c[0])).toList();

    while (pathPoints.length > 2000) {
      for (var i = 0; i < pathPoints.length; i++) {
        if (i.isEven) pathPoints.removeAt(i);
      }
    }

    return pathPoints;
  }

  @override
  Widget build(BuildContext context) {
    final delivery = ModalRoute.of(context)!.settings.arguments;
    assert(delivery != null && delivery is Delivery,
        'You must provide Delivery arg');
    delivery as Delivery;

    final theme = Theme.of(context);

    return BlocListener<DeliveryBloc, DeliveryState>(
      listener: (context, state) {
        // TODO
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Детали заказа",
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeliveryItemWidget(delivery: delivery),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              BarcodeScreen(deliveryId: delivery.deliveryId!)));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.hintColor, width: 1),
                      ),
                      child: Center(
                        child: BarcodeWidget(
                          height: 70,
                          data: delivery.deliveryId!,
                          barcode: Barcode.pdf417(),
                        ),
                      ),
                    ),
                  ),
                  delivery.pointFrom != null && delivery.pointTo != null
                      ? Container(
                          width: 400,
                          height: 200,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: theme.hintColor, width: 1),
                          ),
                          child: Stack(
                            children: [
                              FutureBuilder(
                                  future: getPath(
                                      lat1: delivery.pointFrom!.lat,
                                      lng1: delivery.pointFrom!.lng,
                                      lat2: delivery.pointTo!.lat,
                                      lng2: delivery.pointTo!.lng),
                                  builder: (context, snapshot) {
                                    return StaticMapBuilder(
                                        options: StaticMapOptions(
                                          width: 400,
                                          height: 200,
                                          scale: 1,
                                          zoom: zoom,
                                          center: StaticMapLatLng(
                                            (delivery.pointFrom!.lat +
                                                    delivery.pointTo!.lat) /
                                                2,
                                            (delivery.pointFrom!.lng +
                                                    delivery.pointTo!.lng) /
                                                2,
                                          ),
                                          overlays: [
                                            StaticMapMarker(
                                                point: StaticMapLatLng(
                                                    delivery.pointFrom!.lat,
                                                    delivery.pointFrom!.lng),
                                                label: "От",
                                                color: theme.primaryColor),
                                            StaticMapMarker(
                                              point: StaticMapLatLng(
                                                  delivery.pointTo!.lat,
                                                  delivery.pointTo!.lng),
                                              label: "Куда",
                                              color: theme.primaryColor,
                                            ),
                                            StaticMapPath.points(
                                              points:
                                                  snapshot.connectionState ==
                                                              ConnectionState
                                                                  .done &&
                                                          snapshot.data != null
                                                      ? snapshot.data!
                                                      : [
                                                          StaticMapLatLng(
                                                            delivery
                                                                .pointFrom!.lat,
                                                            delivery
                                                                .pointFrom!.lng,
                                                          ),
                                                          StaticMapLatLng(
                                                            delivery
                                                                .pointTo!.lat,
                                                            delivery
                                                                .pointTo!.lng,
                                                          ),
                                                        ],
                                              size: 1,
                                            ),
                                          ],
                                        ),
                                        builder: (context, url) {
                                          return Image.network(
                                            url,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                  child: Text(
                                                      "Что-то пошло не так!"));
                                            },
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const Center(
                                                  child: LoadingIndicator(
                                                      indicatorType:
                                                          Indicator.ballPulse));
                                            },
                                          );
                                        });
                                  }),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton.filled(
                                        onPressed: () {
                                          setState(() {
                                            if (zoom != 1) zoom--;
                                          });
                                        },
                                        icon: const Icon(Icons.zoom_out)),
                                    IconButton.filled(
                                        onPressed: () {
                                          setState(() {
                                            if (zoom != 8) zoom++;
                                          });
                                        },
                                        icon: const Icon(Icons.zoom_in)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  Text(
                    "Отслеживание посылки",
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  AnotherStepper(
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    stepperDirection: Axis.vertical,
                    activeBarColor: theme.primaryColor,
                    activeIndex: delivery.trackingList?.length ?? 0,
                    iconHeight: 32,
                    iconWidth: 32,
                    verticalGap: 20,
                    stepperList: [
                      for (Tracking tracking in delivery.trackingList ?? [])
                        StepperData(
                          iconWidget: CircleAvatar(
                            backgroundColor:
                                theme.primaryColor.withValues(alpha: 0.3),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: CircleAvatar(
                                backgroundColor: theme.primaryColor,
                              ),
                            ),
                          ),
                          title: StepperText(tracking.updateTime.toString(),
                              textStyle: theme.textTheme.bodyMedium
                                  ?.copyWith(color: theme.hintColor)),
                          subtitle: StepperText(tracking.status.name,
                              textStyle: theme.textTheme.bodyMedium),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
