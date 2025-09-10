import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:cleaning_service_selector/ui/utils/app_images.dart';
import 'package:cleaning_service_selector/ui/utils/app_sizes.dart';
import 'package:flutter/material.dart';

class EmptyServicePlaceholder extends StatelessWidget {
  const EmptyServicePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImages.cleanStressFree,
              height: 150,
              fit: BoxFit.contain,
            ),
            AppSizes.vSpaceM,
            Text(
              'No data found!',
              style: TextStyle(
                fontSize: AppSizes.fontLarge,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlackText,
              ),
              textAlign: TextAlign.center,
            ),
            AppSizes.vSpaceS,
            
            Text(
              'Add a service to see details here.',
              style: TextStyle(
                fontSize: AppSizes.fontMedium,
                color: AppColors.greyText,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
