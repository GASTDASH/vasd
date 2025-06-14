import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
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
    var deliveryBloc = context.read<DeliveryBloc>();

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
            onTap: () {
              deliveryBloc.add(DeliveryFind(deliveryId: notification.deliveryId));
            },
            child: Ink(
              padding: const EdgeInsets.all(6),
              height: 120,
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
          const Divider(thickness: 0.3, height: 0),
        ],
      ),
    );
  }
}
