import 'package:flutter/material.dart';

class AdditionalFuncCard extends StatelessWidget {
  const AdditionalFuncCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              // TODO: Выбрать функцию
            },
            borderRadius: BorderRadius.circular(8),
            child: Ink(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black12,
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Дополнительная функция",
                        style: theme.textTheme.titleMedium),
                    const Text("Описание описание описание описание описание")
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
