import 'package:flutter/material.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';

class PackageSizeItem extends StatelessWidget {
  const PackageSizeItem({
    super.key,
    required this.packageSize,
  });

  final PackageSize packageSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.pop(context, packageSize);
        },
        child: Ink(
          height: 80,
          decoration: BoxDecoration(
            color: theme.hintColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const SizedBox(height: 60, width: 60, child: Placeholder()),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      packageSize.title,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(packageSize.size),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
