import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vasd/features/calculate/bloc/calculate_bloc.dart';
import 'package:vasd/features/calculate/calculate.dart';
import 'package:vasd/repositories/address_completer/address_completer.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';
import 'package:vasd/repositories/package_size/package_size_local_repo.dart';
import 'package:vasd/repositories/payment_method/payment_method_local_repo.dart';
import 'package:vasd/ui/ui.dart';
import 'package:vasd/ui/widgets/intl_phone_field_custom.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  final _bloc = CalculateBloc();

  final senderFIOController = TextEditingController();
  final senderPhoneController = TextEditingController();
  final receiverFIOController = TextEditingController();
  final receiverPhoneController = TextEditingController();

  // double calculateCost({
  //   PackageSize? packageSize,
  //   required double distance,
  //   DeliveryVariant? variant,
  // }) {
  //   double packageVolume = 0;

  //   if (packageSize != null) {
  //     final sizes = packageSize.size
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

  //   double cost = (((distance * (variant?.distanceRate ?? 0)) +
  //                   (packageVolume * (variant?.packageVolumeRate ?? 0))) *
  //               100)
  //           .roundToDouble() /
  //       100;

  //   return cost;
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stepStyle = StepStyle(
      color: theme.primaryColor,
      connectorColor: theme.primaryColor,
    );

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // TODO: Сохранить черновик
          GetIt.I<Talker>().debug("Popped");
        }
      },
      child: BlocListener<CalculateBloc, CalculateState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is CalculateCalculating) {
            showDialog(
                context: context, builder: (context) => const LoadingDialog());
          }
        },
        listenWhen: (previous, current) {
          if (previous is CalculateCalculating) {
            Navigator.of(context).pop();
          }
          return true;
        },
        child: BlocBuilder<CalculateBloc, CalculateState>(
          bloc: _bloc,
          builder: (context, state) {
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
                bottomNavigationBar: state.currentStep >= 1
                    ? Container(
                        height: 250,
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
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      "${state.delivery.cityFrom} →\n${state.delivery.cityTo}",
                                      style: theme.textTheme.titleMedium,
                                      maxLines: 3,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(Icons.shopping_bag_outlined,
                                            color: theme.hintColor),
                                        Expanded(
                                          child: Text(
                                            state.delivery.packageSize != null
                                                ? "${state.delivery.packageSize!.size} (${state.delivery.packageSize!.title})"
                                                : "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                    color: theme.hintColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Expanded(child: SizedBox.expand()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            state.delivery.senderFIO != null
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Отправитель:",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                          "${state.delivery.senderFIO}"),
                                                    ],
                                                  )
                                                : const SizedBox.shrink(),
                                            state.delivery.receiverFIO != null
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Получатель:",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                          "${state.delivery.receiverFIO}"),
                                                    ],
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(state.delivery.deliveryVariant
                                                    ?.name ??
                                                ""),
                                            Text(
                                              "${state.delivery.cost}₽",
                                              style:
                                                  theme.textTheme.headlineLarge,
                                            ),
                                          ],
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
                        connectorThickness: 2,
                        currentStep: state.currentStep,
                        physics: const NeverScrollableScrollPhysics(),
                        controlsBuilder: (context, details) => const Row(),
                        onStepTapped: (tappedStep) {
                          if (state.currentStep > tappedStep) {
                            _bloc.add(
                                CalculateStepTapped(tappedStep: tappedStep));
                          }
                        },
                        steps: [
                          Step(
                              isActive: state.currentStep >= 0,
                              stepStyle:
                                  state.currentStep >= 0 ? stepStyle : null,
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
                                    onSelected: (option) => _bloc.add(
                                        CalculateSetCity(cityFrom: option)),
                                    fieldViewBuilder: (context,
                                        textEditingController,
                                        focusNode,
                                        onFieldSubmitted) {
                                      return TextFieldCustom(
                                        onEditingComplete: onFieldSubmitted,
                                        focusNode: focusNode,
                                        label: "Откуда",
                                        controller: textEditingController,
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
                                    onSelected: (option) => _bloc
                                        .add(CalculateSetCity(cityTo: option)),
                                    fieldViewBuilder: (context,
                                        textEditingController,
                                        focusNode,
                                        onFieldSubmitted) {
                                      return TextFieldCustom(
                                        onEditingComplete: onFieldSubmitted,
                                        focusNode: focusNode,
                                        label: "Куда",
                                        controller: textEditingController,
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
                                          await PackageSizeLocalRepo()
                                              .getItems();

                                      final PackageSize? packageSize =
                                          await showDialog(
                                        // ignore: use_build_context_synchronously
                                        context: context,
                                        builder: (context) => PackageSizeDialog(
                                          packageSizes: packageSizes,
                                        ),
                                      );

                                      if (packageSize != null) {
                                        _bloc.add(CalculateSetPackageSize(
                                            packageSize: packageSize));
                                      }
                                    },
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.black54),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      height: 62,
                                      width: MediaQuery.of(context).size.width,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            state.delivery.packageSize != null
                                                ? state
                                                    .delivery.packageSize!.title
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
                                    onTap: state.delivery.cityFrom.isNotEmpty &&
                                            state.delivery.cityTo.isNotEmpty &&
                                            state.delivery.packageSize != null
                                        ? () async {
                                            // TODO: Возможно переделать в отдельный Event (связанный с расчётом)
                                            _bloc.add(CalculateContinue());
                                          }
                                        : null,
                                  ),
                                ],
                              )),
                          Step(
                            isActive: state.currentStep >= 1,
                            stepStyle:
                                state.currentStep >= 1 ? stepStyle : null,
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
                                    for (var variant
                                        in state.deliveryVariantList)
                                      DeliveryVariantCard(
                                        name: variant.name,
                                        minCost: state.delivery.calculateCost(
                                          distance: state.delivery.distance,
                                          packageSize:
                                              state.delivery.packageSize,
                                          variant: variant,
                                        ),
                                        minDays: variant.minDays,
                                        maxDays: variant.maxDays,
                                        description: variant.description,
                                        onTap: () {
                                          _bloc.add(CalculateSetDeliveryVariant(
                                            deliveryVariant: variant,
                                          ));
                                        },
                                        selected:
                                            state.delivery.deliveryVariant ==
                                                variant,
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Step(
                            isActive: state.currentStep >= 2,
                            stepStyle:
                                state.currentStep >= 2 ? stepStyle : null,
                            title: Text(
                              "Что ещё понадобится?",
                              style: theme.textTheme.titleLarge,
                            ),
                            content: Column(
                              spacing: 14,
                              children: [
                                const SizedBox(height: 12),
                                const AdditionalFuncCard(),
                                const AdditionalFuncCard(),
                                const AdditionalFuncCard(),
                                const AdditionalFuncCard(),
                                ButtonBase(
                                  text: "Продолжить",
                                  onTap: () {
                                    // TODO
                                    _bloc.add(CalculateContinue());
                                  },
                                ),
                              ],
                            ),
                          ),
                          Step(
                            isActive: state.currentStep >= 3,
                            stepStyle:
                                state.currentStep >= 3 ? stepStyle : null,
                            title: Text(
                              "Данные отправителя",
                              style: theme.textTheme.titleLarge,
                            ),
                            content: Column(
                              spacing: 12,
                              children: [
                                const SizedBox(height: 12),
                                TextFieldCustom(
                                  hintText: "ФИО полностью",
                                  controller: senderFIOController,
                                  onChanged: (_) => setState(() {}),
                                ),
                                IntlPhoneFieldCustom(
                                  controller: senderPhoneController,
                                  onChanged: (_) => setState(() {}),
                                ),
                                ButtonBase(
                                  text: "Продолжить",
                                  onTap: senderFIOController.text.isNotEmpty &&
                                          senderPhoneController.text.length ==
                                              10
                                      ? () {
                                          _bloc.add(CalculateSetSenderInfo(
                                              fio: senderFIOController.text,
                                              phone:
                                                  senderPhoneController.text));
                                        }
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          Step(
                            isActive: state.currentStep >= 4,
                            stepStyle:
                                state.currentStep >= 4 ? stepStyle : null,
                            title: Text(
                              "Данные получателя",
                              style: theme.textTheme.titleLarge,
                            ),
                            content: Column(
                              spacing: 12,
                              children: [
                                const SizedBox(height: 12),
                                TextFieldCustom(
                                  hintText: "ФИО полностью",
                                  controller: receiverFIOController,
                                  onChanged: (_) => setState(() {}),
                                ),
                                IntlPhoneFieldCustom(
                                  controller: receiverPhoneController,
                                  onChanged: (_) => setState(() {}),
                                ),
                                ButtonBase(
                                  text: "Продолжить",
                                  onTap: receiverFIOController
                                              .text.isNotEmpty &&
                                          receiverPhoneController.text.length ==
                                              10
                                      ? () {
                                          _bloc.add(CalculateSetReceiverInfo(
                                              fio: receiverFIOController.text,
                                              phone: receiverPhoneController
                                                  .text));
                                        }
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          Step(
                            isActive: state.currentStep >= 5,
                            stepStyle:
                                state.currentStep >= 5 ? stepStyle : null,
                            title: Text(
                              "Отправка",
                              style: theme.textTheme.titleLarge,
                            ),
                            content: Builder(builder: (context) {
                              final paymentMethodList =
                                  GetIt.I<PaymentMethodLocalRepo>()
                                      .getPaymentMethods();

                              return Column(
                                spacing: 12,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Выбор способа оплаты",
                                    style: theme.textTheme.titleLarge,
                                  ),
                                  ...paymentMethodList
                                      .map((method) => PaymentMethodCard(
                                            paymentMethod: method,
                                            selected:
                                                state.paymentMethod == method,
                                            onTap: () {
                                              _bloc.add(
                                                CalculateSetPaymentMethod(
                                                  paymentMethod: method,
                                                ),
                                              );
                                            },
                                          ))
                                      .toList()
                                      .expand((element) =>
                                          [element, const Divider(height: 0)])
                                      .toList()
                                    ..removeLast(),
                                  ButtonBase(
                                    text: "Оплатить",
                                    onTap: state.paymentMethod != null
                                        ? () {
                                            // TODO: Пипец
                                            Navigator.of(context).pushNamed(
                                              "/payment",
                                              arguments: state.delivery,
                                            );
                                          }
                                        : null,
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
