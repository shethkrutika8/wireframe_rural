import 'package:flutter/material.dart';

import '../../navigation/app_routes.dart';
import '../../services/app_store.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_drawer.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: AppStore.instance,
    builder: (context, _) {
      final farms = AppStore.instance.farms;
      final totalArea = farms.fold<double>(
        0,
        (total, farm) => total + farm.area,
      );
      final cropCount = farms
          .map((farm) => farm.crop.trim().toLowerCase())
          .where((crop) => crop.isNotEmpty)
          .toSet()
          .length;
      final irrigationCount = farms
          .where((farm) => farm.irrigationPlan.trim().isNotEmpty)
          .length;
      return Scaffold(
        drawer: const AppDrawer(activeRoute: AppRoutes.summary),
        appBar: AppBar(
          title: const Text('ખેતરનો સારાંશ'),
          actions: [
            IconButton(
              tooltip: 'સેટિંગ્સ',
              onPressed: () => AppRoutes.open(context, AppRoutes.settings),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'તમારા સાચવેલા ખેતરની હાલની માહિતી',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth < 430 ? 2 : 4;
                  final tileWidth =
                      (constraints.maxWidth - (columns - 1) * 10) / columns;
                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _statTile(
                        context,
                        tileWidth,
                        'ખેતરો',
                        '${farms.length}',
                        Icons.yard_outlined,
                      ),
                      _statTile(
                        context,
                        tileWidth,
                        'પાક',
                        '$cropCount',
                        Icons.eco_outlined,
                      ),
                      _statTile(
                        context,
                        tileWidth,
                        'વિસ્તાર',
                        '${totalArea.toStringAsFixed(1)} એકર',
                        Icons.square_foot_outlined,
                      ),
                      _statTile(
                        context,
                        tileWidth,
                        'સિંચાઈ યોજના',
                        '$irrigationCount',
                        Icons.water_drop_outlined,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'મારા ખેતરો',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => AppRoutes.open(context, AppRoutes.farms),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('બધા જુઓ'),
                  ),
                ],
              ),
              if (farms.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.agriculture_outlined,
                          color: AppColors.primary,
                          size: 44,
                        ),
                        const SizedBox(height: 10),
                        const Text('હજુ કોઈ ખેતર સાચવેલું નથી.'),
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          onPressed: () =>
                              AppRoutes.open(context, AppRoutes.farms),
                          icon: const Icon(Icons.add),
                          label: const Text('ખેતર ઉમેરો'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...farms
                    .take(5)
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
                          onTap: () => AppRoutes.open(context, AppRoutes.farms),
                        ),
                      ),
                    ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => AppRoutes.open(context, AppRoutes.crops),
                    icon: const Icon(Icons.eco_outlined),
                    label: const Text('પાક જુઓ'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () =>
                        AppRoutes.open(context, AppRoutes.irrigation),
                    icon: const Icon(Icons.water_drop_outlined),
                    label: const Text('સિંચાઈ જુઓ'),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: AppBottomNav(
          currentIndex: 3,
          onTap: (index) => AppRoutes.selectBottomNavigation(context, index),
        ),
      );
    },
  );

  Widget _statTile(
    BuildContext context,
    double width,
    String title,
    String value,
    IconData icon,
  ) => SizedBox(
    width: width,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 10),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    ),
  );
}
