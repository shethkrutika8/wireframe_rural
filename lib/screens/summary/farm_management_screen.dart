import 'package:flutter/material.dart';

import '../../navigation/app_routes.dart';
import '../../services/app_store.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_drawer.dart';

enum FarmSection { farms, crops, irrigation }

class FarmManagementScreen extends StatefulWidget {
  const FarmManagementScreen({super.key, required this.section});

  final FarmSection section;

  @override
  State<FarmManagementScreen> createState() => _FarmManagementScreenState();
}

class _FarmManagementScreenState extends State<FarmManagementScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String get _title => switch (widget.section) {
    FarmSection.farms => 'મારા ખેતરો',
    FarmSection.crops => 'મારા પાક',
    FarmSection.irrigation => 'સિંચાઈ આયોજન',
  };

  int get _navigationIndex => switch (widget.section) {
    FarmSection.farms => 3,
    FarmSection.crops => 1,
    FarmSection.irrigation => 2,
  };

  bool _matches(FarmRecord farm) {
    if (_query.isEmpty) return true;
    final searchTarget = switch (widget.section) {
      FarmSection.farms => '${farm.name} ${farm.crop}',
      FarmSection.crops => farm.crop,
      FarmSection.irrigation =>
        '${farm.irrigationPlan} ${farm.name} ${farm.crop}',
    };
    return searchTarget.toLowerCase().contains(_query.toLowerCase());
  }

  Future<void> _editFarm([FarmRecord? existing]) async {
    final result = await showDialog<FarmRecord>(
      context: context,
      builder: (context) => _FarmEditor(existing: existing),
    );
    if (result == null) return;
    try {
      await AppStore.instance.saveFarm(result);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              existing == null ? 'ખેતર સાચવાયું.' : 'ખેતરની માહિતી અપડેટ થઈ.',
            ),
          ),
        );
      }
    } on AppStoreException catch (error) {
      if (mounted) _showError(error.message);
    }
  }

  Future<void> _deleteFarm(FarmRecord farm) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ખેતર કાઢી નાખવું છે?'),
        content: Text(
          '${farm.name} અને તેની પાક/સિંચાઈ માહિતી કાઢી નાખવામાં આવશે.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('રદ કરો'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('કાઢી નાખો'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await AppStore.instance.deleteFarm(farm.id);
    } on AppStoreException catch (error) {
      if (mounted) _showError(error.message);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: AppStore.instance,
    builder: (context, _) {
      final visibleFarms = AppStore.instance.farms
          .where(_matches)
          .toList(growable: false);
      return Scaffold(
        drawer: AppDrawer(activeRoute: _routeForSection),
        appBar: AppBar(
          title: Text(_title),
          actions: [
            IconButton(
              tooltip: 'સેટિંગ્સ',
              onPressed: () => AppRoutes.open(context, AppRoutes.settings),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value.trim()),
                  decoration: InputDecoration(
                    hintText: switch (widget.section) {
                      FarmSection.farms => 'ખેતર અથવા પાક શોધો',
                      FarmSection.crops => 'પાક શોધો',
                      FarmSection.irrigation => 'સિંચાઈ યોજના શોધો',
                    },
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'શોધ સાફ કરો',
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                            icon: const Icon(Icons.clear),
                          ),
                  ),
                ),
              ),
              Expanded(
                child: visibleFarms.isEmpty
                    ? _emptyState()
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: visibleFarms.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, index) =>
                            _farmCard(visibleFarms[index]),
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _editFarm(),
          icon: const Icon(Icons.add),
          label: Text(
            widget.section == FarmSection.crops ? 'પાક ઉમેરો' : 'ખેતર ઉમેરો',
          ),
        ),
        bottomNavigationBar: AppBottomNav(
          currentIndex: _navigationIndex,
          onTap: (index) => AppRoutes.selectBottomNavigation(context, index),
        ),
      );
    },
  );

  String get _routeForSection => switch (widget.section) {
    FarmSection.farms => AppRoutes.farms,
    FarmSection.crops => AppRoutes.crops,
    FarmSection.irrigation => AppRoutes.irrigation,
  };

  Widget _emptyState() => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _query.isNotEmpty ? Icons.search_off : Icons.agriculture_outlined,
            size: 52,
            color: AppColors.primary,
          ),
          const SizedBox(height: 12),
          Text(
            _query.isEmpty
                ? 'હજુ કોઈ માહિતી ઉમેરેલી નથી'
                : 'કોઈ પરિણામ મળ્યું નથી',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            _query.isEmpty
                ? 'તમારા ખેતર, પાક અને સિંચાઈનું આયોજન સાચવવા ઉમેરો પર ટૅપ કરો.'
                : 'બીજા શબ્દથી શોધવાનો પ્રયાસ કરો.',
            textAlign: TextAlign.center,
          ),
          if (_query.isEmpty) ...[
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _editFarm(),
              icon: const Icon(Icons.add),
              label: const Text('પહેલું ખેતર ઉમેરો'),
            ),
          ],
        ],
      ),
    ),
  );

  Widget _farmCard(FarmRecord farm) => Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.primarySurface,
          child: Icon(Icons.yard_outlined, color: AppColors.primary),
        ),
        title: Text(farm.name),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(switch (widget.section) {
            FarmSection.farms =>
              '${farm.area} એકર · ${farm.crop}\nવાવણી: ${farm.sowingDate}',
            FarmSection.crops =>
              '${farm.name} · ${farm.area} એકર\nવાવણી: ${farm.sowingDate}',
            FarmSection.irrigation =>
              farm.irrigationPlan.isEmpty
                  ? 'સિંચાઈ યોજના ઉમેરેલી નથી'
                  : farm.irrigationPlan,
          }),
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          tooltip: 'ખેતરનાં વિકલ્પો',
          onSelected: (value) {
            if (value == 'edit') _editFarm(farm);
            if (value == 'delete') _deleteFarm(farm);
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'edit', child: Text('સંપાદિત કરો')),
            PopupMenuItem(value: 'delete', child: Text('કાઢી નાખો')),
          ],
        ),
        onTap: () => _editFarm(farm),
      ),
    ),
  );
}

