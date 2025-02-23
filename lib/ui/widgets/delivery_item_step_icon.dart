import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryItemStepIcon extends StatelessWidget {
  const DeliveryItemStepIcon({
    super.key,
    required this.enabled,
    required this.iconAsset,
  });

  final bool enabled;
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CircleAvatar(
      backgroundColor: enabled ? theme.primaryColor : Colors.grey,
      child: enabled
          ? Padding(
              padding: const EdgeInsets.all(6),
              child: SvgPicture.asset(
                iconAsset,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            )
          : null,
    );
  }
}
