import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
import 'package:vasd/ui/widgets/delivery_item_step_icon.dart';

class DeliveryItemWidget extends StatelessWidget {
  const DeliveryItemWidget({
    super.key,
    this.delivery,
    this.isShowShadow = false,
    this.onTap,
  });

  final Delivery? delivery;
  final bool isShowShadow;
  final void Function()? onTap;

  int getCurrentStep() {
    final trackingList = delivery?.trackingList;
    if (trackingList != null && trackingList.isNotEmpty) {
      switch (trackingList.last.status.statusCode) {
        case 1:
          return 0;
        case 2:
          return 0;
        case 3:
          return 1;
        case 4:
          return 2;
        case 5:
          return 3;
        default:
          return 0;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.hintColor, width: 1),
          boxShadow: isShowShadow
              ? const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Номер заказа:",
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  delivery?.deliveryId! ?? "{delivery.deliveryId}",
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            // TODO
            AnotherStepper(
              scrollPhysics: const NeverScrollableScrollPhysics(),
              stepperDirection: Axis.horizontal,
              activeBarColor: theme.primaryColor,
              activeIndex: getCurrentStep(),
              iconHeight: 32,
              iconWidth: 32,
              stepperList: [
                StepperData(
                  iconWidget: DeliveryItemStepIcon(
                    enabled: getCurrentStep() >= 0,
                    iconAsset: "assets/icons/box.svg",
                  ),
                ),
                StepperData(
                  iconWidget: DeliveryItemStepIcon(
                    enabled: getCurrentStep() >= 1,
                    iconAsset: "assets/icons/delivery_truck.svg",
                  ),
                ),
                StepperData(
                  iconWidget: DeliveryItemStepIcon(
                    enabled: getCurrentStep() >= 2,
                    iconAsset: "assets/icons/map_marker.svg",
                  ),
                ),
                StepperData(
                  iconWidget: DeliveryItemStepIcon(
                    enabled: getCurrentStep() >= 3,
                    iconAsset: "assets/icons/check_circle.svg",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    delivery?.cityFrom ?? "{delivery.cityFrom}",
                    style: theme.textTheme.titleSmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    backgroundColor: theme.hintColor.withValues(alpha: 0.2),
                    child: const Icon(Icons.arrow_right_alt_rounded),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    delivery?.cityTo ?? "{delivery.cityTo}",
                    style: theme.textTheme.titleSmall,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Row(
              spacing: 6,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(Icons.local_shipping_outlined, color: theme.hintColor),
                Expanded(
                  child: Text(
                    delivery?.deliveryVariant != null
                        ? "${delivery?.deliveryVariant!.name} (${delivery?.deliveryVariant!.minDays}-${delivery?.deliveryVariant!.maxDays} дней)"
                        : "1",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.hintColor),
                  ),
                ),
              ],
            ),
            Divider(
              color: theme.hintColor,
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Статус:",
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  delivery?.trackingList != null &&
                          delivery!.trackingList!.isNotEmpty
                      ? delivery!.trackingList!.last.status.name
                      : "Неизвестно",
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
