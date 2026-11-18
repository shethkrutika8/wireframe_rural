import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmerAccount {
  const FarmerAccount({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.district,
    required this.taluka,
    required this.language,
    required this.passwordSalt,
    required this.passwordDigest,
  });

  final String id;
  final String name;
  final String mobile;
  final String email;
  final String district;
  final String taluka;
  final String language;
  final String passwordSalt;
  final String passwordDigest;

  factory FarmerAccount.fromJson(Map<String, dynamic> json) => FarmerAccount(
    id: json['id'] as String,
    name: json['name'] as String,
    mobile: json['mobile'] as String,
    email: json['email'] as String? ?? '',
    district: json['district'] as String? ?? '',
    taluka: json['taluka'] as String? ?? '',
    language: json['language'] as String? ?? 'ગુજરાતી',
    passwordSalt: json['passwordSalt'] as String,
    passwordDigest: json['passwordDigest'] as String,
  );

  FarmerAccount copyWith({
    String? name,
    String? mobile,
    String? email,
    String? district,
    String? taluka,
    String? language,
  }) => FarmerAccount(
    id: id,
    name: name ?? this.name,
    mobile: mobile ?? this.mobile,
    email: email ?? this.email,
    district: district ?? this.district,
    taluka: taluka ?? this.taluka,
    language: language ?? this.language,
    passwordSalt: passwordSalt,
    passwordDigest: passwordDigest,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'mobile': mobile,
    'email': email,
    'district': district,
    'taluka': taluka,
    'language': language,
    'passwordSalt': passwordSalt,
    'passwordDigest': passwordDigest,
  };
}

class FarmRecord {
  const FarmRecord({
    required this.id,
    required this.name,
    required this.area,
    required this.crop,
    required this.sowingDate,
    required this.irrigationPlan,
  });

  final String id;
  final String name;
  final double area;
  final String crop;
  final String sowingDate;
  final String irrigationPlan;

  factory FarmRecord.fromJson(Map<String, dynamic> json) => FarmRecord(
    id: json['id'] as String,
    name: json['name'] as String,
    area: (json['area'] as num).toDouble(),
    crop: json['crop'] as String,
    sowingDate: json['sowingDate'] as String,
    irrigationPlan: json['irrigationPlan'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'area': area,
    'crop': crop,
    'sowingDate': sowingDate,
    'irrigationPlan': irrigationPlan,
  };
}

class AppStore extends ChangeNotifier {
  AppStore._();

  static final AppStore instance = AppStore._();
  static const _accountsKey = 'agriconnect.accounts.v1';
  static const _sessionKey = 'agriconnect.session.v1';

  late SharedPreferences _preferences;
  FarmerAccount? currentAccount;
  List<FarmRecord> farms = [];
  bool notificationsEnabled = true;

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    currentAccount = null;
    farms = [];
    notificationsEnabled = true;
    final sessionId = _preferences.getString(_sessionKey);
    if (sessionId == null) return;

    final accounts = _readAccounts();
    final matching = accounts.where((account) => account.id == sessionId);
    if (matching.isEmpty) {
      await _preferences.remove(_sessionKey);
      return;
    }

    currentAccount = matching.first;
    farms = _readFarms(currentAccount!.id);
    notificationsEnabled =
        _preferences.getBool(_notificationsKey(currentAccount!.id)) ?? true;
  }

  Future<void> register({
    required String name,
    required String mobile,
    required String email,
    required String password,
    required String district,
    required String taluka,
    required String language,
  }) async {
    final normalizedMobile = mobile.trim();
    final normalizedEmail = email.trim().toLowerCase();
    final accounts = _readAccounts();
    final duplicate = accounts.any(
      (account) =>
          account.mobile == normalizedMobile ||
          (normalizedEmail.isNotEmpty &&
              account.email.toLowerCase() == normalizedEmail),
    );
    if (duplicate) {
      throw const AppStoreException(
        'આ મોબાઇલ નંબર અથવા ઈમેઈલ સાથે ખાતું પહેલેથી નોંધાયેલું છે.',
      );
    }

    final salt = _randomHex(16);
    final account = FarmerAccount(
      id: _randomHex(16),
      name: name.trim(),
      mobile: normalizedMobile,
      email: normalizedEmail,
      district: district,
      taluka: taluka,
      language: language,
      passwordSalt: salt,
      passwordDigest: _digest(password, salt),
    );
    accounts.add(account);
    await _writeAccounts(accounts);
    await _saveSession(account.id);
    currentAccount = account;
    farms = [];
    notificationsEnabled = true;
    notifyListeners();
  }

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    final normalizedIdentifier = identifier.trim().toLowerCase();
    FarmerAccount? match;
    for (final account in _readAccounts()) {
      if (account.mobile.toLowerCase() == normalizedIdentifier ||
          account.email.toLowerCase() == normalizedIdentifier) {
        match = account;
        break;
      }
    }

    if (match == null ||
        _digest(password, match.passwordSalt) != match.passwordDigest) {
      throw const AppStoreException('લૉગિન વિગતો સાચી નથી. ફરી તપાસો.');
    }

