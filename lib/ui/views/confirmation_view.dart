import 'package:cleaning_service_selector/ui/components/confirmation_dialog.dart';
import 'package:cleaning_service_selector/ui/components/custom_button.dart';
import 'package:cleaning_service_selector/ui/components/empty_placeholder.dart';
import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:cleaning_service_selector/ui/utils/app_sizes.dart';
import 'package:cleaning_service_selector/ui/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/booking_controller.dart';

class ConfirmationView extends StatelessWidget {
  final String formattedDate;
  final String formattedTime;
  const ConfirmationView({
    super.key,
    required this.formattedDate,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    final BookingController ctrl = Get.find();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: customText(
          'Booking Confirmation',
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
        final selected = ctrl.selectedIds;

        if (selected.isEmpty) return const EmptyServicePlaceholder();

        return Padding(
          padding: EdgeInsets.all(AppSizes.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ...selected.map((id) {
                      final service = ctrl.services.firstWhere(
                        (s) => s.id == id,
                      );
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: AppSizes.paddingSmall,
                        ),
                        padding: EdgeInsets.all(AppSizes.paddingMedium),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusLarge,
                          ),
                          border: Border.all(
                            color: AppColors.greyText.withValues(alpha: 0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.cleaning_services_rounded,
                              color: AppColors.primaryTheme,
                              size: AppSizes.iconLarge,
                            ),
                            AppSizes.hSpaceM,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(
                                    service.title,
                                    size: AppSizes.fontLarge,
                                    weight: FontWeight.w600,
                                    color: AppColors.lightBlackText,
                                  ),
                                  AppSizes.vSpaceS,
                                  customText(
                                    '${service.duration.inMinutes} min',
                                    size: AppSizes.fontMedium,
                                    weight: FontWeight.w500,
                                    color: AppColors.greyText,
                                  ),
                                ],
                              ),
                            ),
                            customText(
                              '\$${service.price.toStringAsFixed(2)}',
                              size: AppSizes.fontMedium,
                              weight: FontWeight.w600,
                              color: AppColors.primaryTheme,
                            ),
                          ],
                        ),
                      );
                    }),

                    AppSizes.vSpaceM,
                    customText(
                      "Booking Slot: $formattedDate, $formattedTime",
                      size: AppSizes.fontMedium,
                      weight: FontWeight.w600,
                      color: AppColors.lightBlackText,
                    ),
                    AppSizes.vSpaceM,
                    Divider(color: AppColors.greyText.withValues(alpha: 0.3)),

                    SummaryTile(title: 'Subtotal', amount: ctrl.subtotal),
                    SummaryTile(
                      title: 'Platform fee (10%)',
                      amount: ctrl.platformFee,
                    ),
                    SummaryTile(
                      title: 'Total',
                      amount: ctrl.total,
                      isBold: true,
                    ),
                    SummaryTile(
                      title: 'CleoCrew receives (78%)',
                      amount: ctrl.crewReceives,
                    ),

                    AppSizes.vSpaceM,

                    Container(
                      padding: EdgeInsets.all(AppSizes.paddingMedium),
                      decoration: BoxDecoration(
                        color: AppColors.greyText.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusMedium,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            'Simple, Honest Pricing',
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                          AppSizes.vSpaceS,
                          customText(
                            'Every cleaning includes a free surface wipe of add-ons. Add-on prices are for a deeper clean (e.g., inside appliances).',
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w500,
                            color: AppColors.lightBlackText.withValues(
                              alpha: 0.8,
                            ),
                          ),
                          AppSizes.vSpaceM,
                          customText(
                            'Platform Fees:',
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                          AppSizes.vSpaceS,
                          customText(
                            'Clients pay a 10% service fee.',
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w500,
                            color: AppColors.lightBlackText.withValues(
                              alpha: 0.8,
                            ),
                          ),
                          AppSizes.vSpaceS,
                          customText(
                            'CleoCrew receives 78% of the job total.',
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w500,
                            color: AppColors.lightBlackText.withValues(
                              alpha: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),

                    AppSizes.vSpaceL,

                    Container(
                      padding: EdgeInsets.all(AppSizes.paddingMedium),
                      decoration: BoxDecoration(
                        color: AppColors.lightPink,
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusMedium,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            'Satisfaction Guarantee',
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                          AppSizes.vSpaceS,
                          customText(
                            'If you are not happy it is free. No questions asked.',
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w500,
                            color: AppColors.lightBlackText.withValues(
                              alpha: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),

                    AppSizes.vSpaceL,
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  bottom: AppSizes.paddingMedium,
                  top: AppSizes.paddingMedium,
                ),
                child: ContinueButton(
                  isVisible: true,
                  title: "Confirm Booking",
                  onPressed: () {
                    ctrl.saveBooking();

                    BookingConfirmationDialog.show(ctrl: ctrl);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class SummaryTile extends StatelessWidget {
  final String title;
  final double amount;
  final bool isBold;

  const SummaryTile({
    super.key,
    required this.title,
    required this.amount,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.paddingSmall / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customText(
            title,
            size: AppSizes.fontMedium,
            weight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: AppColors.lightBlackText,
          ),
          customText(
            '\$${amount.toStringAsFixed(2)}',
            size: AppSizes.fontMedium,
            weight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: isBold ? AppColors.primaryTheme : AppColors.lightBlackText,
          ),
        ],
      ),
    );
  }
}
