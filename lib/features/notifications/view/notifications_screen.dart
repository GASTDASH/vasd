import 'package:flutter/material.dart';

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
                NotificationCard(theme: theme),
                const Divider(thickness: 0.2, height: 0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//TODO
//TODO
//TODO
//TODO
//TODO
//TODO
//TODO
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        padding: const EdgeInsets.all(6),
        height: 100,
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: theme.primaryColor.withOpacity(0.1),
              child: Icon(
                Icons.mail_outline,
                size: 32,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("The package is ready to be sent",
                      style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 4),
                  Text("Your package has been sent from New York to New Jersey",
                      style: TextStyle(color: theme.hintColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
