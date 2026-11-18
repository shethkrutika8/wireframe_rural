import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class WeatherCard extends StatelessWidget {
  final String location;
  final String temperature;
  final String condition;
  final String humidity;
  final String windSpeed;
  final bool isAvailable;
  final String? updateTime;
  final VoidCallback? onMoreTap;
  final VoidCallback? onRefresh;

  const WeatherCard({
    super.key,
    this.location = 'રાજકોટ, ગુજરાત',
    this.temperature = '28°C',
    this.condition = 'આંશિક વાદળછાયું',
    this.humidity = '65%',
    this.windSpeed = '12 km/h',
    this.isAvailable = false,
    this.updateTime,
    this.onMoreTap,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5EDE3)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Icon(
                isAvailable ? Icons.location_on : Icons.cloud_off_outlined,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  isAvailable ? location : 'હવામાન માહિતી',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.hindVadodara(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              if (isAvailable && updateTime != null) ...[
                Text(
                  updateTime!,
                  style: GoogleFonts.hindVadodara(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: onRefresh,
                  child: const Icon(
                    Icons.refresh,
                    size: 16,
                    color: AppColors.textMedium,
                  ),
                ),
              ] else if (onMoreTap != null) ...[
                InkWell(
                  onTap: onMoreTap,
                  child: Row(
                    children: [
                      Text(
                        'વધુ જુઓ',
                        style: GoogleFonts.hindVadodara(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          if (isAvailable)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherStat(
                  icon: Icons.thermostat_outlined,
                  iconColor: Colors.green,
                  value: temperature,
                  label: 'તાપમાન',
                ),
                _buildWeatherStat(
                  icon: Icons.wb_sunny_outlined,
                  iconColor: Colors.amber,
                  value: condition,
                  label: 'હવામાન',
                  compactValue: true,
                ),
                _buildWeatherStat(
                  icon: Icons.water_drop_outlined,
                  iconColor: Colors.blue,
                  value: humidity,
                  label: 'ભેજ',
                ),
                _buildWeatherStat(
                  icon: Icons.air,
                  iconColor: Colors.teal,
                  value: windSpeed,
                  label: 'પવન',
                ),
              ],
            )
          else
            Text(
              'હવામાન સેવા જોડાયેલી નથી; હાલમાં કોઈ આગાહી બતાવવામાં આવતી નથી.',
              style: GoogleFonts.hindVadodara(
                fontSize: 12,
                color: AppColors.textMedium,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWeatherStat({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
    bool compactValue = false,
  }) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.hindVadodara(
                    fontSize: compactValue ? 12 : 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.hindVadodara(
              fontSize: 11,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
