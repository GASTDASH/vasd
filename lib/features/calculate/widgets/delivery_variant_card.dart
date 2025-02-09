import 'package:flutter/material.dart';

class DeliveryVariantCard extends StatelessWidget {
  const DeliveryVariantCard({
    super.key,
    required this.name,
    required this.minCost,
    required this.minDays,
    required this.maxDays,
    this.description,
    required this.onTap,
    this.selected = false,
  });

  final String name;
  final double minCost;
  final int minDays;
  final int maxDays;
  final String? description;
  final void Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Ink(
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: selected ? theme.primaryColor : Colors.black,
                  width: selected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: theme.textTheme.headlineSmall,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "от ${minCost.truncate()} ₽",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "$minDays-$maxDays рабочих дней",
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      description ?? "",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
