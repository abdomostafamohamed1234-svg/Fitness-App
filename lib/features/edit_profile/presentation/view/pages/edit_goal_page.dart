import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/edit_profile/presentation/view/widgets/edit_picker_scaffold.dart';
import 'package:flowery/features/edit_profile/presentation/view/widgets/option_labels.dart';
import 'package:flowery/features/edit_profile/presentation/view/widgets/selectable_option_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditGoalPage extends StatefulWidget {
  const EditGoalPage({super.key, this.initialGoal});

  final String? initialGoal;

  /// Stable values sent to the API — never localized.
  static const goalValues = [
    'Gain Weight',
    'Lose Weight',
    'Get Fitter',
    'Gain More Flexible',
    'Learn The Basic',
  ];

  @override
  State<EditGoalPage> createState() => _EditGoalPageState();
}

class _EditGoalPageState extends State<EditGoalPage> {
  late String? _selectedGoal = widget.initialGoal;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return EditPickerScaffold(
      title: l10n.what_is_your_goal,
      subtitle: l10n.personalized_plan_subtitle,
      child: GlassContainer(
        children: [
          SelectableOptionList(
            options: {
              for (final value in EditGoalPage.goalValues) value: goalLabel(l10n, value),
            },
            selected: _selectedGoal,
            onChanged: (value) => setState(() => _selectedGoal = value),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 48.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedGoal == null
                  ? null
                  : () => Navigator.pop(context, _selectedGoal),
              child: Text(l10n.done, style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
        ],
      ),
    );
  }
}
