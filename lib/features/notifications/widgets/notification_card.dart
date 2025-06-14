import 'package:flutter/material.dart';
import 'package:vasd/repositories/notification/notification.dart' as notification_vasd;

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
  });

  final notification_vasd.Notification notification;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        color: theme.primaryColor,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.done_all_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text("Прочитано", style: TextStyle(color: Colors.white)),
            SizedBox(width: 20)
          ],
        ),
      ),
      child: Column(
        children: [
          InkWell(
            // onTap: () {},
            child: Ink(
              padding: const EdgeInsets.all(6),
              height: 110,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: theme.primaryColor.withOpacity(0.1),
                    child: Icon(
                      notification.statusCode == 2
                          ? Icons.mail_outline
                          : notification.statusCode == 3
                              ? Icons.local_shipping_outlined
                              : notification.statusCode == 4
                                  ? Icons.mark_email_read_outlined
                                  : Icons.shopping_bag_sharp,
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
                        Text(notification.title, style: theme.textTheme.bodyLarge),
                        const SizedBox(height: 4),
                        Text(notification.text, style: TextStyle(color: theme.hintColor)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(thickness: 0.2, height: 0),
        ],
      ),
    );
  }
}
