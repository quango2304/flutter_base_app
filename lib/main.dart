import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_standard_app/blocs/auth/auth_cubit.dart';
import 'package:flutter_standard_app/repositories/auth_repository.dart';
import 'package:flutter_standard_app/repositories/user_repository.dart';
import 'package:flutter_standard_app/screens/home_screen/home_screen.dart';
import 'package:flutter_standard_app/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Widget addReposProviders({required Widget child}) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (context) => AuthRepository(logOut: logOut)),
      RepositoryProvider(
          create: (context) => UserRepository(
              logOut: logOut, authRepository: context.read<AuthRepository>()))
    ], child: child);
  }

  Widget addBlocsProviders({required Widget child}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(authRepository: context.read<AuthRepository>()),
        ),
      ],
      child: child,
    );
  }

  void logOut() {
    _authCubit.logOut();
  }

  void listenAuthState(AuthState state) {
    Future.delayed(Duration(milliseconds: 100), () {
      if (state.state == AuthStateEnum.login) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
        return;
      }
      if (state.state == AuthStateEnum.logOut) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => SplashScreen()),
            (route) => false);
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return addReposProviders(
      child: addBlocsProviders(
        child: BlocBuilder<AuthCubit, AuthState>(builder: (_, authState) {
          listenAuthState(authState);
          return MaterialApp(
            home: SplashScreen(),
          );
        }),
      ),
    );
  }

  AuthCubit get _authCubit => context.read<AuthCubit>();
}
