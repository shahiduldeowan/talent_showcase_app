// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../routes.dart' as _i684;
import '../services/navigation_service.dart' as _i31;
import '../theme/my_theme.dart' as _i885;
import 'di.dart' as _i913;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final appModule = _$AppModule();
  await gh.singletonAsync<_i460.SharedPreferences>(
    () => appModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i558.FlutterSecureStorage>(() => appModule.secureStorage);
  gh.singleton<_i885.MyTheme>(() => _i885.MyTheme());
  gh.singleton<_i684.AppRoutes>(() => _i684.AppRoutes());
  gh.lazySingleton<_i31.NavigationService>(() => appModule.navigationService);
  return getIt;
}

class _$AppModule extends _i913.AppModule {}
