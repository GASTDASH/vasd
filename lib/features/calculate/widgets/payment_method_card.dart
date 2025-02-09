import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vasd/repositories/payment_method/models/payment_method.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.paymentMethod,
    this.selected = false,
    required this.onTap,
  });

  final PaymentMethod paymentMethod;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
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
                  child: paymentMethod.image != null
                      ? SvgPicture.asset(paymentMethod.image!)
                      : const Placeholder(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paymentMethod.text,
                      style: theme.textTheme.titleMedium,
                    ),
                    paymentMethod.description != null
                        ? Text(
                            paymentMethod.description!,
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
              value: paymentMethod,
              groupValue: selected ? paymentMethod : null,
              onChanged: (_) {
                onTap();
              },
            )
          ],
        ),
      ),
    );
  }
}
