import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  void initState() {
    super.initState();

    GetIt.I<Talker>().debug("Initialized PackagesScreen");
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(),
    );
  }
}
