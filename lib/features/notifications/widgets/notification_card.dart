import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.text,
    required this.icon,
  });

  final String title;
  final String text;
  final IconData icon;

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
              height: 100,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: theme.primaryColor.withOpacity(0.1),
                    child: Icon(
                      icon,
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
                        Text(title, style: theme.textTheme.bodyLarge),
                        const SizedBox(height: 4),
                        Text(text, style: TextStyle(color: theme.hintColor)),
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
