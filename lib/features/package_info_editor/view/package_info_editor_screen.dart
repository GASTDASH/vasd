import 'package:flutter/material.dart';
import 'package:vasd/repositories/delivery/models/delivery.dart';
import 'package:vasd/ui/ui.dart';

class PackageInfoEditorScreen extends StatefulWidget {
  const PackageInfoEditorScreen({super.key});

  @override
  State<PackageInfoEditorScreen> createState() =>
      _PackageInfoEditorScreenState();
}

class _PackageInfoEditorScreenState extends State<PackageInfoEditorScreen> {
  int? statusId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final delivery = ModalRoute.of(context)!.settings.arguments;
    assert(delivery != null && delivery is Delivery,
        'You must provide Delivery arg');
    delivery as Delivery;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Детали заказа",
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
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
                    Text("${delivery.deliveryId}"),
                  ]),
                  TableRow(children: [
                    const Row(
                      children: [
                        Icon(Icons.upload),
                        Text("Город отправки"),
                      ],
                    ),
                    Text(delivery.cityFrom),
                  ]),
                  TableRow(children: [
                    const Row(
                      children: [
                        Icon(Icons.download),
                        Text("Город назначения"),
                      ],
                    ),
                    Text(delivery.cityTo),
                  ]),
                  TableRow(children: [
                    const Row(
                      children: [
                        Icon(Icons.directions_car),
                        Text("Расстояние (км)"),
                      ],
                    ),
                    Text("${delivery.distance}"),
                  ]),
                  TableRow(children: [
                    const Row(
                      children: [
                        Icon(Icons.attach_money),
                        Text("Цена"),
                      ],
                    ),
                    Text("${delivery.cost}"),
                  ]),
                  TableRow(children: [
                    const Row(
                      children: [
                        Icon(Icons.date_range),
                        Text("Дата создания"),
                      ],
                    ),
                    Text(delivery.createdAt.toString()),
                  ]),
                  TableRow(children: [
                    const Row(
                      children: [
                        Icon(Icons.local_shipping),
                        Text("Способ доставки"),
                      ],
                    ),
                    Text(delivery.deliveryVariant?.name ?? ""),
                  ]),
                  TableRow(children: [
                    const Row(
                      children: [
                        Icon(Icons.aspect_ratio),
                        Text("Размер посылки"),
                      ],
                    ),
                    Text(delivery.packageSize?.size ?? ""),
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
                    Text(delivery.receiverFIO ?? ""),
                  ]),
                  TableRow(children: [
                    const Text("Телефон получателя"),
                    Text(delivery.receiverPhone ?? ""),
                  ]),
                  TableRow(children: [
                    const Text("ФИО отправителя"),
                    Text(delivery.senderFIO ?? ""),
                  ]),
                  TableRow(children: [
                    const Text("Телефон отправителя"),
                    Text(delivery.senderPhone ?? ""),
                  ]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Статус:"),
                  DropdownButton(
                    hint: const Text("Выберите статус"),
                    value: statusId,
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
                        statusId = value;
                      });
                    },
                  ),
                ],
              ),
              (statusId == 3)
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
                onTap: statusId != null ? () {} : null,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Список статусов отслеживания:",
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  delivery.trackingList != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < delivery.trackingList!.length;
                                  i++)
                                Text(
                                    "${i + 1}) ${delivery.trackingList![i].status.name} (${delivery.trackingList![i].updateTime.toString()})"),
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
    );
  }
}
