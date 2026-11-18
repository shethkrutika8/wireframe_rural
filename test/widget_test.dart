import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wireframe_rural/main.dart';
import 'package:wireframe_rural/navigation/app_routes.dart';
import 'package:wireframe_rural/services/app_store.dart';

void main() {
  testWidgets('AgriConnect App Smoke Test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await AppStore.instance.initialize();
    await tester.pumpWidget(const AgriConnectApp());
    await tester.pumpAndSettle();
    expect(find.text('farmer welfare application'), findsOneWidget);
  });

  testWidgets('protected route redirects unauthenticated users to login', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await AppStore.instance.initialize();
    await tester.pumpWidget(const AgriConnectApp());
    await tester.pumpAndSettle();

    tester
        .state<NavigatorState>(find.byType(Navigator))
        .pushNamed(AppRoutes.profile);
    await tester.pumpAndSettle();

    expect(find.text('તમારા ખાતામાં લૉગિન કરો'), findsOneWidget);
    expect(AppStore.instance.currentAccount, isNull);
  });

  testWidgets('main routes render at a narrow mobile width', (tester) async {
    tester.view.physicalSize = const Size(320, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({});
    await AppStore.instance.initialize();
    await AppStore.instance.register(
      name: 'Test Farmer',
      mobile: '1234567890',
      email: 'farmer@example.com',
      password: 'test-password',
      district: '',
      taluka: '',
      language: 'ગુજરાતી',
    );
    await tester.pumpWidget(const AgriConnectApp());
    await tester.pumpAndSettle();

    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    const routes = [
      AppRoutes.login,
      AppRoutes.register,
      AppRoutes.forgotPassword,
      AppRoutes.homeV1,
      AppRoutes.homeV2,
      AppRoutes.homeV3,
      AppRoutes.homeV4,
      AppRoutes.homeV5,
      AppRoutes.summary,
      AppRoutes.farms,
      AppRoutes.crops,
      AppRoutes.irrigation,
      AppRoutes.profile,
      AppRoutes.settings,
      AppRoutes.weather,
      AppRoutes.market,
      AppRoutes.schemes,
      AppRoutes.cropAdvisory,
      AppRoutes.support,
    ];
    for (final route in routes) {
      navigator.pushReplacementNamed<void, void>(route);
      await tester.pumpAndSettle();
      expect(
        tester.takeException(),
        isNull,
        reason: '$route should fit mobile',
      );
    }
  });
}
