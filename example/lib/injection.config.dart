// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:orionstar_robot_example/core/client/token_interceptor.dart'
    as _i3;
import 'package:orionstar_robot_example/core/client/user_session.dart' as _i4;
import 'package:orionstar_robot_example/core/utils/configuration.dart' as _i5;
import 'package:orionstar_robot_example/core/utils/robot.dart' as _i6;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.TokenInterceptor>(
        () => _i3.TokenInterceptor(gh<_i4.IUserSession>()));
    gh.lazySingleton<_i5.Configuration>(
      () => _i5.DevConfiguration(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i5.Configuration>(
      () => _i5.StagingConfiguration(),
      registerFor: {_staging},
    );
    gh.lazySingleton<_i5.Configuration>(
      () => _i5.ProductionConfiguration(),
      registerFor: {_prod},
    );
    gh.singleton<_i4.IUserSession>(_i4.UserSession());
    gh.singleton<_i6.Robot>(_i6.Robot());
    return this;
  }
}
