import 'package:flutter/material.dart';
import 'package:vasd/features/notifications/widgets/notification_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Уведомления",
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Сегодня", style: TextStyle(color: theme.hintColor)),
                const NotificationCard(
                  title: "Посылка готова к отправке",
                  text: "Ваша посылка скоро будет отправлена из [...] в [...]",
                  icon: Icons.mail_outline,
                ),
                const NotificationCard(
                  title: "Посылка была отправлена",
                  text:
                      "Ваша посылка была отправлена из [...] и скоро будет будет в [...]",
                  icon: Icons.local_shipping_outlined,
                ),
                const NotificationCard(
                  title: "Посылка была доставлена",
                  text: "Ваша посылка была успешно доставлена в [...]",
                  icon: Icons.mark_email_read_outlined,
                ),
                //
                const SizedBox(height: 24),
                //
                Text("Вчера", style: TextStyle(color: theme.hintColor)),
                const NotificationCard(
                  title: "Посылка была доставлена",
                  text: "Ваша посылка была успешно доставлена в [...]",
                  icon: Icons.mark_email_read_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
