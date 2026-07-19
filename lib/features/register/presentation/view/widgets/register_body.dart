import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view/widgets/social_button.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterBody extends StatefulWidget {
  RegisterBody({super.key, required this.registerCubit});
  RegisterCubit registerCubit;

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  bool _obscure = true;

  String? _validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return '$fieldName is required';
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Form(
      key: widget.registerCubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hey there',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          Text(
            'Create an Account',
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontSize: 20),
          ),
          SizedBox(height: height * 0.02),
          GlassContainer(
            children: [
              Text(
                'Register',
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(fontSize: 20),
              ),
              SizedBox(height: height * 0.02),

              TextFormField(
                controller: widget.registerCubit.firstNameController,
                validator: (v) => _validateName(v, 'First Name'),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'First Name',
                  hintStyle: TextStyle(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 18,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(
                    // horizontal: 30,
                    vertical: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
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
                ),
              ),

              SizedBox(height: height * 0.02),
              TextFormField(
                controller: widget.registerCubit.lastNameController,
                validator: (v) => _validateName(v, 'Last Name'),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  hintStyle: TextStyle(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 18,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(
                    // horizontal: 30,
                    vertical: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
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
                ),
              ),

              SizedBox(height: height * 0.02),
              TextFormField(
                controller: widget.registerCubit.emailController,
                validator: (v) => _validateName(v, 'Email'),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(
                    // horizontal: 30,
                    vertical: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
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
                ),
              ),

              SizedBox(height: height * 0.02),

              TextFormField(
                controller: widget.registerCubit.passwordController,
                validator: _validatePassword,
                obscureText: _obscure,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
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
                ),
              ),

              SizedBox(height: height * 0.02),
              // ── Divider with "Or" ─────────────────────────
              const Row(
                children: [
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Or',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                ],
              ),
              const SizedBox(height: 10),

              // ── Social Login Icons ────────────────────────
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
              const SizedBox(height: 15),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.registerCubit.formKey.currentState!.validate()) {
                      widget.registerCubit.doIntent(RegisterNextStep());
                    }
                  },
                  child: Text(
                    'Register',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 12),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already Have An Account Yet ? ",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
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
