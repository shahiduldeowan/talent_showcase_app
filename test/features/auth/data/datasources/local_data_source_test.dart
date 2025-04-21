import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talent_showcase_app/core/errors/exceptions.dart'
    show CacheException;
import 'package:talent_showcase_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:talent_showcase_app/core/core_exports.dart' show AppConstants;

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockSecureStorage;
  late AuthLocalDataSource dataSource;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    dataSource = AuthLocalDataSourceImpl(secureStorage: mockSecureStorage);
  });

  group('cacheAuthData', () {
    const String accessToken = 'testAccessToken';
    const String refreshToken = 'testRefreshToken';

    test('should write access and refresh tokens to secure storage', () async {
      // Arrange
      when(
        () => mockSecureStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      // Act
      await dataSource.cacheAuthData(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      // Assert
      verify(
        () => mockSecureStorage.write(
          key: AppConstants.accessTokenKey,
          value: accessToken,
        ),
      ).called(1);
      verify(
        () => mockSecureStorage.write(
          key: AppConstants.refreshTokenKey,
          value: refreshToken,
        ),
      ).called(1);
    });

    test('should throw CacheException when writing fails', () async {
      // Arrange
      when(
        () => mockSecureStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenThrow(Exception('Write error'));

      // Act
      final Future<void> Function({
        required String accessToken,
        required String refreshToken,
      })
      call = dataSource.cacheAuthData;

      // Assert
      expect(
        () => call(accessToken: accessToken, refreshToken: refreshToken),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('getAccessToken', () {
    const String accessToken = 'testAccessToken';

    test('should return access token from secure storage', () async {
      // Arrange
      when(
        () => mockSecureStorage.read(key: any(named: 'key')),
      ).thenAnswer((_) async => accessToken);

      // Act
      final String? result = await dataSource.getAccessToken();

      // Assert
      expect(result, accessToken);
      verify(
        () => mockSecureStorage.read(key: AppConstants.accessTokenKey),
      ).called(1);
    });

    test('should throw CacheException when reading fails', () async {
      // Arrange
      when(
        () => mockSecureStorage.read(key: any(named: 'key')),
      ).thenThrow(Exception('Read error'));

      // Act
      final Future<String?> Function() call = dataSource.getAccessToken;

      // Assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('clearAuthData', () {
    test(
      'should delete access and refresh tokens from secure storage',
      () async {
        // Arrange
        when(
          () => mockSecureStorage.delete(key: any(named: 'key')),
        ).thenAnswer((_) async {});

        // Act
        await dataSource.clearAuthData();

        // Assert
        verify(
          () => mockSecureStorage.delete(key: AppConstants.accessTokenKey),
        ).called(1);
        verify(
          () => mockSecureStorage.delete(key: AppConstants.refreshTokenKey),
        ).called(1);
      },
    );

    test('should throw CacheException when deleting fails', () async {
      // Arrange
      when(
        () => mockSecureStorage.delete(key: any(named: 'key')),
      ).thenThrow(Exception('Delete error'));

      // Act
      final Future<void> Function() call = dataSource.clearAuthData;

      // Assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });
}
