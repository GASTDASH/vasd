import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
import 'package:vasd/ui/ui.dart';

class PackageInfoEditorScreen extends StatefulWidget {
  const PackageInfoEditorScreen({super.key});

  @override
  State<PackageInfoEditorScreen> createState() => _PackageInfoEditorScreenState();
}

class _PackageInfoEditorScreenState extends State<PackageInfoEditorScreen> {
  late final DeliveryBloc _deliveryBloc;
  Delivery? delivery;
  int? statusCode;

  @override
  void initState() {
    super.initState();

    _deliveryBloc = context.read<DeliveryBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (delivery == null) {
      var args = ModalRoute.of(context)!.settings.arguments;
      assert(args != null && args is Delivery, 'You must provide Delivery arg');
      delivery = args as Delivery;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<DeliveryBloc, DeliveryState>(
      bloc: _deliveryBloc,
      listener: (context, state) {
        if (state is DeliveryLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const LoadingDialog(),
          );
        } else if (state is DeliveryLoaded) {
          setState(() {
            delivery = state.deliveries.firstWhere((d) => d.deliveryId == delivery!.deliveryId);
          });
        }
      },
      listenWhen: (previous, current) {
        if (previous is DeliveryLoading) {
          Navigator.of(context).pop();
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Детали заказа",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        const Row(
                          children: [
                            Icon(Icons.numbers),
                            Text("ID заказа"),
                          ],
                        ),
                        Text("${delivery!.deliveryId}"),
                      ]),
                      TableRow(children: [
                        const Row(
                          children: [
                            Icon(Icons.upload),
                            Text("Город отправки"),
                          ],
                        ),
                        Text(delivery!.cityFrom),
                      ]),
                      TableRow(children: [
                        const Row(
                          children: [
                            Icon(Icons.download),
                            Text("Город назначения"),
                          ],
                        ),
                        Text(delivery!.cityTo),
                      ]),
                      TableRow(children: [
                        const Row(
                          children: [
                            Icon(Icons.directions_car),
                            Text("Расстояние (км)"),
                          ],
                        ),
                        Text("${delivery!.distance}"),
                      ]),
                      TableRow(children: [
                        const Row(
                          children: [
                            Icon(Icons.attach_money),
                            Text("Цена"),
                          ],
                        ),
                        Text("${delivery!.cost}"),
                      ]),
                      TableRow(children: [
                        const Row(
                          children: [
                            Icon(Icons.date_range),
                            Text("Дата создания"),
                          ],
                        ),
                        Text(delivery!.createdAt.toString()),
                      ]),
                      TableRow(children: [
                        const Row(
                          children: [
                            Icon(Icons.local_shipping),
                            Text("Способ доставки"),
                          ],
                        ),
                        Text(delivery!.deliveryVariant?.name ?? ""),
                      ]),
                      TableRow(children: [
                        const Row(
                          children: [
                            Icon(Icons.aspect_ratio),
                            Text("Размер посылки"),
                          ],
                        ),
                        Text(delivery!.packageSize?.size ?? ""),
                      ]),
                      // TableRow(children: [
                      //   const Text(""),
                      //   Text("${delivery.pointFrom}"),
                      // ]),
                      // TableRow(children: [
                      //   const Text(""),
                      //   Text("${delivery.pointTo}"),
                      // ]),
                      TableRow(children: [
                        const Text("ФИО получателя"),
                        Text(delivery!.receiverFIO ?? ""),
                      ]),
                      TableRow(children: [
                        const Text("Телефон получателя"),
                        Text(delivery!.receiverPhone ?? ""),
                      ]),
                      TableRow(children: [
                        const Text("ФИО отправителя"),
                        Text(delivery!.senderFIO ?? ""),
                      ]),
                      TableRow(children: [
                        const Text("Телефон отправителя"),
                        Text(delivery!.senderPhone ?? ""),
                      ]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Статус:"),
                      DropdownButton(
                        hint: const Text("Выберите статус"),
                        value: statusCode,
                        items: const [
                          DropdownMenuItem(
                            value: 2,
                            child: Text("Ожидание отправки"),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text("В пути"),
                          ),
                          DropdownMenuItem(
                            value: 4,
                            child: Text("Ожидает получения"),
                          ),
                          DropdownMenuItem(
                            value: 5,
                            child: Text("Получен"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            statusCode = value;
                          });
                        },
                      ),
                    ],
                  ),
                  (statusCode == 3)
                      ? const Column(
                          spacing: 12,
                          children: [
                            TextFieldCustom(hintText: "Широта"),
                            TextFieldCustom(hintText: "Долгота"),
                          ],
                        )
                      : const SizedBox.shrink(),
                  ButtonBase(
                    text: "Добавить статус",
                    onTap: statusCode != null
                        ? () {
                            _deliveryBloc.add(
                              DeliveryAddTracking(
                                statusCode: statusCode!,
                                delivery: delivery!,
                              ),
                            );
                          }
                        : null,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Список статусов отслеживания:", style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      delivery!.trackingList != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0; i < delivery!.trackingList!.length; i++)
                                    Text(
                                        "${i + 1}) ${delivery!.trackingList![i].status.name} (${delivery!.trackingList![i].updateTime.toString()})"),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
