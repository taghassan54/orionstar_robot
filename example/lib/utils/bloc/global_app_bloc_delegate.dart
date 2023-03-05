import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      debugPrint('${bloc.runtimeType} $change');
    }
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint('${cubit.runtimeType} $error $stackTrace');
    }
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      debugPrint('onClose -- ${bloc.runtimeType}');
    }
  }


}