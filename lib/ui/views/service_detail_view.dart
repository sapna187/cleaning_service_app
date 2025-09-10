import 'package:cleaning_service_selector/ui/components/booking_info.dart';
import 'package:cleaning_service_selector/ui/components/custom_button.dart';
import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:cleaning_service_selector/ui/utils/app_images.dart';
import 'package:cleaning_service_selector/ui/utils/app_sizes.dart';
import 'package:cleaning_service_selector/ui/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/booking_controller.dart';
import 'confirmation_view.dart';

class ServiceDetailView extends StatelessWidget {
  const ServiceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<BookingController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: customText(
          'Service Details',
          size: AppSizes.fontXLarge,
          weight: FontWeight.w700,
          color: AppColors.black,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: GestureDetector(
            onTap: () {
              ctrl.selectedDate.value = null;
              ctrl.selectedTime.value = null;
              Get.back();
            },
            child: const CustomBackButton(),
          ),
        ),
      ),
      body: Obx(() {
        final selectedServices = ctrl.selectedIds
            .map((id) => ctrl.services.firstWhere((s) => s.id == id))
            .toList();

        if (selectedServices.isEmpty) {
          return Center(
            child: customText(
              "No service selected",
              size: AppSizes.fontLarge,
              weight: FontWeight.w600,
              color: AppColors.greyText,
            ),
          );
        }

        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSizes.size200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                      child: Image.asset(
                        AppImages.banner,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  AppSizes.vSpaceL,

                  // Select Date & Time Section
                  customText(
                    'Select Date & Time',
                    size: AppSizes.fontMedium,
                    weight: FontWeight.w600,
                    color: AppColors.lightBlackText,
                  ),
                  AppSizes.vSpaceS,
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now().add(
                                const Duration(days: 1),
                              ),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                              builder: (ctx, child) => Theme(
                                data: Theme.of(ctx).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: AppColors.primaryTheme,
                                    onPrimary: AppColors.white,
                                    onSurface: AppColors.black,
                                  ),
                                ),
                                child: child!,
                              ),
                            );
                            if (picked != null) ctrl.setBookingDate(picked);
                          },
                          child: Obx(
                            () => selectorBox(
                              icon: Icons.calendar_today,
                              text: ctrl.selectedDate.value != null
                                  ? '${ctrl.selectedDate.value!.day}/${ctrl.selectedDate.value!.month}/${ctrl.selectedDate.value!.year}'
                                  : 'Select Date',
                            ),
                          ),
                        ),
                      ),
                      AppSizes.hSpaceM,
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: const TimeOfDay(hour: 9, minute: 0),
                              builder: (ctx, child) => Theme(
                                data: Theme.of(ctx).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: AppColors.primaryTheme,
                                    onPrimary: AppColors.white,
                                    onSurface: AppColors.black,
                                  ),
                                ),
                                child: child!,
                              ),
                            );
                            if (picked != null) ctrl.setBookingTime(picked);
                          },
                          child: Obx(
                            () => selectorBox(
                              icon: Icons.access_time,
                              text: ctrl.selectedTime.value != null
                                  ? ctrl.selectedTime.value!.format(context)
                                  : 'Select Time',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Divider after Date & Time
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: AppColors.greyText.withValues(alpha: 0.3),
                    ),
                  ),

                  //  All Selected Services
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: selectedServices.length,
                    separatorBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Divider(
                        color: AppColors.greyText.withValues(alpha: 0.3),
                      ),
                    ),
                    itemBuilder: (context, index) {
                      final service = selectedServices[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.title,
                            style: TextStyle(
                              fontSize: AppSizes.fontMedium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // AppSizes.vSpaceS,
                          customText(
                            service.description,
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w500,
                            color: AppColors.lightBlackText,
                          ),
                          AppSizes.vSpaceS,
                          Row(
                            children: [
                              infoBox(
                                icon: Icons.access_time_rounded,
                                title: 'Duration',
                                value: '${service.duration.inMinutes} mins',
                              ),
                              AppSizes.hSpaceM,
                              infoBox(
                                icon: Icons.monetization_on_outlined,
                                title: 'Price',
                                value: '\$ ${service.price.toStringAsFixed(2)}',
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  AppSizes.verticalGap(AppSizes.size100),
                ],
              ),
            ),

            Positioned(
              right: AppSizes.paddingMedium,
              bottom: AppSizes.paddingLarge,
              child: ContinueButton(
                title: "Continue",
                isVisible: true,
                onPressed: () {
                  if (ctrl.selectedDate.value == null ||
                      ctrl.selectedTime.value == null) {
                    Get.snackbar(
                      "Missing Details",
                      "Please select both date and time before continuing.",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: AppColors.primaryTheme.withValues(
                        alpha: 0.9,
                      ),
                      colorText: AppColors.white,
                      margin: const EdgeInsets.all(12),
                      borderRadius: AppSizes.radiusMedium,
                    );
                    return;
                  }

                  Get.to(
                    () => ConfirmationView(
                      formattedDate: ctrl.selectedDate.value != null
                          ? '${ctrl.selectedDate.value!.day}/${ctrl.selectedDate.value!.month}/${ctrl.selectedDate.value!.year}'
                          : '',
                      formattedTime: ctrl.selectedTime.value!.format(context),
                    ),
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
