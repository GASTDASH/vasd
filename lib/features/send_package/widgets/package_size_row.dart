import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PackageSizeRow extends StatefulWidget {
  const PackageSizeRow({
    super.key,
    required this.controller,
  });

  final PackageSizeController controller;

  @override
  State<PackageSizeRow> createState() => _PackageSizeRowState();
}

class _PackageSizeRowState extends State<PackageSizeRow> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        packageSizeBox(
          theme,
          text: "< 1кг",
          index: 0,
        ),
        packageSizeBox(
          theme,
          text: "3кг - 10кг",
          index: 1,
        ),
        packageSizeBox(
          theme,
          text: "> 10кг",
          index: 2,
        ),
      ],
    );
  }

  Widget packageSizeBox(
    ThemeData theme, {
    required String text,
    required int index,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      splashColor: theme.primaryColor.withOpacity(0.2),
      onTap: () {
        setState(() {
          widget.controller.selectedIndex = index;
        });
      },
      child: Ink(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              width: 2,
              color: widget.controller.selectedIndex == index
                  ? theme.primaryColor
                  : Colors.grey.shade400),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(
                  index + 1,
                  (i) => SvgPicture.asset(
                    "assets/icons/cube.svg",
                    height: index < 2 ? 40 : 32,
                    colorFilter: ColorFilter.mode(
                      widget.controller.selectedIndex == index
                          ? theme.primaryColor
                          : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
                    color: widget.controller.selectedIndex == index
                        ? theme.primaryColor
                        : null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PackageSizeController extends ChangeNotifier {
  int selectedIndex = 0;
}
