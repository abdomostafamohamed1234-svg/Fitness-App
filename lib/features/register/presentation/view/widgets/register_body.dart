import 'package:flowery/config/helpers/validations/validators.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view/widgets/social_button.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  bool _obscure = true;

  String? _errorMessage(BuildContext context, ValidationError? error, String fieldName) {
    final loc = AppLocalizations.of(context)!;
    switch (error) {
      case null:
        return null;
      case ValidationError.required:
        return fieldName == 'First Name' ? loc.firstNameRequired :
               fieldName == 'Last Name' ? loc.lastNameRequired :
               fieldName == 'Email' ? loc.emailRequired :
               fieldName == 'Password' ? loc.passwordRequired : '$fieldName is required';
      case ValidationError.invalidName:
        return fieldName == 'First Name' ? loc.firstNameMinLength :
               fieldName == 'Last Name' ? loc.lastNameMinLength : '$fieldName must be at least 2 letters';
      case ValidationError.invalidEmail:
        return loc.invalidEmail;
      case ValidationError.invalidPassword:
        return loc.invalidPassword;
      case ValidationError.invalidConfirmPassword:
        return loc.invalidConfirmPassword;
      case ValidationError.passwordMismatch:
        return loc.passwordMismatch;
      case ValidationError.invalidPhoneNumber:
        return loc.invalidPhoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    final height = MediaQuery.of(context).size.height;
    final loc = AppLocalizations.of(context)!;
    return Form(
      key: registerCubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.heyThere,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 12),
          ),
          Text(
            loc.createAnAccount,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontSize: 20),
          ),
          SizedBox(height: height * 0.02),
          GlassContainer(
            children: [
              Text(
                loc.register,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(fontSize: 20),
              ),
              SizedBox(height: height * 0.02),

              TextFormField(
                controller: registerCubit.firstNameController,
                validator: (v) => _errorMessage(context, 
                  Validations.validateName(v),
                  'First Name',
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                cursorColor: Theme.of(context).colorScheme.onSurface,
                decoration: InputDecoration(
                  hintText: loc.firstName,
                  hintStyle: TextStyle(
                    // ignore: deprecated_member_use
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Theme.of(context).colorScheme.onSurface,
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
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),
              TextFormField(
                controller: registerCubit.lastNameController,
                validator: (v) => _errorMessage(context, 
                  Validations.validateName(v),
                  'Last Name',
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                cursorColor: Theme.of(context).colorScheme.onSurface,
                decoration: InputDecoration(
                  hintText: loc.lastName,
                  hintStyle: TextStyle(
                    // ignore: deprecated_member_use
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Theme.of(context).colorScheme.onSurface,
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
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),
              TextFormField(
                controller: registerCubit.emailController,
                validator: (v) => _errorMessage(context, 
                  Validations.validateEmail(v),
                  'Email',
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                cursorColor: Theme.of(context).colorScheme.onSurface,
                decoration: InputDecoration(
                  hintText: loc.email,
                  hintStyle: TextStyle(
                    // ignore: deprecated_member_use
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Theme.of(context).colorScheme.onSurface,
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
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),

              TextFormField(
                controller: registerCubit.passwordController,
                validator: (v) => _errorMessage(context, 
                  Validations.validatePassword(v),
                  'Password',
                ),
                obscureText: _obscure,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
                cursorColor: Theme.of(context).colorScheme.onSurface,
                decoration: InputDecoration(
                  hintText: loc.password,
                  hintStyle: TextStyle(
                    // ignore: deprecated_member_use
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 18,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 18,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),
              // ── Divider with "Or" ─────────────────────────
              Row(
                children: [
                  Expanded(child: Divider(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.24), thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      loc.or,
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.54), fontSize: 12),
                    ),
                  ),
                  Expanded(child: Divider(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.24), thickness: 1)),
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
                    if (registerCubit.formKey.currentState!.validate()) {
                      registerCubit.doIntent(RegisterNextStep());
                    }
                  },
                  child: Text(
                    loc.register,
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
                  Text(
                    loc.alreadyHaveAnAccount,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7), fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      loc.login,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
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