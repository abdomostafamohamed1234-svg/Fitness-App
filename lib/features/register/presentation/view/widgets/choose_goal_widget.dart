import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChooseGoalWidget extends StatefulWidget {
  ChooseGoalWidget({super.key, required this.registerCubit});
  RegisterCubit registerCubit;

  @override
  State<ChooseGoalWidget> createState() => _ChooseGoalWidgetState();
}

class _ChooseGoalWidgetState extends State<ChooseGoalWidget> {
  static const _goals = [
    ('Gain Weight', 'Gain Weight'),
    ('Lose Weight', 'Lose Weight'),
    ('Get Fitter', 'Get Fitter'),
    ('Gain More Flexible', 'Gain More Flexible'),
    ('Learn The Basics', 'Learn The Basic'),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        Text(
          'What is Your Goal?',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          'This helps us create your personalized plan',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(height: height * 0.02),
        GlassContainer(
          children: [
            ..._goals.map((entry) {
              final label = entry.$1;
              final value = entry.$2;
              final isSelected = widget.registerCubit.goal == value;
              return GestureDetector(
                onTap: () => setState(() {
                  widget.registerCubit.goal = value;
                }),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected
                        ? AppColors.primaryColor.withValues(alpha: 0.15)
                        : Colors.white.withValues(alpha: 0.05),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.white.withValues(alpha: 0.15),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          color: isSelected ? AppColors.primaryColor : null,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: height * 0.02),
            Visibility(
              visible: widget.registerCubit.goal != null,
              child: SizedBox(
                height: height * 0.06,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.registerCubit.doIntent(RegisterNextStep());
                  },
                  child: Text(
                    'Next',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}