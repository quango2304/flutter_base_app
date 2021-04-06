part of 'auth_cubit.dart';

enum AuthStateEnum {
  loading,
  notLogin,
  logOut,
  login
}

class AuthState extends Equatable {
  final AuthStateEnum state;
  final UserModel? user;

  AuthState({required this.state, this.user});


  AuthState copyWith({
    AuthStateEnum? state,
    UserModel? user,
  }) =>
      AuthState(
        state: state ?? this.state,
        user: user ?? this.user,
      );

  AuthState copyWithNullable({
    required AuthStateEnum state,
    UserModel? user,
  }) =>
      AuthState(
        state: state,
        user: user,
      );

  @override
  List<Object> get props => [state];
}
