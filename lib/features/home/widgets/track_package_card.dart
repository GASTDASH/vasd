import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrackPackageCard extends StatefulWidget {
  const TrackPackageCard({
    super.key,
    required this.trackContainerKey,
  });

  final GlobalKey trackContainerKey;

  @override
  State<TrackPackageCard> createState() => _TrackPackageCardState();
}

class _TrackPackageCardState extends State<TrackPackageCard> {
  bool codeTyped = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        key: widget.trackContainerKey,
        height: 160,
        child: Container(
          decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Отследить посылку",
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 5),
                const Text("Введите ваш номер заказа"),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: TextField(
                            onChanged: (value) => setState(() =>
                                value.isNotEmpty
                                    ? codeTyped = true
                                    : codeTyped = false),
                            onTapOutside: (event) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "assets/icons/box.svg",
                                  colorFilter: const ColorFilter.mode(
                                      Colors.black, BlendMode.srcIn),
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Номер заказа",
                              hintStyle: TextStyle(
                                color: theme.hintColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {},
                      child: Ink(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          switchInCurve: Curves.easeOutExpo,
                          transitionBuilder: (child, animation) =>
                              RotationTransition(
                            turns: child.key == const ValueKey('icon1')
                                ? Tween<double>(begin: 1.25, end: 1)
                                    .animate(animation)
                                : Tween<double>(begin: 0.75, end: 1)
                                    .animate(animation),
                            child:
                                ScaleTransition(scale: animation, child: child),
                          ),
                          child: codeTyped
                              ? const Icon(
                                  key: ValueKey('icon2'),
                                  Icons.send,
                                  color: Colors.white,
                                  size: 34,
                                )
                              : const Icon(
                                  key: ValueKey('icon1'),
                                  Icons.qr_code,
                                  color: Colors.white,
                                  size: 34,
                                ),
                        ),
                      ),
                    ),
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
