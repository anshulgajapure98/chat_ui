import 'package:chat_ui/routes/route_names.dart';
import 'package:chat_ui/screen/login/cubit/login_screen_cubit.dart';
import 'package:chat_ui/screen/login/login_screen.dart';
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
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text("Page not found: ${state.error}"))),
);
