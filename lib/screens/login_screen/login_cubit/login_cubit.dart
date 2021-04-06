import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_standard_app/models/user_model.dart';
import 'package:flutter_standard_app/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit({required this.authRepository}) : super(LoginInitial());

  Future<UserModel?> logIn() async {
    return await authRepository.logIn();
  }
}
