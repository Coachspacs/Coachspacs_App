import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/api_client.dart';
import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/storage/session_storage.dart';
import 'package:coach_space/features/auth/data/models/approval_status.dart';
import 'package:coach_space/features/auth/data/models/forgot_password_request.dart';
import 'package:coach_space/features/auth/data/models/login_request.dart';
import 'package:coach_space/features/auth/data/models/register_request.dart';
import 'package:coach_space/features/auth/data/models/user_role.dart';
import 'package:coach_space/features/auth/data/models/user_session.dart';
import 'package:coach_space/features/auth/data/repo/auth_repository_impl.dart';

/// In-memory [SessionStorage] so unit tests never touch the platform channel.
class _MemorySessionStorage extends SessionStorage {
  UserSession? session;
  String? access;
  String? refresh;

  @override
  Future<void> saveSession(UserSession s) async {
    session = s;
    access = s.access;
    refresh = s.refresh;
  }

  @override
  Future<void> updateTokens({required String access, String? refresh}) async {
    this.access = access;
    if (refresh != null && refresh.isNotEmpty) {
      this.refresh = refresh;
    }
    if (session != null) {
      session = session!.copyWith(access: access, refresh: refresh);
    }
  }

  @override
  Future<UserSession?> readSession() async => session;

  @override
  Future<String?> readAccessToken() async => access;

  @override
  Future<String?> readRefreshToken() async => refresh;

  @override
  Future<void> clear() async {
    session = null;
    access = null;
    refresh = null;
  }
}

class _MockAdapter implements HttpClientAdapter {
  _MockAdapter(this._handler);

  final Future<ResponseBody> Function(
    RequestOptions options,
    List<RequestOptions> all,
  )
  _handler;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return _handler(options, requests);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(Object data, int status) => ResponseBody.fromString(
  jsonEncode(data),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

/// Retrofit serializes the request body to a JSON String before it reaches the
/// adapter; normalize that back to a Map for assertions.
Object? _bodyOf(RequestOptions options) =>
    options.data is String ? jsonDecode(options.data as String) : options.data;

void main() {
  late _MemorySessionStorage storage;

  AuthRepositoryImpl repoWith(_MockAdapter adapter) {
    final dio = ApiClient.create(sessionStorage: storage);
    dio.httpClientAdapter = adapter;
    return AuthRepositoryImpl(
      apiService: ApiService(dio),
      sessionStorage: storage,
    );
  }

  setUp(() {
    storage = _MemorySessionStorage();
  });

  group('AuthRepositoryImpl.login', () {
    test('posts credentials and persists a parsed UserSession', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.path, 'api/auth/login');
        expect(options.method, 'POST');
        expect(_bodyOf(options), {'email': 'a@b.com', 'password': 'secret'});
        return _json({
          'access': 'access-1',
          'refresh': 'refresh-1',
          'role': 'student',
          'approval_status': 'approved',
        }, 200);
      });

      final session = await repoWith(
        adapter,
      ).login(const LoginRequest(email: 'a@b.com', password: 'secret'));

      expect(session.access, 'access-1');
      expect(session.refresh, 'refresh-1');
      expect(session.role, UserRole.student);
      expect(session.isPendingInstructor, isFalse);
      expect(storage.session?.access, 'access-1');
      expect(storage.access, 'access-1');
      expect(storage.refresh, 'refresh-1');
    });

    test('surfaces the backend 401 detail as a NetworkException', () async {
      final adapter = _MockAdapter((options, all) async {
        return _json({
          'detail': 'No active account found with the given credentials.',
        }, 401);
      });

      expect(
        () => repoWith(
          adapter,
        ).login(const LoginRequest(email: 'a@b.com', password: 'nope')),
        throwsA(
          isA<NetworkException>().having(
            (e) => e.kind,
            'kind',
            FailureKind.unauthorized,
          ),
        ),
      );
    });

