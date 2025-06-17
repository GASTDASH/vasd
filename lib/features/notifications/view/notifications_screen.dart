import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/features/notifications/notifications.dart';
import 'package:vasd/main.dart';
import 'package:vasd/ui/ui.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final NotificationsBloc notificationsBloc;

  @override
  void initState() {
    super.initState();

    notificationsBloc = context.read<NotificationsBloc>()..add(NotificationsLoad());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<DeliveryBloc, DeliveryState>(
      listener: (context, state) {
        if (state is DeliveryFinding) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const LoadingDialog(),
          );
        }
      },
      listenWhen: (previous, current) {
        if (previous is DeliveryFinding) {
          Navigator.of(context).pop();

          if (current is DeliveryFound) {
            Navigator.pushNamed(
              context,
              "/package_info",
              arguments: current.delivery,
            );
          }
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Уведомления",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async => notificationsBloc.add(NotificationsLoad()),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: BlocBuilder<NotificationsBloc, NotificationsState>(
                bloc: notificationsBloc,
                builder: (context, state) {
                  if (state is NotificationsLoaded) {
                    if (state.notifications.isNotEmpty) {
                      return GroupedListView(
                        elements: state.notifications,
                        groupBy: (notification) => notification.createdAt.toString().split(' ')[0],
                        order: GroupedListOrder.DESC,
                        itemBuilder: (context, notification) => NotificationCard(
                          notification: notification,
                        ),
                        groupSeparatorBuilder: (date) {
                          return Padding(
                            padding: state.notifications.first.createdAt.toString().split(' ')[0] == date
                                ? EdgeInsets.zero
                                : const EdgeInsets.only(top: 16),
                            child: Text(
                              date == DateTime.now().toString().split(' ')[0]
                                  ? "Сегодня"
                                  : date == DateTime.now().subtract(const Duration(days: 1)).toString().split(' ')[0]
                                      ? "Вчера"
                                      : dateToString(date),
                              style: theme.textTheme.bodyLarge,
                            ),
                          );
                        },
                      );
                    }
                    return Column(
                      spacing: 12,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("У вас нет уведомлений", style: theme.textTheme.headlineSmall),
                        const Icon(
                          Icons.notifications_none,
                          size: 48,
                        ),
                      ],
                    );
                  } else if (state is NotificationsLoading) {
                    return const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Center(
                            child: SizedBox(
                              height: 200,
                              child: LoadingIndicator(indicatorType: Indicator.ballPulse),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is NotificationsError) {
                    String errorText = state.error.toString();

                    return ErrorBanner(
                        errorText: errorText.contains("host")
                            ? "Ошибка соединения с сервером\n(${(state.error as SocketException).message})"
                            : errorText);
                  } else {
                    return const Text("Unexpected state");
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
