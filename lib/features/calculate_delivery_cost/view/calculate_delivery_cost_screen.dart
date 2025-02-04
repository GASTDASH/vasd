import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vasd/features/calculate_delivery_cost/cubit/calculate_delivery_cost_cubit.dart';
import 'package:vasd/features/calculate_delivery_cost/widgets/package_size_dialog.dart';
import 'package:vasd/repositories/address_completer/address_completer.dart';
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
  // final _calculateDeliveryCostBloc = CalculateDeliveryCostBloc();
  final _cubit = CalculateDeliveryCostCubit();

  final cityFromController = TextEditingController();
  String cityFromText = "";
  final cityToController = TextEditingController();
  String cityToText = "";

  // PackageSize? selectedPackageSize;
  // int currentStep = 0;
  // List<String> addresses = [];
  // List<DeliveryVariant> deliveryVariantList = [];

  // Стоимость доставки = (Расстояние * Тариф за километр) + (Объем * Тариф за объем) + Дополнительные расходы
  // cost = (distance * distanceRate) + (packageVolume * packageVolumeRate) + additionalCost

  // double cost = 0;
  // double distance = 0;
  // static const double distanceRate = 0;
  // double packageVolume = 0;
  // static const double packageVolumeRate = 0.1;
  // double additionalCost = 0;

  // "34x27x2 см, до 0.5 кг"
  // TODO: Пернести в Кубит
  // void calculateCost() {
  //   if (selectedPackageSize == null) {
  //     packageVolume = 0;
  //   } else {
  //     final sizes = selectedPackageSize!.size
  //         .split(' ')
  //         .first
  //         .split('x')
  //         .map((e) => double.parse(e))
  //         .toList();

  //     packageVolume = 1;
  //     for (var size in sizes) {
  //       packageVolume *= size;
  //     }
  //   }

  //   cost = (((distance * distanceRate) +
  //                   (packageVolume * packageVolumeRate) +
  //                   additionalCost) *
  //               1000)
  //           .roundToDouble() /
  //       1000;
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stepStyle = StepStyle(
      color: theme.primaryColor,
      connectorColor: theme.primaryColor,
    );

    return BlocBuilder<CalculateDeliveryCostCubit, CalculateDeliveryCostState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is CalculateDeliveryCostLoaded) {
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
              bottomNavigationBar: state.step >= 1
                  ? Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(32)),
                        boxShadow: [
                          BoxShadow(color: Colors.black38, blurRadius: 10)
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
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
                                    "$cityFromText →\n$cityToText",
                                    style: theme.textTheme.titleMedium,
                                    maxLines: 3,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.shopping_bag_outlined,
                                          color: theme.hintColor),
                                      Text(
                                        state.packageSize != null
                                            ? state.packageSize!.size
                                            : "",
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(color: theme.hintColor),
                                      ),
                                    ],
                                  ),
                                  const Expanded(child: SizedBox.expand()),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        state.cost != 0 ? "${state.cost}₽" : "",
                                        style: theme.textTheme.headlineLarge,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                      currentStep: state.step,
                      physics: const NeverScrollableScrollPhysics(),
                      controlsBuilder: (context, details) => const Row(),
                      onStepTapped: (value) => setState(() {
                        if (state.step > value) {
                          // state.step = value;
                          // TODO: Тут говно переделать надо в Кубит
                        }
                      }),
                      steps: [
                        Step(
                            isActive: state.step >= 0,
                            stepStyle: state.step >= 0 ? stepStyle : null,
                            title: Text(
                              "Основные параметры",
                              style: theme.textTheme.titleLarge,
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12),
                                Autocomplete<String>(
                                  optionsBuilder: (textEditingValue) async {
                                    return await GetIt.I<
                                            AddressCompleterInterface>()
                                        .getAddresses(textEditingValue.text);
                                  },
                                  onSelected: (option) =>
                                      setState(() => cityFromText = option),
                                  fieldViewBuilder: (context,
                                      textEditingController,
                                      focusNode,
                                      onFieldSubmitted) {
                                    return TextFieldCustom(
                                      onEditingComplete: onFieldSubmitted,
                                      focusNode: focusNode,
                                      label: "Откуда",
                                      controller: textEditingController,
                                      onChanged: (_) => setState(() {}),
                                    );
                                  },
                                ),
                                const SizedBox(height: 12),
                                Autocomplete<String>(
                                  optionsBuilder: (textEditingValue) async {
                                    return await GetIt.I<
                                            AddressCompleterInterface>()
                                        .getAddresses(textEditingValue.text);
                                  },
                                  onSelected: (option) =>
                                      setState(() => cityToText = option),
                                  fieldViewBuilder: (context,
                                      textEditingController,
                                      focusNode,
                                      onFieldSubmitted) {
                                    return TextFieldCustom(
                                      onEditingComplete: onFieldSubmitted,
                                      focusNode: focusNode,
                                      label: "Куда",
                                      controller: textEditingController,
                                      onChanged: (_) => setState(() {}),
                                    );
                                  },
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
                                    // TODO: Возможно всё это в Кубит
                                    // TODO: Возможно можно вместо состояния Loading сделать Transition, а здесь вызывать состояние SelectingPackageSize

                                    final packageSizes =
                                        await PackageSizeLocalRepo().getItems();

                                    final PackageSize? packageSize =
                                        await showDialog(
                                      context: context,
                                      builder: (context) => PackageSizeDialog(
                                        packageSizes: packageSizes,
                                      ),
                                    );

                                    if (packageSize != null) {
                                      // setState(() =>
                                      //     selectedPackageSize = packageSize);
                                      // TODO: Здесь нужен Кубит
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
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          state.packageSize != null
                                              ? state.packageSize!.title
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
                                  text: "Рассчитать",
                                  onTap: cityFromText.isNotEmpty &&
                                          cityToText.isNotEmpty &&
                                          state.packageSize != null
                                      ? () async {
                                          // distance = 1733;
                                          // deliveryVariantList = await GetIt.I<
                                          //         DeliveryVariantLocalRepo>()
                                          //     .getDeliveryVariantList();

                                          // setState(() => state.step = 1);

                                          // _calculateDeliveryCostBloc.add(
                                          //     CalculateDeliveryCostGetDistanceEvent(
                                          //         addresses: addresses,
                                          //         packageSize:
                                          //             selectedPackageSize!));

                                          _cubit.changeStep(
                                            nextStep: 1,
                                            previousStep: state.step,
                                          );
                                        }
                                      : null,
                                ),
                              ],
                            )),
                        Step(
                          isActive: state.step >= 1,
                          stepStyle: state.step >= 1 ? stepStyle : null,
                          title: Text(
                            "Выбор услуги",
                            style: theme.textTheme.titleLarge,
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              Column(
                                spacing: 12,
                                children: [
                                  for (var variant in state.deliveryVariantList)
                                    typeCard(
                                      minCost:
                                          state.distance * variant.distanceRate,
                                      minDays: variant.minDays,
                                      maxDays: variant.maxDays,
                                      description: variant.description,
                                      onTap: () => setState(() {
                                        // calculateCost(); // TODO: Должно быть перенесено в Кубит

                                        // state.step = 2;
                                      }),
                                    ),
                                  // typeCard(
                                  //   minCost: 400,
                                  //   minDays: 3,
                                  //   maxDays: 5,
                                  //   description: "Только из пункта в пункт СДЭК",
                                  //   onTap: () => setState(() {
                                  //     calculateCost();

                                  //     state.step = 2;
                                  //   }),
                                  // ),
                                  // const SizedBox(width: 12, height: 12),
                                  // typeCard(
                                  //   minCost: 680,
                                  //   minDays: 2,
                                  //   maxDays: 3,
                                  //   description: "Можно вызвать курьера",
                                  //   onTap: () => setState(() {
                                  //     calculateCost();

                                  //     state.step = 2;
                                  //   }),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Step(
                          isActive: state.step >= 2,
                          stepStyle: state.step >= 2 ? stepStyle : null,
                          title: Text(
                            "Что ещё понадобится?",
                            style: theme.textTheme.titleLarge,
                          ),
                          content: Column(
                            children: [
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        // setState(() => state.step = 3);
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 5,
                                              color: Colors.black12,
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Text("data"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Step(
                          isActive: state.step >= 3,
                          stepStyle: state.step >= 3 ? stepStyle : null,
                          title: Text(
                            "Данные отправителя",
                            style: theme.textTheme.titleLarge,
                          ),
                          content: const Column(
                            children: [],
                          ),
                        ),
                        Step(
                          isActive: state.step >= 4,
                          stepStyle: state.step >= 4 ? stepStyle : null,
                          title: Text(
                            "Данные получателя",
                            style: theme.textTheme.titleLarge,
                          ),
                          content: const Column(
                            children: [],
                          ),
                        ),
                        Step(
                          isActive: state.step >= 5,
                          stepStyle: state.step >= 5 ? stepStyle : null,
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
        } else if (state is CalculateDeliveryCostLoading) {
          return const LoadingScreen(title: "Test");
        } else {
          return const Scaffold();
        }
      },
    );
  }

  Widget typeCard({
    required double minCost,
    required int minDays,
    required int maxDays,
    String? description,
    required void Function() onTap,
  }) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Ink(
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(18),
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
                          "от ${minCost.truncate()} ₽",
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
                      description ?? "",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
