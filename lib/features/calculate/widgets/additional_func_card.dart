import 'package:flutter/material.dart';

class AdditionalFuncCard extends StatefulWidget {
  const AdditionalFuncCard({
    super.key,
  });

  @override
  State<AdditionalFuncCard> createState() => _AdditionalFuncCardState();
}

class _AdditionalFuncCardState extends State<AdditionalFuncCard> {
  bool selected = false;

  // TODO: Добавить отдельный класс AdditionalFunc

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              // TODO: Выбрать функцию
              setState(() {
                selected = !selected;
              });
              // TODO: Добавить функцию в список (через блок)
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
                color: selected ? theme.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Дополнительная функция",
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: selected ? Colors.white : null),
                    ),
                    Text(
                      "Описание описание описание описание описание",
                      style: TextStyle(color: selected ? Colors.white : null),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "100₽",
                          style: theme.textTheme.titleLarge
                              ?.copyWith(color: selected ? Colors.white : null),
                        ),
                      ],
                    ),
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
