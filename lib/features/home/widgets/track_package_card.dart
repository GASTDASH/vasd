import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vasd/bloc/delivery/delivery_bloc.dart';
import 'package:vasd/ui/ui.dart';

class TrackPackageCard extends StatefulWidget {
  const TrackPackageCard({
    super.key,
    required this.trackContainerKey,
  });

  final GlobalKey trackContainerKey;

  @override
  State<TrackPackageCard> createState() => _TrackPackageCardState();
}

class _TrackPackageCardState extends State<TrackPackageCard> {
  bool codeTyped = false;
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deliveryBloc = context.read<DeliveryBloc>();

    return BlocListener<DeliveryBloc, DeliveryState>(
      bloc: deliveryBloc,
      listener: (context, state) {
        if (state is DeliveryFinding) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const LoadingDialog(),
          );
        }
      },
      listenWhen: (previous, current) {
        if (previous is DeliveryFinding) {
          Navigator.of(context).pop();

          if (current is DeliveryFound) {
            Navigator.pushNamed(
              context,
              "/package_info",
              arguments: current.delivery,
            );
          }
          // else if (current is DeliveryNotFound or Error) // TODO
        }
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          key: widget.trackContainerKey,
          height: 160,
          child: Container(
            decoration: BoxDecoration(
                color: theme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Отследить посылку",
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 5),
                  const Text("Введите ваш номер заказа"),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: TextField(
                              controller: codeController,
                              onChanged: (value) => setState(() =>
                                  value.isNotEmpty
                                      ? codeTyped = true
                                      : codeTyped = false),
                              onTapOutside: (event) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              textCapitalization: TextCapitalization.characters,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/box.svg",
                                    colorFilter: const ColorFilter.mode(
                                        Colors.black, BlendMode.srcIn),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Номер заказа",
                                hintStyle: TextStyle(
                                  color: theme.hintColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: codeTyped
                            ? () {
                                deliveryBloc.add(
                                  DeliveryFind(deliveryId: codeController.text),
                                );
                              }
                            : () async {
                                // TODO: Камера (QR или Штрих код)
                                final String? res =
                                    await SimpleBarcodeScanner.scanBarcode(
                                  context,
                                  isShowFlashIcon: true,
                                  delayMillis: 2000,
                                  cameraFace: CameraFace.back,
                                  scanFormat: ScanFormat.ONLY_BARCODE,
                                );

                                GetIt.I<Talker>().debug(res);

                                if (res != null &&
                                    res.isNotEmpty &&
                                    res != "-1") {
                                  deliveryBloc
                                      .add(DeliveryFind(deliveryId: res));
                                }
                              },
                        child: Ink(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.easeOutExpo,
                            transitionBuilder: (child, animation) =>
                                RotationTransition(
                              turns: child.key == const ValueKey('icon1')
                                  ? Tween<double>(begin: 1.25, end: 1)
                                      .animate(animation)
                                  : Tween<double>(begin: 0.75, end: 1)
                                      .animate(animation),
                              child: ScaleTransition(
                                  scale: animation, child: child),
                            ),
                            child: codeTyped
                                ? const Icon(
                                    key: ValueKey('icon2'),
                                    Icons.send,
                                    color: Colors.white,
                                    size: 34,
                                  )
                                : const Icon(
                                    key: ValueKey('icon1'),
                                    Icons.qr_code,
                                    color: Colors.white,
                                    size: 34,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
