import 'package:cleaning_service_selector/ui/components/custom_button.dart';
import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:cleaning_service_selector/ui/utils/app_images.dart';
import 'package:cleaning_service_selector/ui/utils/app_sizes.dart';
import 'package:cleaning_service_selector/ui/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingDetailView extends StatelessWidget {
  final Map<String, dynamic> booking;
  const BookingDetailView({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final items = booking['items'] as List;
    final date = DateTime.parse(booking['date']);
    final timeString = booking['time'] as String?;

    double subtotal = items.fold<double>(
      0.0,
      (sum, item) => sum + (item['price'] as double),
    );
    double platformFee = subtotal * 0.10;
    double total = subtotal + platformFee;
    double crewReceives = subtotal * 0.78;

    final formattedDate = DateFormat('EEEE, dd MMM yyyy').format(date);
    String formattedTime;
    if (timeString == null || timeString.isEmpty) {
      formattedTime = "12:00 PM";
    } else {
      final parts = timeString.split(":");
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final dt = DateTime(2025, 1, 1, hour, minute);
      formattedTime = DateFormat('hh:mm a').format(dt);
    }
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: customText(
          'Booking Details',
          size: AppSizes.fontXLarge,
          weight: FontWeight.w700,
          color: AppColors.black,
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 12, right: 8),
          child: CustomBackButton(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                AppImages.routineMadeEasy,
                width: AppSizes.size200,
                fit: BoxFit.contain,
              ),
            ),
            AppSizes.vSpaceL,

            customText(
              "Date: $formattedDate, $formattedTime",
              size: AppSizes.fontMedium,
              weight: FontWeight.w500,
              color: AppColors.lightBlackText,
            ),
            AppSizes.vSpaceM,

            customText(
              "Services selected:",
              size: AppSizes.fontLarge,
              weight: FontWeight.w700,
              color: AppColors.black,
            ),
            AppSizes.vSpaceS,
            ...items.map((s) {
              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: AppSizes.paddingSmall / 2,
                ),
                padding: EdgeInsets.all(AppSizes.paddingSmall),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  border: Border.all(
                    color: AppColors.greyText.withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.cleaning_services_rounded,
                      color: AppColors.primaryTheme,
                    ),
                    AppSizes.hSpaceM,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            s['title'],
                            size: AppSizes.fontMedium,
                            weight: FontWeight.w600,
                            color: AppColors.lightBlackText,
                          ),
                          AppSizes.verticalGap(AppSizes.size4),
                          customText(
                            "${s['durationMinutes']} min",
                            size: AppSizes.fontSmall,
                            weight: FontWeight.w500,
                            color: AppColors.greyText,
                          ),
                        ],
                      ),
                    ),
                    customText(
                      "\$ ${s['price']}",
                      size: AppSizes.fontMedium,
                      weight: FontWeight.w700,
                      color: AppColors.primaryTheme,
                    ),
                    AppSizes.hSpaceS,
                  ],
                ),
              );
            }),

            AppSizes.vSpaceM,
            Divider(color: AppColors.greyText.withValues(alpha: 0.3)),
            AppSizes.vSpaceS,
            SummaryTile(title: "Subtotal", amount: subtotal),
            SummaryTile(title: "Platform Fee (10%)", amount: platformFee),
            SummaryTile(title: "Total", amount: total, isBold: true),
            SummaryTile(title: "CleoCrew receives (78%)", amount: crewReceives),

            AppSizes.vSpaceL,
          ],
        ),
      ),
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
