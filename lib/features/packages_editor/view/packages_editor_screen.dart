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
                          onPressed: () {}, icon: const Icon(Icons.sort)),
                      IconButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed("/settings"),
                          icon: const Icon(Icons.settings)),
                    ],
                  ),
                  SliverAppBar(
                    centerTitle: true,
                    title: TextButton(
                        onPressed: () {},
                        child: const Text("Выбрать пользователя")),
                    leading: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.qr_code)),
                    actions: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search)),
                    ],
                  ),
                  BlocBuilder<DeliveryBloc, DeliveryState>(
                    bloc: deliveryBloc,
                    builder: (context, state) {
                      if (state is DeliveryLoading) {
                        return const SliverToBoxAdapter(
                            child: Center(
                          child: SizedBox(
                            height: 300,
                            width: 100,
                            child: LoadingIndicator(
                                indicatorType: Indicator.ballRotate),
                          ),
                        ));
                      } else if (state is DeliveryLoaded) {
                        var deliveries = state.deliveries;
                        deliveries.sort(
                            (a, b) => b.createdAt!.compareTo(a.createdAt!));
                        return SliverList.builder(
                          itemCount: deliveries.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: DeliveryItemWidget(
                                isShowShadow: true,
                                delivery: state.deliveries[index],
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      "/package_info_editor",
                                      arguments: state.deliveries[index]);
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
