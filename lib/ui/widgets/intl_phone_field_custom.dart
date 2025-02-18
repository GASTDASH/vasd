import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class IntlPhoneFieldCustom extends StatefulWidget {
  const IntlPhoneFieldCustom({
    super.key,
    this.controller,
    this.onChanged,
  });

  final TextEditingController? controller;
  final Function(PhoneNumber)? onChanged;

  @override
  State<IntlPhoneFieldCustom> createState() => _IntlPhoneFieldCustomState();
}

class _IntlPhoneFieldCustomState extends State<IntlPhoneFieldCustom> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IntlPhoneField(
      initialCountryCode: 'RU',
      countries: [
        countries.firstWhere(
          (element) => element.code == "RU",
        )
      ],
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: theme.hintColor, width: 1)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.hintColor, width: 1)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor),
        ),
      ),
    );
  }
}
