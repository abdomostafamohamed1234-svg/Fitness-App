import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/core/widgets/social_button.dart';
import 'package:flowery/features/login/presentation/view_model/cubit.dart';
import 'package:flowery/features/login/presentation/view_model/event.dart';
import 'package:flowery/features/login/presentation/view_model/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginBody extends StatefulWidget {
  LoginBody({super.key, required this.loginCubit});
  LoginCubit loginCubit;

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool _obscure = true;

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  InputDecoration _fieldDecoration({
    required String hint,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
      prefixIcon: Icon(prefixIcon, color: Colors.white, size: 18),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Form(
      key: widget.loginCubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Hey There', style: TextStyle(color: Colors.white, fontSize: 12)),
          Text(
            'WELCOME BACK',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20),
          ),
          SizedBox(height: height * 0.03),
          GlassContainer(
            children: [
              Text(
                'Login',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20),
              ),
              SizedBox(height: height * 0.03),

              // Email field
              TextFormField(
                controller: widget.loginCubit.emailController,
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                cursorColor: Colors.white,
                decoration: _fieldDecoration(
                  hint: 'Email',
                  prefixIcon: Icons.email_outlined,
                ),
              ),
              SizedBox(height: height * 0.02),

              // Password field
              TextFormField(
                controller: widget.loginCubit.passwordController,
                validator: _validatePassword,
                obscureText: _obscure,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                cursorColor: Colors.white,
                decoration: _fieldDecoration(
                  hint: 'Password',
                  prefixIcon: Icons.lock_outline_rounded,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Forget password link
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              // "Or" divider
              const Row(
                children: [
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('Or', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ),
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                ],
              ),
              const SizedBox(height: 16),

              // Social login icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(icon: Icons.facebook, onTap: () {}),
                  const SizedBox(width: 20),
                  SocialButton(label: 'G', onTap: () {}),
                  const SizedBox(width: 20),
                  SocialButton(icon: Icons.apple, onTap: () {}),
                ],
              ),
              SizedBox(height: height * 0.03),

              _LoginButton(loginCubit: widget.loginCubit),
              SizedBox(height: height * 0.02),

              // Bottom link row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Dont Have An Account Yet ? ",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () => widget.loginCubit.doEvent(NavigateToRegisterEvent()),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.loginCubit});

  final LoginCubit loginCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        final isLoading = state.loginState.state == StateType.loading;

        return SizedBox(
          height: 44,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    if (loginCubit.formKey.currentState!.validate()) {
                      loginCubit.doEvent(
                        LoginEvent(
                          email: loginCubit.emailController.text,
                          password: loginCubit.passwordController.text,
                        ),
                      );
                    }
                  },
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Login',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14),
                  ),
          ),
        );
      },
    );
  }
}
