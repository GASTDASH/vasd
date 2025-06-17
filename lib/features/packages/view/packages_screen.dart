import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/ui/ui.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  late final DeliveryBloc _deliveryBloc;

  @override
  void initState() {
    super.initState();

    _deliveryBloc = context.read<DeliveryBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "История заказов",
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _deliveryBloc.add(DeliveryLoad());
          },
          child: CustomScrollView(
            slivers: [
              BlocBuilder<DeliveryBloc, DeliveryState>(
                bloc: _deliveryBloc,
                builder: (context, state) {
                  if (state is DeliveryLoaded || (state is DeliveryError && state.deliveries.isNotEmpty)) {
                    if (state.deliveries.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: Column(
                              children: [
                                Text(
                                  "У вас ещё не было заказов",
                                  style: TextStyle(fontSize: 24),
                                ),
                                Icon(Icons.no_sim_outlined),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    final deliveries = state.deliveries.reversed.toList();
                    return SliverMainAxisGroup(
                      slivers: [
                        if (state is DeliveryError)
                          const SliverToBoxAdapter(
                            child: ErrorBanner(errorText: "Не удалось подключиться к серверу, но вы можете просмотреть сохранённые заказы"),
                          ),
                        SliverList.builder(
                          itemCount: deliveries.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: DeliveryItemWidget(
                                isShowShadow: true,
                                delivery: deliveries[index],
                                onTap: () {
                                  Navigator.of(context).pushNamed("/package_info", arguments: deliveries[index]);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else if (state is DeliveryLoading) {
                    return SliverList.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ShimmerCustom(height: 150),
                        );
                      },
                    );
                  } else if (state is DeliveryError) {
                    String errorText = state.error.toString();

                    return SliverToBoxAdapter(
                      child: ErrorBanner(
                          errorText: errorText.contains("host")
                              ? "Ошибка соединения с сервером\n(${(state.error as SocketException).message})"
                              : errorText),
                    );
                  }
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("Unhandled state"),
                    ),
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        ),
      ),
    );
  }
}
