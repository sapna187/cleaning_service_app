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
    final service = ctrl.selectedService.value;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: customText(
          'Service Details',
          size: AppSizes.fontXLarge,
          weight: FontWeight.w700,
          color: AppColors.black,
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 12, right: 8),
          child: CustomBackButton(),
        ),
      ),
      body: Padding(
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
            Text(
              service?.title ?? '',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            AppSizes.vSpaceS,

            customText(
              service?.description ?? '',
              size: AppSizes.fontMedium,
              weight: FontWeight.w500,
              color: AppColors.lightBlackText,
            ),
            AppSizes.vSpaceS,
            Divider(color: AppColors.greyText.withValues(alpha: 0.3)),

            AppSizes.vSpaceS,

            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingMedium,
                    vertical: AppSizes.paddingSmall,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryTheme.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: AppSizes.iconMedium,
                        color: AppColors.primaryTheme,
                      ),
                      AppSizes.hSpaceS,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            'Duration',
                            size: AppSizes.fontSmall,
                            weight: FontWeight.w500,
                            color: AppColors.lightBlackText.withValues(
                              alpha: 0.7,
                            ),
                          ),
                          customText(
                            '${service?.duration.inMinutes} mins',
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w600,
                            color: AppColors.lightBlackText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                AppSizes.hSpaceM,

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingMedium,
                    vertical: AppSizes.paddingSmall,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryTheme.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on_outlined,
                        size: AppSizes.iconMedium,
                        color: AppColors.primaryTheme,
                      ),
                      AppSizes.hSpaceS,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            'Price',
                            size: AppSizes.fontSmall,
                            weight: FontWeight.w500,
                            color: AppColors.lightBlackText.withValues(
                              alpha: 0.7,
                            ),
                          ),
                          customText(
                            '\$ ${service?.price.toStringAsFixed(2)}',
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w600,
                            color: AppColors.lightBlackText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            AppSizes.vSpaceL,
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
                        lastDate: DateTime.now().add(const Duration(days: 365)),
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
                      () => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingMedium,
                          vertical: AppSizes.paddingMedium,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryTheme.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusMedium,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: AppSizes.iconSmall,
                              color: AppColors.primaryTheme,
                            ),
                            AppSizes.hSpaceS,
                            customText(
                              ctrl.selectedDate.value != null
                                  ? '${ctrl.selectedDate.value!.day}/${ctrl.selectedDate.value!.month}/${ctrl.selectedDate.value!.year}'
                                  : 'Select Date',
                              size: AppSizes.fontMedium,
                              weight: FontWeight.w700,
                              color: AppColors.lightBlackText,
                            ),
                          ],
                        ),
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
                        initialTime: TimeOfDay.now(),
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
                      () => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingMedium,
                          vertical: AppSizes.paddingMedium,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryTheme.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusMedium,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: AppSizes.iconSmall,
                              color: AppColors.primaryTheme,
                            ),
                            AppSizes.hSpaceS,
                            customText(
                              ctrl.selectedTime.value != null
                                  ? ctrl.selectedTime.value!.format(context)
                                  : 'Select Time',
                              size: AppSizes.fontMedium,
                              weight: FontWeight.w700,
                              color: AppColors.lightBlackText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppSizes.vSpaceM,

            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: AppSizes.paddingSmall),
              child: ContinueButton(
                title: "Continue",
                isVisible: true,
                onPressed: () {
                  if (service != null) {
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

                    ctrl.selectedIds.value = [service.id];
                    ctrl.selectedService.value = service;

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
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
