import 'package:bloc/bloc.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('🚀 BLoC Creado: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('🎯 Evento Disparado: ${event.runtimeType} en ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('🔄 Cambio de Estado en ${bloc.runtimeType}:');
    print('   Estado anterior: ${change.currentState}');
    print('   Nuevo estado: ${change.nextState}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('⚡ Transición en ${bloc.runtimeType}:');
    print('   Evento: ${transition.event}');
    print('   Cambio: ${transition.currentState} → ${transition.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('❌ Error en ${bloc.runtimeType}:');
    print('   Error: $error');
    print('   StackTrace: $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('🔴 BLoC Cerrado: ${bloc.runtimeType}');
  }
}