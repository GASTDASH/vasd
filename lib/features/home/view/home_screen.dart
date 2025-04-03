import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/features/home/home.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
import 'package:vasd/ui/widgets/shimmer_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final trackContainerKey = GlobalKey();
  late final DeliveryBloc _deliveryBloc;

  @override
  void initState() {
    super.initState();

    _deliveryBloc = context.read<DeliveryBloc>()..add(DeliveryLoad());
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            _deliveryBloc.add(DeliveryLoad());
          },
          child: CustomScrollView(
            slivers: [
              // Отследить посылку
              SliverToBoxAdapter(
                  child:
                      TrackPackageCard(trackContainerKey: trackContainerKey)),
              //
              // Последняя доставка
              SliverToBoxAdapter(
                child: BlocBuilder<DeliveryBloc, DeliveryState>(
                  bloc: _deliveryBloc,
                  builder: (context, state) {
                    return LastDeliveryCard(
                      delivery: (state is DeliveryLoaded &&
                              state.deliveries.isNotEmpty)
                          ? state.deliveries.last
                          : null,
                    );
                  },
                ),
              ),
              //
              // Услуги
              servicesArea(theme, context),
              //
              // Последние посылки
              BlocBuilder<DeliveryBloc, DeliveryState>(
                bloc: _deliveryBloc,
                builder: (context, state) {
                  return recentPackagesArea(
                      theme,
                      (state is DeliveryLoaded && state.deliveries.isNotEmpty)
                          ? [
                              state.deliveries[state.deliveries.length - 1],
                              state.deliveries[state.deliveries.length - 2],
                            ]
                          : null);
                },
              ),
              //
              //
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }

  Widget recentPackagesArea(ThemeData theme, List<Delivery>? deliveries) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Последние посылки",
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Все",
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: theme.primaryColor)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: (deliveries == null || deliveries.isEmpty)
                    ? [
                        const ShimmerCustom(height: 90),
                        const SizedBox(height: 24),
                        const ShimmerCustom(height: 90),
                      ]
                    : [
                        RecentPackageWidget(delivery: deliveries[0]),
                        const SizedBox(height: 24),
                        RecentPackageWidget(delivery: deliveries[1]),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget servicesArea(ThemeData theme, BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Услуги",
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Все",
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: theme.primaryColor)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ServiceButton(
                      onTap: () {
                        Navigator.pushNamed(context, "/calculate");
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/delivery_truck.svg",
                        colorFilter: ColorFilter.mode(
                            theme.primaryColor, BlendMode.srcIn),
                        height: 50,
                      ),
                      text: "Отправить",
                    ),
                    const SizedBox(width: 16),
                    ServiceButton(
                      onTap: () {
                        Scrollable.ensureVisible(
                            trackContainerKey.currentContext!,
                            duration: const Duration(seconds: 1));
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/location_arrow.svg",
                        colorFilter: ColorFilter.mode(
                            theme.primaryColor, BlendMode.srcIn),
                        height: 50,
                      ),
                      text: "Отследить",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
