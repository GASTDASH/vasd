import 'package:flutter/material.dart';
import 'package:vasd/features/calculate_delivery_cost/widgets/package_size_dialog.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';
import 'package:vasd/repositories/package_size/package_size_local_repo.dart';
import 'package:vasd/ui/ui.dart';

class CalculateDeliveryCostScreen extends StatefulWidget {
  const CalculateDeliveryCostScreen({super.key});

  @override
  State<CalculateDeliveryCostScreen> createState() =>
      _CalculateDeliveryCostScreenState();
}

class _CalculateDeliveryCostScreenState
    extends State<CalculateDeliveryCostScreen> {
  final cityFromController = TextEditingController();
  final cityToController = TextEditingController();
  PackageSize? selectedPackageSize;

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stepStyle = StepStyle(
      color: theme.primaryColor,
      connectorColor: theme.primaryColor,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left_rounded, size: 40),
          ),
          title: Text(
            "Рассчитать доставку",
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: currentStep >= 1
            ? Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 10)],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ваш расчёт",
                            style: theme.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "${cityFromController.text} → ${cityToController.text}",
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.shopping_bag_outlined,
                                  color: theme.hintColor),
                              Text(
                                selectedPackageSize != null
                                    ? selectedPackageSize!.size
                                    : "",
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(color: theme.hintColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : null,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stepper(
                currentStep: currentStep,
                physics: const NeverScrollableScrollPhysics(),
                controlsBuilder: (context, details) => const Row(),
                onStepTapped: (value) => setState(() {
                  if (currentStep > value) {
                    currentStep = value;
                  }
                }),
                steps: [
                  Step(
                      isActive: currentStep >= 0,
                      stepStyle: currentStep >= 0 ? stepStyle : null,
                      title: Text(
                        "Основные параметры",
                        style: theme.textTheme.titleLarge,
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          TextFieldCustom(
                            label: "Откуда",
                            controller: cityFromController,
                          ),
                          const SizedBox(height: 12),
                          TextFieldCustom(
                            label: "Куда",
                            controller: cityToController,
                          ),
                          const SizedBox(height: 32),
                          Text(
                            "Вес и размер посылки",
                            style: theme.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 12),
                          InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () async {
                              final packageSizes =
                                  await PackageSizeLocalRepo().getItems();

                              final PackageSize? packageSize = await showDialog(
                                context: context,
                                builder: (context) => PackageSizeDialog(
                                  packageSizes: packageSizes,
                                ),
                              );

                              if (packageSize != null) {
                                setState(
                                    () => selectedPackageSize = packageSize);
                              }
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black54),
                                  borderRadius: BorderRadius.circular(4)),
                              height: 62,
                              width: MediaQuery.of(context).size.width,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    selectedPackageSize != null
                                        ? selectedPackageSize!.title
                                        : "Размер посылки",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          ButtonBase(
                            onTap: cityFromController.text.isNotEmpty &&
                                    cityToController.text.isNotEmpty &&
                                    selectedPackageSize != null
                                ? () {
                                    setState(() => currentStep = 1);
                                  }
                                : null,
                            text: "Рассчитать",
                          ),
                        ],
                      )),
                  Step(
                    isActive: currentStep >= 1,
                    stepStyle: currentStep >= 1 ? stepStyle : null,
                    title: Text(
                      "Выбор услуги",
                      style: theme.textTheme.titleLarge,
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            typeCard(
                              minCost: 400,
                              minDays: 3,
                              maxDays: 5,
                              description: "Только из пункта в пункт СДЭК",
                            ),
                            const SizedBox(width: 12),
                            typeCard(
                              minCost: 680,
                              minDays: 2,
                              maxDays: 3,
                              description: "Можно вызвать курьера",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Step(
                    isActive: currentStep >= 2,
                    stepStyle: currentStep >= 2 ? stepStyle : null,
                    title: Text(
                      "Что ещё понадобится?",
                      style: theme.textTheme.titleLarge,
                    ),
                    content: const Column(
                      children: [],
                    ),
                  ),
                  Step(
                    isActive: currentStep >= 3,
                    stepStyle: currentStep >= 3 ? stepStyle : null,
                    title: Text(
                      "Выбор оформителя",
                      style: theme.textTheme.titleLarge,
                    ),
                    content: const Column(
                      children: [],
                    ),
                  ),
                  Step(
                    isActive: currentStep >= 4,
                    stepStyle: currentStep >= 4 ? stepStyle : null,
                    title: Text(
                      "Данные отправителя",
                      style: theme.textTheme.titleLarge,
                    ),
                    content: const Column(
                      children: [],
                    ),
                  ),
                  Step(
                    isActive: currentStep >= 5,
                    stepStyle: currentStep >= 5 ? stepStyle : null,
                    title: Text(
                      "Данные получателя",
                      style: theme.textTheme.titleLarge,
                    ),
                    content: const Column(
                      children: [],
                    ),
                  ),
                  Step(
                    isActive: currentStep >= 6,
                    stepStyle: currentStep >= 6 ? stepStyle : null,
                    title: Text(
                      "Отправка",
                      style: theme.textTheme.titleLarge,
                    ),
                    content: const Column(
                      children: [],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded typeCard({
    required int minCost,
    required int minDays,
    required int maxDays,
    required String description,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Ink(
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 10),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "от $minCost ₽",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$minDays-$maxDays рабочих дней",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
