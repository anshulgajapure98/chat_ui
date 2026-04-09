import 'package:chat_ui/routes/route_names.dart';
import 'package:chat_ui/screen/login/cubit/login_screen_cubit.dart';
import 'package:chat_ui/screen/widget/common_button.dart';
import 'package:chat_ui/screen/widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: BlocConsumer<LoginScreenCubit, LoginScreenState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Login Successful")));

            GoRouter.of(context).go(RouteNames.home);
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    CustomTextField(
                      controller: emailController,
                      labelText: "Email",
                      hintText: "Enter Email",
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: passwordController,
                      labelText: "Password",
                      hintText: "Enter Password",
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        if (value.length < 6) {
                          return "Minimum 6 characters required";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),
                    state is AuthLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 50,
                            child: CustomButton(
                              text: "Login",
                              isLoading: state is AuthLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginScreenCubit>().login(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                }
                              },
                            ),
                          ),

                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go(RouteNames.signup);
                      },
                      child: const Text("Don't have an account? Signup"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
