import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery/features/home/presentation/view_model/home_cubit.dart';
import 'package:flowery/features/home/presentation/view_model/home_state.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          previous.profileState != current.profileState,
      builder: (context, state) {
        final profile = state.profileState.data;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi ${profile?.firstName ?? 'Elevate'} ,',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Let's Start Your Day",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey[800],
                backgroundImage:
                    (profile?.photo != null && profile!.photo.isNotEmpty)
                    ? NetworkImage(profile.photo)
                    : const NetworkImage(
                        "https://fitness.elevateegy.com/uploads/default-profile.png",
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
