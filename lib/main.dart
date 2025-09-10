import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:cleaning_service_selector/ui/utils/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app_bindings.dart';
import 'ui/views/service_list_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); 

  runApp(CleaningApp());
}

class CleaningApp extends StatelessWidget {
  const CleaningApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.init(context);
    return GetMaterialApp(
      title: 'Cleaning Service Selector',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryTheme),
      ),
      initialBinding: AppBindings(),
      home: const ServiceListView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
