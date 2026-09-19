import 'package:flowery/features/change_password/presentation/states/change_password_states.dart';
import 'package:flowery/features/change_password/presentation/view_model/change_password_view_model.dart';
import 'package:flowery/features/change_password/presentation/widgets/change_password_background.dart';
import 'package:flowery/features/change_password/presentation/widgets/change_password_form.dart';
import 'package:flowery/features/change_password/presentation/widgets/change_password_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ChangePasswordViewModel, ChangePasswordState>(
        listener: (context, state) {
          if (state.isDone && state.message != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        child: const ChangePasswordBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ChangePasswordHeader(),
                  SizedBox(height: 40),
                  ChangePasswordForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}