class _FarmEditor extends StatefulWidget {
  const _FarmEditor({this.existing});

  final FarmRecord? existing;

  @override
  State<_FarmEditor> createState() => _FarmEditorState();
}

class _FarmEditorState extends State<_FarmEditor> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _areaController;
  late final TextEditingController _cropController;
  late final TextEditingController _sowingDateController;
  late final TextEditingController _irrigationController;

  @override
  void initState() {
    super.initState();
    final farm = widget.existing;
    _nameController = TextEditingController(text: farm?.name ?? '');
    _areaController = TextEditingController(text: farm?.area.toString() ?? '');
    _cropController = TextEditingController(text: farm?.crop ?? '');
    _sowingDateController = TextEditingController(text: farm?.sowingDate ?? '');
    _irrigationController = TextEditingController(
      text: farm?.irrigationPlan ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _areaController.dispose();
    _cropController.dispose();
    _sowingDateController.dispose();
    _irrigationController.dispose();
    super.dispose();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.pop(
      context,
      FarmRecord(
        id:
            widget.existing?.id ??
            DateTime.now().microsecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        area: double.parse(_areaController.text.trim()),
        crop: _cropController.text.trim(),
        sowingDate: _sowingDateController.text.trim(),
        irrigationPlan: _irrigationController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.existing == null ? 'ખેતર ઉમેરો' : 'ખેતર સંપાદિત કરો'),
    content: SizedBox(
      width: 420,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _field(_nameController, 'ખેતરનું નામ', required: true),
              _field(
                _areaController,
                'વિસ્તાર (એકર)',
                required: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  final area = double.tryParse(value?.trim() ?? '');
                  if (area == null || area <= 0) {
                    return 'શૂન્ય કરતાં મોટો વિસ્તાર દાખલ કરો';
                  }
                  return null;
                },
              ),
              _field(_cropController, 'પાક', required: true),
              _field(_sowingDateController, 'વાવણી તારીખ'),
              _field(_irrigationController, 'સિંચાઈ યોજના'),
            ],
          ),
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('રદ કરો'),
      ),
      FilledButton(onPressed: _save, child: const Text('સાચવો')),
    ],
  );

  Widget _field(
    TextEditingController controller,
    String label, {
    bool required = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
      validator:
          validator ??
          (required
              ? (value) => value == null || value.trim().isEmpty
                    ? 'આ માહિતી જરૂરી છે'
                    : null
              : null),
    ),
  );
}
