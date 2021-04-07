import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_standard_app/blocs/auth/auth_cubit.dart';
import 'package:flutter_standard_app/repositories/auth_repository.dart';
import 'package:flutter_standard_app/repositories/user_repository.dart';
import 'package:flutter_standard_app/routing/pages.dart';
import 'package:flutter_standard_app/routing/routes.dart';
import 'package:flutter_standard_app/screens/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

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
          create: (context) =>
              AuthCubit(authRepository: context.read<AuthRepository>()),
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
      if (state.state == AuthStateEnum.loggedIn) {
        Get.offAllNamed(AppRoutes.home);
        return;
      }
      if (state.state == AuthStateEnum.logOut) {
        Get.offAllNamed(AppRoutes.splashScreen);
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return addReposProviders(
      child: addBlocsProviders(
        child: BlocBuilder<AuthCubit, AuthState>(builder: (_, authState) {
          return BlocListener<AuthCubit, AuthState>(
            listener: (_, state) {
              listenAuthState(state);
            },
            listenWhen: (_, state) {
              return state.state == AuthStateEnum.logOut ||
                  state.state == AuthStateEnum.loggedIn;
            },
            child: GetMaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: SplashScreen(),
              initialRoute: AppRoutes.splashScreen,
              onGenerateRoute: AppPages.instance.onGenerateRoute,
            ),
          );
        }),
      ),
    );
  }

  AuthCubit get _authCubit => context.read<AuthCubit>();
}
