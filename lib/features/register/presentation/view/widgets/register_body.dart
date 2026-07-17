import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/glass_container.dart';
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
    if (value.trim().length < 2) return '$fieldName must be at least 2 characters';
    return null;
  }

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Form(
      key: widget.registerCubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hey there,', style: Theme.of(context).textTheme.bodyLarge),
          Text(
            'Create an Account',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: height * 0.02),
          GlassContainer(
            children: [
              Text(
                'Register',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: height * 0.02),
              TextFormField(
                validator: (v) => _validateName(v, 'First name'),
                controller: widget.registerCubit.firstNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'First Name',
                ),
              ),
              SizedBox(height: height * 0.02),
              TextFormField(
                controller: widget.registerCubit.lastNameController,
                validator: (v) => _validateName(v, 'Last name'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'Last Name',
                ),
              ),
              SizedBox(height: height * 0.02),
              TextFormField(
                controller: widget.registerCubit.emailController,
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'Email',
                ),
              ),
              SizedBox(height: height * 0.02),
              TextFormField(
                validator: _validatePassword,
                controller: widget.registerCubit.passwordController,
                obscureText: _obscure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: height * 0.04),
              SizedBox(
                height: height * 0.06,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.registerCubit.formKey.currentState!.validate()) {
                      widget.registerCubit.doIntent(RegisterNextStep());
                    }
                  },
                  child: Text(
                    'Register',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ],
      ),
    );
  }
}