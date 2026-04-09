import 'package:chat_ui/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_ui/screen/login/cubit/login_screen_cubit.dart';
import 'package:chat_ui/screen/login/cubit/signup_screen_cubit.dart';

import 'screen/home/cubit/channel_cubit.dart';
import 'screen/home/cubit/dmcubit_cubit.dart';
import 'screen/home/cubit/message_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginScreenCubit()),
        BlocProvider(create: (_) => SignupScreenCubit()),
        BlocProvider(create: (_) => ChannelCubit()),
        BlocProvider(create: (_) => MessageCubit()),
        BlocProvider(create: (_) => DmcubitCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
