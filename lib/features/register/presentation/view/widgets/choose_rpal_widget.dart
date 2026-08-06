import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PhysicalActivityLevel {
  rookie('Rookie', 'level1'),
  beginner('Beginner', 'level2'),
  intermediate('Intermediate', 'level3'),
  advance('Advance', 'level4'),
  trueBeast('True Beast', 'level5');

  final String label;
  final String value;

  const PhysicalActivityLevel(this.label, this.value);
}

class ChooseRpalWidget extends StatefulWidget {
  const ChooseRpalWidget({super.key});

  @override
  State<ChooseRpalWidget> createState() => _ChooseRpalWidgetState();
}

class _ChooseRpalWidgetState extends State<ChooseRpalWidget> {
  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        Text(
          AppLocalizations.of(context)!.physicalActivityLevel,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(height: height * 0.02),
        GlassContainer(
          children: [
            ...PhysicalActivityLevel.values.map((level) {
              final isSelected =
                  registerCubit.surveyData.physicalActivityLevel ==
                      level.value;
              return GestureDetector(
                onTap: () => setState(() {
                  registerCubit.surveyData.physicalActivityLevel = level.value;
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
                        level.label,
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
              visible: registerCubit.surveyData.physicalActivityLevel != null,
              child: SizedBox(
                height: height * 0.06,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    registerCubit.doIntent(Register());
                  },
                  child: Text(
                    AppLocalizations.of(context)!.submit,
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