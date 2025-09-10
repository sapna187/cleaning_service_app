import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:cleaning_service_selector/ui/utils/app_sizes.dart';
import 'package:cleaning_service_selector/ui/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContinueButton extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onPressed;
  final String? title; 

  const ContinueButton({
    super.key,
    required this.isVisible,
    required this.onPressed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: isVisible ? Offset.zero : const Offset(1.2, 0),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isVisible ? 1 : 0,
        child: Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryTheme,
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMedium * 1.5,
                vertical: AppSizes.paddingMedium,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
              elevation: 6,
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                customText(
                  title ?? "Continue",
                  color: Colors.white,
                  weight: FontWeight.w700,
                  size: AppSizes.fontMedium,
                ),
                AppSizes.hSpaceS,
                const Icon(Icons.arrow_forward, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Rounded Back Button
class CustomBackButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback? onTap;

  const CustomBackButton({
    super.key,
    this.backgroundColor,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Get.back(),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.greyText.withValues(alpha: 0.3),
            width: 1.2,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: iconColor ?? AppColors.lightBlackText,
            size: AppSizes.iconSmall + 5,
          ),
        ),
      ),
    );
  }
}
