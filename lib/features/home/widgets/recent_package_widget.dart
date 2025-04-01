import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';

class RecentPackageWidget extends StatelessWidget {
  const RecentPackageWidget({
    super.key,
    required this.delivery,
  });

  final Delivery delivery;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.pushNamed(context, "/package_info", arguments: delivery);
      },
      child: Ink(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset("assets/icons/cube.svg"),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("{delivery.name}",
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w800)),
                  Text("ID: ${delivery.deliveryId}"),
                ],
              ),
              const Expanded(child: SizedBox.expand()),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${delivery.cost} ₽",
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w800)),
                  Text(
                      (delivery.trackingList != null &&
                              delivery.trackingList!.isNotEmpty)
                          ? delivery.trackingList!.last.status.name
                          : "Неизвестно",
                      style: TextStyle(color: theme.primaryColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
