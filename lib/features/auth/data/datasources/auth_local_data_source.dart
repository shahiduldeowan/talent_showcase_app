import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show AppConstants, CacheException;

abstract class AuthLocalDataSource {
  Future<void> cacheAuthData({
    required String accessToken,
    required String refreshToken,
  });
  Future<void> cacheAccessToken(String accessToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearAuthData();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  @override
  Future<void> cacheAuthData({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await _writeToStorage(AppConstants.accessTokenKey, accessToken);
      await _writeToStorage(AppConstants.refreshTokenKey, refreshToken);
    } catch (e) {
      throw CacheException('Failed to cache tokens: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheAccessToken(String accessToken) async {
    try {
      await _writeToStorage(AppConstants.accessTokenKey, accessToken);
    } catch (e) {
      throw CacheException('Failed to cache access token: ${e.toString()}');
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      return await _readFromStorage(AppConstants.accessTokenKey);
    } catch (e) {
      throw CacheException('Failed to get access token: ${e.toString()}');
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return await _readFromStorage(AppConstants.refreshTokenKey);
    } catch (e) {
      throw CacheException('Failed to get refresh token: ${e.toString()}');
    }
  }

  @override
  Future<void> clearAuthData() async {
    try {
      await _deleteFromStorage(AppConstants.accessTokenKey);
      await _deleteFromStorage(AppConstants.refreshTokenKey);
    } catch (e) {
      throw CacheException('Failed to clear tokens: ${e.toString()}');
    }
  }

  Future<void> _writeToStorage(String key, String value) async {
    try {
      await secureStorage.write(key: key, value: value);
    } catch (e) {
      throw CacheException('Failed to write to storage: ${e.toString()}');
    }
  }

  Future<String?> _readFromStorage(String key) async {
    try {
      return await secureStorage.read(key: key);
    } catch (e) {
      throw CacheException('Failed to read from storage: ${e.toString()}');
    }
  }

  Future<void> _deleteFromStorage(String key) async {
    try {
      await secureStorage.delete(key: key);
    } catch (e) {
      throw CacheException('Failed to delete from storage: ${e.toString()}');
    }
  }
}
