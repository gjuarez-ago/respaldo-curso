import 'package:bloc/bloc.dart';
import 'package:invent_app/bloc/auth/login.event.dart';
import 'package:invent_app/bloc/auth/login.state.dart';
import 'package:invent_app/services/auth.service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

final AuthService service = AuthService();

  LoginBloc() : super(InitialLoginState()) {
    on<EventAuth>(_onFetchPosts);
    // on<DeletePost>(_onDeletePost);
  }

  Future<void> _onFetchPosts(EventAuth event, Emitter<LoginState> emit) async {

    emit(IsLoadingAuth());
    try {
      final response = await service.login(event.user, event.password);
      emit(SuccessAuth(response: response));
    } catch (e) {
      emit(ErrorAuth(errorMessage:  e.toString()));
    }
  }

}