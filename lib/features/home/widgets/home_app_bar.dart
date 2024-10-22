import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSize {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PreferredSize(
      preferredSize: preferredSize,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: Ink(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(
                  Icons.place_outlined,
                  color: theme.primaryColor,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width - 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Ваше местоположение"),
                  SizedBox(
                    child: Text(
                      "Орехово-Зуево, Московская обл.",
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox.expand()),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: Ink(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network("https://i.imgur.com/caImSzp.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget get child => const SizedBox.shrink();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}