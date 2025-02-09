import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.name,
    this.description,
    this.image,
    required this.selected,
  });

  final String name;
  final String? description;
  final String? image;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 12,
              children: [
                Container(
                  height: 60,
                  width: 65,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: theme.hintColor.withValues(alpha: 0.1),
                  ),
                  child: image != null
                      ? SvgPicture.asset(image!)
                      : const Placeholder(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.titleMedium,
                    ),
                    description != null
                        ? Text(
                            description!,
                            style: TextStyle(
                              color: theme.hintColor,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
            Radio(
              value: selected,
              groupValue: null,
              onChanged: (value) {},
            )
          ],
        ),
      ),
    );
  }
}