    await _saveSession(match.id);
    currentAccount = match;
    farms = _readFarms(match.id);
    notificationsEnabled =
        _preferences.getBool(_notificationsKey(match.id)) ?? true;
    notifyListeners();
  }

  Future<void> updateProfile({
    required String name,
    required String mobile,
    required String email,
    required String district,
    required String taluka,
    required String language,
  }) async {
    final account = _requireAccount();
    final normalizedMobile = mobile.trim();
    final normalizedEmail = email.trim().toLowerCase();
    final duplicate = _readAccounts().any(
      (other) =>
          other.id != account.id &&
          (other.mobile == normalizedMobile ||
              (normalizedEmail.isNotEmpty &&
                  other.email.toLowerCase() == normalizedEmail)),
    );
    if (duplicate) {
      throw const AppStoreException(
        'આ મોબાઇલ નંબર અથવા ઈમેઈલ અન્ય ખાતામાં નોંધાયેલું છે.',
      );
    }

    final updated = account.copyWith(
      name: name.trim(),
      mobile: normalizedMobile,
      email: normalizedEmail,
      district: district,
      taluka: taluka,
      language: language,
    );
    await _replaceAccount(updated);
    currentAccount = updated;
    notifyListeners();
  }

  Future<void> saveNotificationsEnabled(bool enabled) async {
    final account = _requireAccount();
    final saved = await _preferences.setBool(
      _notificationsKey(account.id),
      enabled,
    );
    if (!saved) {
      throw const AppStoreException('સૂચના સેટિંગ સાચવી શકાયું નથી.');
    }
    notificationsEnabled = enabled;
    notifyListeners();
  }

  Future<void> saveFarm(FarmRecord farm) async {
    final account = _requireAccount();
    final next = List<FarmRecord>.of(farms);
    final index = next.indexWhere((item) => item.id == farm.id);
    if (index == -1) {
      next.add(farm);
    } else {
      next[index] = farm;
    }
    await _writeFarms(account.id, next);
    farms = next;
    notifyListeners();
  }

  Future<void> deleteFarm(String id) async {
    final account = _requireAccount();
    final next = farms.where((farm) => farm.id != id).toList();
    await _writeFarms(account.id, next);
    farms = next;
    notifyListeners();
  }

  Future<void> logout() async {
    await _preferences.remove(_sessionKey);
    currentAccount = null;
    farms = [];
    notificationsEnabled = true;
    notifyListeners();
  }

  List<FarmerAccount> _readAccounts() {
    final raw = _preferences.getString(_accountsKey);
    if (raw == null) return [];
    return (jsonDecode(raw) as List<dynamic>)
        .map((item) => FarmerAccount.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _writeAccounts(List<FarmerAccount> accounts) async {
    final saved = await _preferences.setString(
      _accountsKey,
      jsonEncode(accounts.map((account) => account.toJson()).toList()),
    );
    if (!saved) throw const AppStoreException('એકાઉન્ટ સાચવી શકાયું નથી.');
  }

  Future<void> _saveSession(String accountId) async {
    final saved = await _preferences.setString(_sessionKey, accountId);
    if (!saved) throw const AppStoreException('લૉગિન સેશન સાચવી શકાયું નથી.');
  }

  Future<void> _replaceAccount(FarmerAccount updated) async {
    final accounts = _readAccounts();
    final index = accounts.indexWhere((account) => account.id == updated.id);
    if (index == -1) {
      throw const AppStoreException('એકાઉન્ટ મળ્યું નથી. ફરી લૉગિન કરો.');
    }
    accounts[index] = updated;
    await _writeAccounts(accounts);
  }

  List<FarmRecord> _readFarms(String accountId) {
    final raw = _preferences.getString(_farmsKey(accountId));
    if (raw == null) return [];
    return (jsonDecode(raw) as List<dynamic>)
        .map((item) => FarmRecord.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _writeFarms(String accountId, List<FarmRecord> records) async {
    final saved = await _preferences.setString(
      _farmsKey(accountId),
      jsonEncode(records.map((farm) => farm.toJson()).toList()),
    );
    if (!saved) throw const AppStoreException('ખેતરની માહિતી સાચવી શકાયી નથી.');
  }

  FarmerAccount _requireAccount() {
    final account = currentAccount;
    if (account == null) {
      throw const AppStoreException('આગળ વધવા માટે પહેલાં લૉગિન કરો.');
    }
    return account;
  }

  String _notificationsKey(String accountId) =>
      'agriconnect.$accountId.notifications';

  String _farmsKey(String accountId) => 'agriconnect.$accountId.farms.v1';

  String _randomHex(int byteCount) {
    final random = Random.secure();
    return List<int>.generate(
      byteCount,
      (_) => random.nextInt(256),
    ).map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }

  String _digest(String password, String salt) {
    final hmac = Hmac(sha256, utf8.encode(password));
    final firstBlock = Uint8List.fromList([...utf8.encode(salt), 0, 0, 0, 1]);
    var u = hmac.convert(firstBlock).bytes;
    final result = Uint8List.fromList(u);
    for (var iteration = 1; iteration < 100000; iteration++) {
      u = hmac.convert(u).bytes;
      for (var index = 0; index < result.length; index++) {
        result[index] ^= u[index];
      }
    }
    return result.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }
}

class AppStoreException implements Exception {
  const AppStoreException(this.message);

  final String message;

  @override
  String toString() => message;
}
