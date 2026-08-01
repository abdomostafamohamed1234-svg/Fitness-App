import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/edit_profile/presentation/view/widgets/edit_picker_scaffold.dart';
import 'package:flowery/features/edit_profile/presentation/view/widgets/option_labels.dart';
import 'package:flowery/features/edit_profile/presentation/view/widgets/selectable_option_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditActivityLevelPage extends StatefulWidget {
  const EditActivityLevelPage({super.key, this.initialLevel});

  final String? initialLevel;

  /// Stable codes sent to / returned by the API — never localized.
  static const levelValues = ['level1', 'level2', 'level3', 'level4', 'level5'];

  @override
  State<EditActivityLevelPage> createState() => _EditActivityLevelPageState();
}

class _EditActivityLevelPageState extends State<EditActivityLevelPage> {
  late String? _selectedLevel = widget.initialLevel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return EditPickerScaffold(
      title: l10n.activity_level_question,
      child: GlassContainer(
        children: [
          SelectableOptionList(
            options: {
              for (final value in EditActivityLevelPage.levelValues)
                value: activityLevelLabel(l10n, value),
            },
            selected: _selectedLevel,
            onChanged: (value) => setState(() => _selectedLevel = value),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 48.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedLevel == null
                  ? null
                  : () => Navigator.pop(context, _selectedLevel),
              child: Text(l10n.done, style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
        ],
      ),
    );
  }
}
