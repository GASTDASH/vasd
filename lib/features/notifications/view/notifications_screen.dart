import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:vasd/features/notifications/notifications.dart';

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

    return SafeArea(
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
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var notification in state.notifications)
                            NotificationCard(
                              notification: notification,
                            ),
                        ],
                      ),
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
                  return Column(
                    spacing: 12,
                    children: [
                      const Icon(
                        Icons.warning_amber,
                        size: 48,
                      ),
                      Text(
                        "Что-то пошло не так!",
                        style: theme.textTheme.headlineSmall,
                      ),
                      Text(state.error.toString())
                    ],
                  );
                } else {
                  return const Text("Unexpected state");
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
