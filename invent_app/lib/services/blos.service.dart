import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invent_app/bloc/auth/bloc.dart';
import 'package:invent_app/bloc/post/bloc.dart';

List<BlocProvider> blocsServices(String token) {
  return [
    BlocProvider<PostBloc>(
      create: (context) => PostBloc(),
    ),
      BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
    ),
  ];
}
