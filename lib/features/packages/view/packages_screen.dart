import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/ui/widgets/delivery_item_widget.dart';
import 'package:vasd/ui/widgets/shimmer_custom.dart';

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
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
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
                  if (state is DeliveryLoaded) {
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
                    return SliverList.builder(
                      itemCount: deliveries.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: DeliveryItemWidget(
                            isShowShadow: true,
                            delivery: deliveries[index],
                            onTap: () {
                              Navigator.of(context).pushNamed("/package_info",
                                  arguments: deliveries[index]);
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is DeliveryLoading) {
                    return SliverList.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ShimmerCustom(height: 150),
                        );
                      },
                    );
                  } else if (state is DeliveryError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text("Error:\n${state.error}"),
                      ),
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
