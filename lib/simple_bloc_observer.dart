import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('✅ onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('🔄 onChange -- ${bloc.runtimeType}');
    print('   Current State: ${change.currentState}');
    print('   Next State: ${change.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('❌ onError -- ${bloc.runtimeType}');
    print('   Error: $error');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('🔒 onClose -- ${bloc.runtimeType}');
  }
}
