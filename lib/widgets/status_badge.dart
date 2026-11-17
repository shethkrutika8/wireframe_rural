import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  const StatusBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
  });

  factory StatusBadge.fromStatus(String status) {
    switch (status.trim()) {
      case 'સારો':
      case 'પૂર્ણ કરો':
        return StatusBadge(
          text: status,
          backgroundColor: AppColors.badgeGreenBg,
          textColor: AppColors.badgeGreenText,
        );
      case 'વિકાસમાં':
      case 'ચાલુ છે':
        return StatusBadge(
          text: status,
          backgroundColor: AppColors.badgeOrangeBg,
          textColor: AppColors.badgeOrangeText,
        );
      case 'આજે માટે':
      case 'લગભગ તૈયાર':
        return StatusBadge(
          text: status,
          backgroundColor: AppColors.badgeBlueBg,
          textColor: AppColors.badgeBlueText,
        );
      case 'બાકી':
        return StatusBadge(
          text: status,
          backgroundColor: AppColors.badgeGrayBg,
          textColor: AppColors.badgeGrayText,
        );
      default:
        return StatusBadge(
          text: status,
          backgroundColor: AppColors.badgeGreenBg,
          textColor: AppColors.badgeGreenText,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.badgeGreenBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: GoogleFonts.hindVadodara(
          color: textColor ?? AppColors.badgeGreenText,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
