import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wireframe_rural/services/app_store.dart';

void main() {
  late AppStore store;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    store = AppStore.instance;
    await store.initialize();
  });

  test(
    'accounts and farm records persist separately per local account',
    () async {
      await store.register(
        name: 'Test Farmer',
        mobile: '9876543210',
        email: 'farmer@example.com',
        password: 'secure-pass-1',
        district: 'Rajkot',
        taluka: 'Rajkot Rural',
        language: 'English',
      );
      await store.saveFarm(
        const FarmRecord(
          id: 'farm-1',
          name: 'North field',
          area: 2.5,
          crop: 'Cotton',
          sowingDate: '2026-06-12',
          irrigationPlan: 'Drip',
        ),
      );

      await store.logout();
      await store.login(
        identifier: 'farmer@example.com',
        password: 'secure-pass-1',
      );

      expect(store.currentAccount?.name, 'Test Farmer');
      expect(store.farms, hasLength(1));
      expect(store.farms.single.crop, 'Cotton');

      await store.deleteFarm('farm-1');
      expect(store.farms, isEmpty);
      await store.logout();

      await store.register(
        name: 'Second Farmer',
        mobile: '9876543211',
        email: '',
        password: 'another-pass-1',
        district: 'Surat',
        taluka: 'Surat',
        language: 'ગુજરાતી',
      );
      expect(store.farms, isEmpty);
    },
  );

  test('rejects duplicate identifiers and incorrect passwords', () async {
    await store.register(
      name: 'Test Farmer',
      mobile: '9876543210',
      email: 'farmer@example.com',
      password: 'secure-pass-1',
      district: 'Rajkot',
      taluka: 'Rajkot Rural',
      language: 'English',
    );
    await store.logout();

    await expectLater(
      store.login(identifier: '9876543210', password: 'wrong-password'),
      throwsA(isA<AppStoreException>()),
    );
    await expectLater(
      store.register(
        name: 'Duplicate',
        mobile: '9876543210',
        email: '',
        password: 'another-pass-1',
        district: 'Surat',
        taluka: 'Surat',
        language: 'ગુજરાતી',
      ),
      throwsA(isA<AppStoreException>()),
    );
  });
}
