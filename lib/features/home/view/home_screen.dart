import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Ваше местоположение"),
                        SizedBox(
                          width: 250,
                          child: Text(
                            "Орехово-Зуево, Московская обл.",
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
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
        ),
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
                              const SizedBox(width: 10),
                              Container(
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
                        height: 300,
                        decoration: BoxDecoration(
                            color: theme.hintColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(18)),
                        child: Column(
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
                            const EasyStepper(
                              activeStep: 1,
                              direction: Axis.vertical,
                              stepRadius: 10,
                              lineStyle: LineStyle(
                                lineType: LineType.dotted,
                              ),
                              steps: [
                                EasyStep(
                                  customStep: SizedBox.shrink(),
                                ),
                                EasyStep(customStep: SizedBox.shrink()),
                              ],
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
                          "Our Service",
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("View All",
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: theme.primaryColor)),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: SizedBox(
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Placeholder(),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: SizedBox(
                                child: Placeholder(),
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
                          "Recent Packages",
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("View All",
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: theme.primaryColor)),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 90,
                            child: Placeholder(),
                          ),
                          SizedBox(height: 24),
                          SizedBox(
                            height: 90,
                            child: Placeholder(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
