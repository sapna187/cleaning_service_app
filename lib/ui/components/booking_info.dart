  import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:cleaning_service_selector/ui/utils/app_sizes.dart';
import 'package:cleaning_service_selector/ui/utils/app_texts.dart';
import 'package:flutter/material.dart';

Widget infoBox(
      {required IconData icon, required String title, required String value}) {
    return Container(
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
          Icon(icon, size: AppSizes.iconMedium, color: AppColors.primaryTheme),
          AppSizes.hSpaceS,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title,
                size: AppSizes.fontSmall,
                weight: FontWeight.w500,
                color: AppColors.lightBlackText.withValues(alpha: 0.7),
              ),
              customText(
                value,
                size: AppSizes.fontMedium,
                weight: FontWeight.w600,
                color: AppColors.lightBlackText,
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget selectorBox({required IconData icon, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingMedium,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryTheme.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: AppSizes.iconSmall, color: AppColors.primaryTheme),
          AppSizes.hSpaceS,
          customText(
            text,
            size: AppSizes.fontMedium,
            weight: FontWeight.w700,
            color: AppColors.lightBlackText,
          ),
        ],
      ),
    );
  }
