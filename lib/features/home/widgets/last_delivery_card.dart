import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LastDeliveryCard extends StatelessWidget {
  const LastDeliveryCard({
    super.key,
  });

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
            child: Container(
              padding: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                  color: theme.hintColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(18)),
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
                                Text(
                                  "MacBook Pro 13'' (Серый)",
                                  style: theme.textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                                const Text("Номер заказа: UO8765487CE"),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: AnotherStepper(
                      iconHeight: 12,
                      iconWidth: 12,
                      activeIndex: 0,
                      activeBarColor: theme.primaryColor,
                      stepperList: [
                        StepperData(
                          iconWidget: const CircleAvatar(
                            backgroundColor: Colors.black,
                          ),
                          title: StepperText(
                            "Из",
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.w400),
                          ),
                          subtitle: StepperText(
                            "Орехово-Зуево, Россия",
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16),
                          ),
                        ),
                        StepperData(
                          iconWidget: const CircleAvatar(
                            backgroundColor: Colors.black,
                          ),
                          title: StepperText(
                            "Куда",
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.w400),
                          ),
                          subtitle: StepperText(
                            "Екатеринбург, Россия",
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16),
                          ),
                        ),
                      ],
                      stepperDirection: Axis.vertical,
                    ),
                  ),
                  const Divider(indent: 12, endIndent: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: RichText(
                      text: TextSpan(
                        text: "Статус: ",
                        style: theme.textTheme.bodyLarge,
                        children: [
                          TextSpan(
                            text: "Ваша посылка в пути",
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
