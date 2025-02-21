import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vasd/ui/widgets/shimmer_custom.dart';

class LastDeliveryCard extends StatelessWidget {
  const LastDeliveryCard({
    super.key,
  });

  final bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Последняя доставка",
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
            child: ShimmerCustom(
              child: Container(
                padding: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: theme.hintColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8).copyWith(top: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 4),
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: SvgPicture.asset(
                                      "assets/icons/cube.svg",
                                    ),
                                  )),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 15,
                                    width: 140,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 15,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                    ),
                    const Divider(indent: 12, endIndent: 12),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: SizedBox(height: 150),
                    ),
                    const Divider(indent: 12, endIndent: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Container(
                        height: 15,
                        width: 200,
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
