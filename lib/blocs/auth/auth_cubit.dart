import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_standard_app/models/user_model.dart';
import 'package:flutter_standard_app/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(AuthState(state: AuthStateEnum.loading));
}
