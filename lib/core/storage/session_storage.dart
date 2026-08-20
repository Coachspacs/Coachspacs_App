import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:coach_space/features/auth/data/models/user_session.dart';

/// Typed secure persistence for the authentication session.
///
/// Wraps [FlutterSecureStorage] (Android Keystore / iOS Keychain) so the rest
/// of the app never touches raw storage keys. Stores the JWT pair plus the
/// role and approval status needed to restore the session on startup.
class SessionStorage {
  SessionStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  static const String _accessKey = 'auth_access_token';
  static const String _refreshKey = 'auth_refresh_token';
  static const String _sessionKey = 'auth_session';

  final FlutterSecureStorage _storage;

  /// Persists the full session (tokens + role + approval status).
  Future<void> saveSession(UserSession session) async {
    await _storage.write(key: _accessKey, value: session.access);
    if (session.refresh != null && session.refresh!.isNotEmpty) {
      await _storage.write(key: _refreshKey, value: session.refresh);
    }
    await _storage.write(key: _sessionKey, value: jsonEncode(session.toJson()));
  }

  /// Updates only the JWT pair, preserving the stored identity flags.
  ///
  /// Used by the refresh flow where the backend rotates the tokens but the
  /// role/approval status stay unchanged.
  Future<void> updateTokens({required String access, String? refresh}) async {
    final session = await readSession();
    await _storage.write(key: _accessKey, value: access);
    if (refresh != null && refresh.isNotEmpty) {
      await _storage.write(key: _refreshKey, value: refresh);
    }
    if (session != null) {
      await saveSession(session.copyWith(access: access, refresh: refresh));
    }
  }

  Future<UserSession?> readSession() async {
    try {
      final raw = await _storage.read(key: _sessionKey);
      if (raw == null || raw.isEmpty) return null;
      final json = jsonDecode(raw);
      if (json is! Map<String, dynamic>) return null;
      final session = UserSession.fromJson(json);
      return session.isAuthenticated ? session : null;
    } catch (_) {
      // Missing or corrupted value is treated as "logged out".
      return null;
    }
  }

  Future<String?> readAccessToken() => _storage.read(key: _accessKey);

  Future<String?> readRefreshToken() => _storage.read(key: _refreshKey);

  Future<void> clear() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
    await _storage.delete(key: _sessionKey);
  }
}
