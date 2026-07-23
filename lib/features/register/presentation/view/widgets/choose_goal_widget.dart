import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum RegisterGoal {
  gainWeight('Gain Weight', 'Gain Weight'),
  loseWeight('Lose Weight', 'Lose Weight'),
  getFitter('Get Fitter', 'Get Fitter'),
  gainMoreFlexible('Gain More Flexible', 'Gain More Flexible'),
  learnTheBasics('Learn The Basics', 'Learn The Basic');

  final String label;
  final String value;

  const RegisterGoal(this.label, this.value);
}

class ChooseGoalWidget extends StatefulWidget {
  const ChooseGoalWidget({super.key});

  @override
  State<ChooseGoalWidget> createState() => _ChooseGoalWidgetState();
}

class _ChooseGoalWidgetState extends State<ChooseGoalWidget> {
  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    final height = MediaQuery.of(context).size.height;
    final locale = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        Text(
          locale.whatIsYourGoal,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          locale.personalizedPlanHint,

          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
        ),
        SizedBox(height: height * 0.02),
        GlassContainer(
          children: [
            ...RegisterGoal.values.map((goal) {
              final isSelected = registerCubit.goal == goal.value;
              return GestureDetector(
                onTap: () => setState(() {
                  registerCubit.goal = goal.value;
                }),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: isSelected
                        ? Theme.of(context).primaryColor.withValues(alpha: 0.15)
                        : Colors.white.withValues(alpha: 0.05),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.white.withValues(alpha: 0.15),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        goal.label,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontSize: 12),
                      ),
                      const Spacer(),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: height * 0.02),
            Visibility(
              visible: registerCubit.goal != null,
              child: SizedBox(
                height: height * 0.06,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    registerCubit.doIntent(RegisterNextStep());
                  },
                  child: Text(
                    locale.next,
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
