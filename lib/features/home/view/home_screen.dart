import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:vasd/features/home/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.mail_outlined),
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
                                  child: const Icon(
                                    Icons.qr_code,
                                    color: Colors.white,
                                    size: 34,
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
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
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
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 4),
                                      const Icon(Icons.mail_outline),
                                      const SizedBox(width: 12),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "MacBook Pro 13'' (Серый)",
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w800),
                                          ),
                                          const Text(
                                              "Номер заказа: UO8765487CE"),
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
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                    subtitle: StepperText(
                                      "Орехово-Зуево, Россия",
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16),
                                    ),
                                  ),
                                  StepperData(
                                    iconWidget: const CircleAvatar(
                                      backgroundColor: Colors.black,
                                    ),
                                    title: StepperText(
                                      "Куда",
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                    subtitle: StepperText(
                                      "Екатеринбург, Россия",
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16),
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
                                          ?.copyWith(
                                              fontWeight: FontWeight.w800),
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
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Услуги",
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
                      child: SizedBox(
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/send_package");
                                },
                                borderRadius: BorderRadius.circular(18),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.mail_outline,
                                        size: 48,
                                        color: theme.primaryColor,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        "Отправить",
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(18),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.place_outlined,
                                        size: 48,
                                        color: theme.primaryColor,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        "Отследить",
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Последние посылки",
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
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          RecentPackageWidget(),
                          SizedBox(height: 24),
                          RecentPackageWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }
}
