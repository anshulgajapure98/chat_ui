import 'package:chat_ui/routes/route_names.dart';
import 'package:chat_ui/screen/home/cubit/channel_cubit.dart';
import 'package:chat_ui/screen/home/cubit/dmcubit_cubit.dart';
import 'package:chat_ui/screen/home/screen/home_screen.dart';
import 'package:chat_ui/screen/login/cubit/login_screen_cubit.dart';
import 'package:chat_ui/screen/login/cubit/signup_screen_cubit.dart';
import 'package:chat_ui/screen/login/screen/login_screen.dart';
import 'package:chat_ui/screen/login/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: RouteNames.initialRoutes,
      name: 'login',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<LoginScreenCubit>(
            create: (context) => LoginScreenCubit(),
          ),
        ],
        child: LoginScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.signup,
      name: 'signup',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<SignupScreenCubit>(
            create: (context) => SignupScreenCubit(),
          ),
        ],
        child: SignupScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.home,
      name: 'home',
      builder: (context, state) => HomeScreen(),
    ),
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text("Page not found: ${state.error}"))),
);
