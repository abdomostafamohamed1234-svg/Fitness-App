import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChooseRpalWidget extends StatefulWidget {
  ChooseRpalWidget({super.key, required this.registerCubit});
  RegisterCubit registerCubit;

  @override
  State<ChooseRpalWidget> createState() => _ChooseRpalWidgetState();
}

class _ChooseRpalWidgetState extends State<ChooseRpalWidget> {
  static const _levels = [
    ('Rookie', 'level1'),
    ('Beginner', 'level2'),
    ('Intermediate', 'level3'),
    ('Advance', 'level4'),
    ('True Beast', 'level5'),
  ];

  @override
  Widget build(BuildContext context) {
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
            ..._levels.map((entry) {
              final label = entry.$1;
              final value = entry.$2;
              final isSelected = widget.registerCubit.physicalActivityLevel == value;
              return GestureDetector(
                onTap: () => setState(() {
                  widget.registerCubit.physicalActivityLevel = value;
                }),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 12),
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
              visible: widget.registerCubit.physicalActivityLevel != null,
              child: SizedBox(
                height: height * 0.06,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.registerCubit.doIntent(Register());
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