import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';

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
              stepperList: [
                StepperData(),
                StepperData(),
                StepperData(),
                StepperData(),
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
                  "{status}", // TODO: Tracking INNER JOIN что-то там такая фигня я хз
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
