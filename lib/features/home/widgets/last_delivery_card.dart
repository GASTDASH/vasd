import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
import 'package:vasd/ui/widgets/shimmer_custom.dart';

class LastDeliveryCard extends StatelessWidget {
  const LastDeliveryCard({
    super.key,
    this.delivery,
  });

  final Delivery? delivery;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Последняя доставка",
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8),
            child: delivery == null
                ? ShimmerCustom(
                    child: Ink(
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
                                    Ink(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: SvgPicture.asset(
                                            "assets/icons/cube.svg",
                                          ),
                                        )),
                                    const SizedBox(width: 12),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed("/package_info", arguments: delivery);
                    },
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: SvgPicture.asset(
                                            "assets/icons/cube.svg",
                                          ),
                                        )),
                                    const SizedBox(width: 12),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Заказ от ${delivery?.createdAt?.toIso8601String().split('T')[0].split('-').reversed.join('.')}",
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w800),
                                        ),
                                        Text(
                                            "Номер заказа: ${delivery?.deliveryId}"),
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
                              iconHeight: 48,
                              iconWidth: 48,
                              barThickness: 4,
                              activeIndex: 0,
                              activeBarColor: theme.primaryColor,
                              verticalGap: 32,
                              stepperDirection: Axis.vertical,
                              stepperList: [
                                StepperData(
                                  iconWidget: CircleAvatar(
                                    backgroundColor: theme.primaryColor,
                                    child: const Icon(Icons.local_shipping,
                                        color: Colors.white),
                                  ),
                                  title: StepperText(
                                    "Из",
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                  ),
                                  subtitle: StepperText(
                                    "${delivery?.cityFrom}",
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16),
                                  ),
                                ),
                                StepperData(
                                  iconWidget: CircleAvatar(
                                    backgroundColor: theme.hintColor,
                                    child: const Icon(Icons.inbox,
                                        color: Colors.white),
                                  ),
                                  title: StepperText(
                                    "Куда",
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                  ),
                                  subtitle: StepperText(
                                    "${delivery?.cityTo}",
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
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
                                    text:
                                        "${(delivery?.trackingList != null && delivery!.trackingList!.isNotEmpty) ? delivery?.trackingList?.last.status.name : "Неизвестно"}",
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
