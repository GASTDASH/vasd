import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/ui/ui.dart';

class PackagesEditorScreen extends StatefulWidget {
  const PackagesEditorScreen({super.key});

  @override
  State<PackagesEditorScreen> createState() => _PackagesEditorScreenState();
}

class _PackagesEditorScreenState extends State<PackagesEditorScreen> {
  late final DeliveryBloc deliveryBloc;
  bool isSearch = false;
  String? userId;
  DateTimeRange? dateTimeRange;
  bool isDescSort = false;
  final filterController = TextEditingController();

  @override
  void initState() {
    super.initState();

    deliveryBloc = context.read<DeliveryBloc>()..add(DeliveryLoadAll());
  }

  @override
  void dispose() {
    deliveryBloc.add(DeliveryLoad());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                deliveryBloc.add(DeliveryLoadAll());
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: const Text("Заказы"),
                    actions: [
                      IconButton(
                          onPressed: () => setState(() => isDescSort = !isDescSort),
                          icon: Icon(isDescSort ? Icons.filter_list : Icons.sort)),
                      // IconButton(onPressed: () => Navigator.of(context).pushNamed("/settings"), icon: const Icon(Icons.settings)),
                    ],
                  ),
                  SliverAppBar(
                    centerTitle: true,
                    title: BlocBuilder<DeliveryBloc, DeliveryState>(
                      builder: (context, state) {
                        return TextButton(
                            onPressed: () {
                              var users = state.deliveries.map((d) => d.userId).toSet().toList();
                              users.removeWhere((u) => u == null);

                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  insetPadding: const EdgeInsets.symmetric(vertical: 120, horizontal: 32),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: theme.scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(24),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                title: const Text(
                                                  "Убрать фильтр",
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                onTap: () => setState(() => userId = null),
                                              ),
                                              ...users.map(
                                                (user) => ListTile(
                                                  title: Text(user!),
                                                  onTap: () => setState(() => userId = user),
                                                ),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text("Выбрать пользователя"));
                      },
                    ),
                    leading: IconButton(
                        onPressed: dateTimeRange == null
                            ? () async {
                                dateTimeRange = await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime(2024),
                                  lastDate: DateTime.now(),
                                  saveText: "Выбрать",
                                );
                                setState(() {});
                              }
                            : () {
                                setState(() => dateTimeRange = null);
                              },
                        icon: Icon(dateTimeRange == null ? Icons.calendar_month : Icons.edit_calendar)),
                    actions: [
                      IconButton(
                        onPressed: () => setState(() => isSearch = !isSearch),
                        icon: const Icon(Icons.search),
                      ),
                    ],
                  ),
                  isSearch
                      ? SliverAppBar(
                          title: TextFieldCustom(
                            controller: filterController,
                            hintText: "Введите номер заказа или город",
                            onChanged: (_) => setState(() {}),
                          ),
                          toolbarHeight: 100,
                          leading: IconButton(
                            onPressed: () => setState(() => isSearch = !isSearch),
                            icon: const Icon(Icons.search_off),
                          ),
                        )
                      : const SliverToBoxAdapter(),
                  BlocBuilder<DeliveryBloc, DeliveryState>(
                    bloc: deliveryBloc,
                    builder: (context, state) {
                      if (state is DeliveryLoading) {
                        return const SliverToBoxAdapter(
                            child: Center(
                          child: SizedBox(
                            height: 300,
                            width: 100,
                            child: LoadingIndicator(indicatorType: Indicator.ballRotate),
                          ),
                        ));
                      } else if (state is DeliveryLoaded) {
                        var deliveries = state.deliveries;

                        deliveries.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

                        if (isDescSort) deliveries = deliveries.reversed.toList();

                        if (filterController.text.isNotEmpty) {
                          deliveries = deliveries
                              .where(
                                (d) =>
                                    d.deliveryId!.toLowerCase().contains(filterController.text.toLowerCase()) ||
                                    d.cityFrom.toLowerCase().contains(filterController.text.toLowerCase()) ||
                                    d.cityTo.toLowerCase().contains(filterController.text.toLowerCase()),
                              )
                              .toList();
                        }

                        if (dateTimeRange != null) {
                          deliveries = deliveries
                              .where(
                                (d) => dateTimeRange!.start.isBefore(d.createdAt!) && dateTimeRange!.end.isAfter(d.createdAt!),
                              )
                              .toList();
                        }

                        if (userId != null) {
                          deliveries = deliveries
                              .where(
                                (d) => d.userId == userId,
                              )
                              .toList();
                        }

                        return SliverList.builder(
                          itemCount: deliveries.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: DeliveryItemWidget(
                                isShowShadow: true,
                                delivery: deliveries[index],
                                onTap: () {
                                  Navigator.of(context).pushNamed("/package_info_editor", arguments: deliveries[index]);
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("Unknown State"));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
