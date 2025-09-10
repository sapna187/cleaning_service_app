import 'package:cleaning_service_selector/controllers/booking_controller.dart';
import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:cleaning_service_selector/ui/utils/app_sizes.dart';
import 'package:cleaning_service_selector/ui/utils/app_texts.dart';
import 'package:cleaning_service_selector/ui/views/service_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingConfirmationDialog extends StatelessWidget {
  final BookingController ctrl;
  final VoidCallback? onReturn;

  const BookingConfirmationDialog({
    super.key,
    required this.ctrl,
    this.onReturn,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      backgroundColor: AppColors.white,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        tween: Tween(begin: 0.8, end: 1.0),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(scale: value, child: child);
        },
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: AppSizes.size100,
              ),
              AppSizes.vSpaceM,
              customText(
                "Booking Confirmed!",
                size: AppSizes.fontXLarge,
                weight: FontWeight.w700,
                color: AppColors.black,
              ),
              AppSizes.vSpaceM,
              customText(
                "Your cleaning services have been scheduled successfully. "
                "We'll make sure everything is sparkling clean!",
                size: AppSizes.fontMedium,
                weight: FontWeight.w600,
                color: AppColors.lightBlackText.withValues(alpha: 0.8),
              ),
              AppSizes.vSpaceL,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTheme,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.radiusMedium,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: AppSizes.size12),
                    elevation: 4,
                  ),
                  onPressed:
                      onReturn ??
                      () {
                        ctrl.selectedIds.clear();
                        ctrl.selectedService.value = null;
                        Get.offAll(() => const ServiceListView());
                      },
                  child: customText(
                    "Return to Services",
                    color: Colors.white,
                    size: AppSizes.fontMedium,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///  Helper function to show dialog
  static void show({required BookingController ctrl, VoidCallback? onReturn}) {
    Get.dialog(
      BookingConfirmationDialog(ctrl: ctrl, onReturn: onReturn),
      barrierDismissible: false,
    );
  }
}
