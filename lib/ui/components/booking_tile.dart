import 'dart:math';

import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:cleaning_service_selector/ui/utils/app_sizes.dart';
import 'package:cleaning_service_selector/ui/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../views/booking_detail_view.dart';

class BookingHistoryTile extends StatelessWidget {
  final Map<String, dynamic> booking;

  const BookingHistoryTile({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(booking['date']);
    final formattedDate = DateFormat('dd MMM yyyy').format(date);
    final timeString = booking['time'] as String?;
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
    final icons = [
      Icons.cleaning_services,
      Icons.home_repair_service,
      Icons.room_service,
      Icons.local_laundry_service,
    ];

    // Randomly pick one icon
    final random = Random();
    final icon = icons[random.nextInt(icons.length)];

    return GestureDetector(
      onTap: () => Get.to(() => BookingDetailView(booking: booking)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(AppSizes.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: AppColors.greyText.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Circle Avatar with random icon
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.greyText.withValues(alpha: 0.1),
              child: Icon(
                icon,
                color: AppColors.greyText,
                size: AppSizes.iconMedium,
              ),
            ),
            AppSizes.hSpaceM,
            // Booking details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    "$formattedDate, $formattedTime",
                    size: AppSizes.size16,
                    weight: FontWeight.w700,
                    color: AppColors.lightBlackText,
                  ),
                  AppSizes.vSpaceS,
                  customText(
                    "Total: \$ ${booking['total']}",
                    size: AppSizes.fontMedium,
                    weight: FontWeight.w600,
                    color: AppColors.greyText,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
