import 'package:flutter/material.dart';

import '../navigation/app_routes.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';

class FarmDashboardMetrics extends StatelessWidget {
  const FarmDashboardMetrics({super.key});

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: AppStore.instance,
    builder: (context, _) {
      final farms = AppStore.instance.farms;
      final crops = farms
          .map((farm) => farm.crop.trim().toLowerCase())
          .where((crop) => crop.isNotEmpty)
          .toSet()
          .length;
      final area = farms.fold<double>(0, (total, farm) => total + farm.area);
      final irrigation = farms
          .where((farm) => farm.irrigationPlan.trim().isNotEmpty)
          .length;
      return LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 8.0;
          final columns = constraints.maxWidth < 360 ? 2 : 4;
          final width =
              (constraints.maxWidth - spacing * (columns - 1)) / columns;
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              _metric(
                context,
                width,
                'ખેતરો',
                '${farms.length}',
                Icons.yard_outlined,
              ),
              _metric(context, width, 'પાક', '$crops', Icons.eco_outlined),
              _metric(
                context,
                width,
                'વિસ્તાર',
                '${area.toStringAsFixed(1)} એકર',
                Icons.square_foot_outlined,
              ),
              _metric(
                context,
                width,
                'સિંચાઈ યોજના',
                '$irrigation',
                Icons.water_drop_outlined,
              ),
            ],
          );
        },
      );
    },
  );

  Widget _metric(
    BuildContext context,
    double width,
    String label,
    String value,
    IconData icon,
  ) => SizedBox(
    width: width,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    ),
  );
}

class FarmDashboardList extends StatelessWidget {
  const FarmDashboardList({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: AppStore.instance,
    builder: (context, _) {
      final farms = AppStore.instance.farms;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          if (farms.isEmpty)
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.agriculture_outlined,
                  color: AppColors.primary,
                ),
                title: const Text('હજુ કોઈ ખેતર સાચવેલું નથી'),
                subtitle: const Text('તમારા પોતાના ખેતરની માહિતી અહીં દેખાશે.'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => AppRoutes.open(context, AppRoutes.farms),
              ),
            )
          else
            ...farms
                .take(4)
                .map(
                  (farm) => Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.primarySurface,
                        child: Icon(
                          Icons.yard_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                      title: Text(farm.name),
                      subtitle: Text(
                        '${farm.area} એકર · ${farm.crop}'
                        '${farm.irrigationPlan.isEmpty ? '' : '\nસિંચાઈ: ${farm.irrigationPlan}'}',
                      ),
                      isThreeLine: farm.irrigationPlan.isNotEmpty,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => AppRoutes.open(context, AppRoutes.farms),
                    ),
                  ),
                ),
        ],
      );
    },
  );
}
