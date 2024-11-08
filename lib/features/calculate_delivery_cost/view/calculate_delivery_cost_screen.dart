import 'package:flutter/material.dart';
import 'package:vasd/features/calculate_delivery_cost/widgets/package_size_dialog.dart';
import 'package:vasd/repositories/package_size/models/package_size.dart';
import 'package:vasd/repositories/package_size/package_size_local_repo.dart';
import 'package:vasd/ui/ui.dart';

class CalculateDeliveryCostScreen extends StatefulWidget {
  const CalculateDeliveryCostScreen({super.key});

  @override
  State<CalculateDeliveryCostScreen> createState() =>
      _CalculateDeliveryCostScreenState();
}

class _CalculateDeliveryCostScreenState
    extends State<CalculateDeliveryCostScreen> {
  final cityFromController = TextEditingController();
  final cityToController = TextEditingController();
  PackageSize? selectedPackageSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left_rounded, size: 40),
          ),
          title: Text(
            "Рассчитать доставку",
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(18),
          child: ButtonBase(
            onTap: cityFromController.text.isNotEmpty &&
                    cityToController.text.isNotEmpty &&
                    selectedPackageSize != null
                ? () {}
                : null,
            text: "Рассчитать",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFieldCustom(
                hintText: "Город отправки",
                controller: cityFromController,
              ),
              const SizedBox(height: 12),
              TextFieldCustom(
                hintText: "Город назначения",
                controller: cityToController,
              ),
              const SizedBox(height: 12),
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () async {
                  final packageSizes = await PackageSizeLocalRepo().getItems();

                  final PackageSize? packageSize = await showDialog(
                    context: context,
                    builder: (context) => PackageSizeDialog(
                      packageSizes: packageSizes,
                    ),
                  );

                  if (packageSize != null) {
                    setState(() => selectedPackageSize = packageSize);
                  }
                },
                child: Ink(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: theme.hintColor),
                      borderRadius: BorderRadius.circular(4)),
                  height: 62,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        selectedPackageSize != null
                            ? selectedPackageSize!.title
                            : "Размер посылки",
                        style: TextStyle(
                          color: selectedPackageSize != null
                              ? Colors.black
                              : Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
