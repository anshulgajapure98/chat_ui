import 'package:chat_ui/routes/route_names.dart';
import 'package:chat_ui/screen/login/cubit/signup_screen_cubit.dart';
import 'package:chat_ui/screen/widget/common_button.dart';
import 'package:chat_ui/screen/widget/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: BlocConsumer<SignupScreenCubit, SignupScreenState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Signup Successful")));

            WidgetsBinding.instance.addPostFrameCallback((_) {
              GoRouter.of(context).go(RouteNames.initialRoutes);
            });
          }

          if (state is SignupError) {
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
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: confirmPasswordController,
                      labelText: "Confirm Password",
                      hintText: "Re-enter Password",
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                      validator: (value) {
                        if (value != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    state is SignupLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 50,
                            child: CustomButton(
                              text: "Signup",
                              isLoading: state is SignupLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<SignupScreenCubit>().signup(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                }
                              },
                            ),
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
