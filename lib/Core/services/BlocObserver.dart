import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class Bloc_Observer extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    log('Bloc Created: ${bloc.runtimeType}');
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    log('Bloc Event: ${bloc.runtimeType}, Event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    log('Bloc Change: ${bloc.runtimeType}, Change: $change');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    log('Bloc Transition: ${bloc.runtimeType}, Transition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('Bloc Error: ${bloc.runtimeType}, Error: $error, StackTrace: $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
