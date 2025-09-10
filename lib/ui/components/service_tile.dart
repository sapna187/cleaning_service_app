import 'package:cleaning_service_selector/ui/utils/app_colors.dart';
import 'package:cleaning_service_selector/ui/utils/app_sizes.dart';
import 'package:cleaning_service_selector/ui/utils/app_texts.dart';
import 'package:flutter/material.dart';

class ServiceTile extends StatelessWidget {
  final dynamic service;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceTile({
    super.key,
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryTheme.withValues(alpha: 0.1)
              : AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryTheme
                : AppColors.greyText.withValues(alpha: 0.3),
            width: 1.2,
          ),
        ),
        padding: EdgeInsets.all(AppSizes.paddingSmall),
        child: Row(
          children: [
            AppSizes.hSpaceS,

            /// Avatar with animated icon change
            CircleAvatar(
              backgroundColor: isSelected
                  ? AppColors.primaryTheme
                  : AppColors.greyText.withValues(alpha: 0.2),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        key: ValueKey('check'),
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.cleaning_services,
                        key: ValueKey('icon'),
                        color: Colors.black54,
                      ),
              ),
            ),
            AppSizes.hSpaceL,

            /// Service Details
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    service.title,
                    size: AppSizes.fontLarge,
                    weight: FontWeight.w600,
                  ),
                  customText(
                    "\$${service.price.toStringAsFixed(2)} • ${service.duration.inMinutes} mins",
                    size: AppSizes.fontMedium,
                    weight: FontWeight.w500,
                    color: AppColors.greyText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
