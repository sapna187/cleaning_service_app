import 'package:cleaning_service_selector/ui/components/custom_button.dart';
import 'package:cleaning_service_selector/ui/components/service_tile.dart';
import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:cleaning_service_selector/ui/utils/app_images.dart';
import 'package:cleaning_service_selector/ui/utils/app_sizes.dart';
import 'package:cleaning_service_selector/ui/utils/app_texts.dart';
import 'package:cleaning_service_selector/ui/views/booking_history_view.dart';
import 'package:cleaning_service_selector/ui/views/service_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/booking_controller.dart';

class ServiceListView extends StatelessWidget {
  const ServiceListView({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController ctrl = Get.find();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Image.asset(
          AppImages.header,
          width: AppSizes.size150,
          fit: BoxFit.cover,
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSizes.paddingMedium),
            child: GestureDetector(
              onTap: () => Get.to(() => const BookingHistoryView()),
              child: Container(
                height: AppSizes.size35,
                width: AppSizes.size35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.greyText.withValues(alpha: 0.3),
                    width: 1.2,
                  ),
                ),
                child: Icon(
                  Icons.history_rounded,
                  color: AppColors.black,
                  size: AppSizes.iconMedium,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Obx(() {
         final services = ctrl.services;
  final selected = ctrl.selectedIds;

        return Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(AppSizes.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    'Select a cleaning service',
                    size: AppSizes.fontLarge,
                    weight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  AppSizes.vSpaceM,

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 3.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: services.length,
                    itemBuilder: (context, i) {
                      final service = services[i];
                      return ServiceTile(
                        service: service,
                        isSelected: selected.contains(service.id),
                        onTap: () {
                          if (selected.contains(service.id)) {
                            selected.remove(service.id);
                          } else {
                            selected.add(service.id);
                          }
                        },
                      );
                    },
                  ),
                  AppSizes.vSpaceL,

                  const SizedBox(height: 80),
                ],
              ),
            ),

            Positioned(
              bottom: AppSizes.paddingLarge,
              right: AppSizes.paddingMedium,
              child: ContinueButton(
                isVisible: selected.isNotEmpty,
                onPressed: () {
                  Get.to(
                    () => const ServiceDetailView(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
