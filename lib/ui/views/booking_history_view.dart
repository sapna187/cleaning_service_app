import 'package:cleaning_service_selector/ui/components/booking_tile.dart';
import 'package:cleaning_service_selector/ui/components/custom_button.dart';
import 'package:cleaning_service_selector/ui/components/empty_placeholder.dart';
import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:cleaning_service_selector/ui/utils/app_sizes.dart';
import 'package:cleaning_service_selector/ui/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/booking_controller.dart';

class BookingHistoryView extends StatelessWidget {
  const BookingHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController ctrl = Get.find();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: customText(
          'Booking History',
          size: AppSizes.fontXLarge,
          weight: FontWeight.w700,
          color: AppColors.black,
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 12, right: 8),
          child: CustomBackButton(),
        ),
      ),
      body: Obx(() {
        if (ctrl.bookings.isEmpty) {
          return const EmptyServicePlaceholder();
        }
        return Padding(
          padding: EdgeInsets.only(
            left: AppSizes.paddingMedium,
            right: AppSizes.paddingMedium,
            bottom: AppSizes.paddingMedium,
          ),
          child: ListView.builder(
            itemCount: ctrl.bookings.length,
            itemBuilder: (context, i) {
              final booking = ctrl.bookings[i];
              return Dismissible(
                key: Key(booking['id']),
                direction: DismissDirection.horizontal,
                background: Container(
                  color: AppColors.primaryTheme,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: AppSizes.paddingMedium),
                  child: Icon(Icons.delete, color: AppColors.white),
                ),
                secondaryBackground: Container(
                  color: AppColors.primaryTheme,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: AppSizes.paddingMedium),
                  child: Icon(Icons.delete, color: AppColors.white),
                ),
                confirmDismiss: (direction) async {
                  final confirmed = await Get.dialog<bool>(
                    AlertDialog(
                      backgroundColor: AppColors.white,
                      title: customText(
                        'Delete Booking',
                        size: AppSizes.fontLarge,
                        weight: FontWeight.w700,
                      ),
                      content: customText(
                        'Your booking history and any upcoming booking will be permanently deleted. Do you want to continue?',
                        size: AppSizes.fontMedium,
                        weight: FontWeight.w500,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: customText(
                            'Cancel',
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w700,
                            color: AppColors.lightBlackText,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.back(result: true),
                          child: customText(
                            'Delete',
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w700,
                            color: AppColors.primaryTheme,
                          ),
                        ),
                      ],
                    ),
                    barrierDismissible: false,
                  );
                  return confirmed ?? false;
                },
                onDismissed: (_) {
                  ctrl.bookings.removeAt(i);
                  ctrl.storage.write('bookings', ctrl.bookings);
                  Get.snackbar(
                    'Deleted',
                    'Booking has been removed.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.primaryTheme,
                    colorText: Colors.white,
                  );
                },
                child: BookingHistoryTile(booking: booking),
              );
            },
          ),
        );
      }),
    );
  }
}
