import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vasd/features/home/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final trackContainerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: CustomScrollView(
          slivers: [
            // Отследить посылку
            SliverToBoxAdapter(
                child: TrackPackageCard(trackContainerKey: trackContainerKey)),
            //
            // Последняя доставка
            const SliverToBoxAdapter(child: LastDeliveryCard()),
            //
            // Услуги
            servicesArea(theme, context),
            //
            // Последние посылки
            recentPackagesArea(theme),
            //
            //
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget recentPackagesArea(ThemeData theme) {
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
            const Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  RecentPackageWidget(),
                  SizedBox(height: 24),
                  RecentPackageWidget(),
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
                        Navigator.pushNamed(
                            context, "/calculate_delivery_cost");
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
