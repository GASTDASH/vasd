import 'package:flutter/material.dart';
import 'package:vasd/repositories/additional_func/additional_func.dart';

class AdditionalFuncCard extends StatefulWidget {
  const AdditionalFuncCard({
    super.key,
    required this.func,
  });

  final AdditionalFunc func;

  @override
  State<AdditionalFuncCard> createState() => _AdditionalFuncCardState();
}

class _AdditionalFuncCardState extends State<AdditionalFuncCard> {
  bool selected = false;

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
                      widget.func.name,
                      style: theme.textTheme.titleMedium?.copyWith(color: selected ? Colors.white : null),
                    ),
                    Text(
                      widget.func.text,
                      style: TextStyle(color: selected ? Colors.white : null),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${widget.func.price % 1 == 0 ? widget.func.price.truncate() : widget.func.price} ₽",
                          style: theme.textTheme.titleLarge?.copyWith(color: selected ? Colors.white : null),
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
