import 'package:flutter/material.dart';
import 'package:vasd/features/calculate_delivery_cost/widgets/package_size_item.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';

class PackageSizeDialog extends StatelessWidget {
  const PackageSizeDialog({
    super.key,
    required this.packageSizes,
  });

  final List<PackageSize> packageSizes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 120, horizontal: 32),
      child: Ink(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: packageSizes
                  .map(
                    (packageSize) => PackageSizeItem(packageSize: packageSize),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
