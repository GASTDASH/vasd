import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vasd/bloc/auth/auth_bloc.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/features/home/home.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
import 'package:vasd/ui/ui.dart';

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

    return BlocListener<DeliveryBloc, DeliveryState>(
      listener: (context, state) {
        if (state is DeliveryError) {
          String title = "Непредвиденная ошибка";
          String text = state.error.toString();

          if (state.error.toString().contains("host")) {
            title = "Ошибка соединения";
            text = "Проверьте соединение с интернетом или попробуйте позже.\n\n${(state.error as SocketException).message}";
          }

          showDialog(
            context: context,
            builder: (context) => ErrorDialog(title: title, text: text),
          );

          // ScaffoldMessenger.of(context).hideCurrentSnackBar();
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(
          //       state.error.toString(),
          //     ),
          //   ),
          // );
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: const HomeAppBar(),
          body: RefreshIndicator(
            onRefresh: () async {
              _deliveryBloc.add(DeliveryLoad());
            },
            child: CustomScrollView(
              slivers: [
                context.read<AuthBloc>().authRepo.user?.editor ?? false
                    ? BlocBuilder<DeliveryBloc, DeliveryState>(
                        builder: (context, state) {
                          if (state is DeliveryLoaded) {
                            return SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: ButtonBase(
                                  prefixIcon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  text: "Перейти в режим редактирования",
                                  color: Colors.blue.shade400,
                                  onTap: () {
                                    Navigator.pushNamed(context, "/packages_editor");
                                  },
                                ),
                              ),
                            );
                          } else {
                            return SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: ShimmerCustom(
                                  child: ButtonBase(
                                    prefixIcon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    text: "Перейти в режим редактирования",
                                    color: Colors.blue.shade400,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      )
                    : const SliverToBoxAdapter(child: SizedBox.shrink()),
                //
                // Отследить посылку
                SliverToBoxAdapter(child: TrackPackageCard(trackContainerKey: trackContainerKey)),
                //
                // Последняя доставка
                SliverToBoxAdapter(
                  child: BlocBuilder<DeliveryBloc, DeliveryState>(
                    bloc: _deliveryBloc,
                    builder: (context, state) {
                      if (state is DeliveryLoaded && state.deliveries.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return LastDeliveryCard(
                        delivery: (state is! DeliveryLoading && state.deliveries.isNotEmpty) ? state.deliveries.last : null,
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
                    if (state is DeliveryLoaded && state.deliveries.isEmpty) {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }
                    return recentPackagesArea(
                        theme,
                        (state is DeliveryLoaded && state.deliveries.isNotEmpty)
                            ? [
                                state.deliveries[state.deliveries.length - 1],
                                if (state.deliveries.length > 1) state.deliveries[state.deliveries.length - 2],
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
            Text(
              "Последние посылки",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
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
                        if (deliveries.length > 1) const SizedBox(height: 24),
                        if (deliveries.length > 1) RecentPackageWidget(delivery: deliveries[1]),
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
            Text(
              "Услуги",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
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
                        colorFilter: ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
                        height: 50,
                      ),
                      text: "Отправить",
                    ),
                    const SizedBox(width: 16),
                    ServiceButton(
                      onTap: () {
                        Scrollable.ensureVisible(trackContainerKey.currentContext!, duration: const Duration(seconds: 1));
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/location_arrow.svg",
                        colorFilter: ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
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
