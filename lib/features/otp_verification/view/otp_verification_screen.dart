import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pinput/pinput.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vasd/repositories/auth/auth.dart';
import 'package:vasd/ui/ui.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final email = ModalRoute.of(context)!.settings.arguments;
    assert(email != null && email is String,
        'You must provide <String email> arg');
    email as String;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left_rounded, size: 40),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(18),
          child: ButtonBase(
            onTap: (codeController.text.length == 6)
                ? () async {
                    try {
                      await GetIt.I<AuthInterface>().verifyOtp(
                        otp: codeController.text,
                        email: email,
                      );

                      Navigator.pushNamed(context, "/new_password");
                    } catch (e) {
                      GetIt.I<Talker>().error(e.toString());
                    }
                  }
                : null,
            text: "Проверить",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Введите код", style: theme.textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text("Код подтверждения был отправлен на [...]",
                  style: TextStyle(color: theme.hintColor)),
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  height: 100,
                  child: Pinput(
                    controller: codeController,
                    length: 6,
                    onChanged: (_) {
                      setState(() {});
                    },
                    defaultPinTheme: PinTheme(
                      width: 86,
                      height: 60,
                      textStyle: const TextStyle(
                          fontSize: 32,
                          color: Color.fromRGBO(30, 60, 87, 1),
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromRGBO(234, 243, 236, 1)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    text: "Прислать ещё раз ",
                    style: theme.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: "0:52",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.primaryColor),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