    test('parses an instructor + pending login', () async {
      final adapter = _MockAdapter((options, all) async {
        return _json({
          'access': 'access-1',
          'refresh': 'refresh-1',
          'role': 'instructor',
          'approval_status': 'pending',
        }, 200);
      });

      final session = await repoWith(
        adapter,
      ).login(const LoginRequest(email: 't@c.com', password: 'secret'));

      expect(session.role, UserRole.instructor);
      expect(session.isPendingInstructor, isTrue);
    });
  });

  group('AuthRepositoryImpl.register', () {
    test('sends full_name + role and parses RegisterResponse', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.path, 'api/auth/register');
        expect(_bodyOf(options), {
          'full_name': 'Jane Doe',
          'email': 'jane@example.com',
          'password': 'secret',
          'role': 'student',
        });
        return _json({
          'id': 7,
          'email': 'jane@example.com',
          'role': 'student',
          'detail': 'Account created. Check your inbox to verify your email.',
        }, 201);
      });

      final result = await repoWith(adapter).register(
        const RegisterRequest(
          fullName: 'Jane Doe',
          email: 'jane@example.com',
          password: 'secret',
          role: UserRole.student,
        ),
      );

      expect(result.id, 7);
      expect(result.role, UserRole.student);
      expect(result.detail, contains('inbox'));
      // Registration never authenticates: no session is persisted.
      expect(storage.session, isNull);
    });
  });

  group('AuthRepositoryImpl.forgotPassword', () {
    test('posts to api/auth/password/forgot', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.path, 'api/auth/password/forgot');
        expect(_bodyOf(options), {'email': 'a@b.com'});
        return _json({'detail': 'Reset link sent.'}, 200);
      });

      await repoWith(
        adapter,
      ).forgotPassword(ForgotPasswordRequest(email: 'a@b.com'));
      expect(adapter.requests, hasLength(1));
    });
  });

  group('AuthRepositoryImpl.logout', () {
    test('clears the local session even when the server call fails', () async {
      storage.saveSession(
        const UserSession(
          access: 'access-1',
          refresh: 'refresh-1',
          role: UserRole.student,
          approvalStatus: ApprovalStatus.approved,
        ),
      );

      final adapter = _MockAdapter((options, all) async {
        if (options.path == 'api/auth/logout') {
          expect(_bodyOf(options), {'refresh': 'refresh-1'});
          return _json({'detail': 'connection lost'}, 500);
        }
        return _json(<String, dynamic>{}, 404);
      });

      final repo = repoWith(adapter);
      await repo.logout(); // must not throw

      expect(storage.session, isNull);
      expect(storage.access, isNull);
      expect(storage.refresh, isNull);
    });
  });

  group('AuthInterceptor refresh-on-401', () {
    test('attaches Bearer token, refreshes once, and retries', () async {
      storage.saveSession(
        const UserSession(
          access: 'stale-access',
          refresh: 'stale-refresh',
          role: UserRole.student,
          approvalStatus: ApprovalStatus.approved,
        ),
      );

      var logoutAttempts = 0;
      final adapter = _MockAdapter((options, all) async {
        if (options.path == 'api/auth/logout') {
          logoutAttempts++;
          expect(
            options.headers['Authorization'],
            logoutAttempts == 1 ? 'Bearer stale-access' : 'Bearer new-access',
          );
          if (logoutAttempts == 1) {
            return _json({
              'detail': 'Given token not valid for any token type',
            }, 401);
          }
          return _json(<String, dynamic>{}, 200);
        }
        if (options.path == 'api/auth/refresh') {
          expect(_bodyOf(options), {'refresh': 'stale-refresh'});
          return _json({'access': 'new-access', 'refresh': 'new-refresh'}, 200);
        }
        return _json(<String, dynamic>{}, 404);
      });

      final repo = repoWith(adapter);
      await repo.logout();

      // First attempt 401 -> refresh -> retried with the new access token.
      expect(logoutAttempts, 2);
      // Local tokens are always cleared once logout completes.
      expect(storage.access, isNull);
      expect(storage.refresh, isNull);
    });

    test('clears tokens when refresh fails', () async {
      storage.saveSession(
        const UserSession(
          access: 'stale-access',
          refresh: 'stale-refresh',
          role: UserRole.student,
          approvalStatus: ApprovalStatus.approved,
        ),
      );

      final adapter = _MockAdapter((options, all) async {
        if (options.path == 'api/auth/logout') {
          return _json({'detail': 'unauthorized'}, 401);
        }
        return _json({'detail': 'Token is invalid or expired'}, 401);
      });

      final repo = repoWith(adapter);
      await repo.logout(); // must not throw — logout is best-effort

      expect(storage.access, isNull);
      expect(storage.refresh, isNull);
    });
  });
}
