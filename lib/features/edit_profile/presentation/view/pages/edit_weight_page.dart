import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/edit_profile/presentation/view/widgets/edit_picker_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numberpicker/numberpicker.dart';

class EditWeightPage extends StatefulWidget {
  const EditWeightPage({super.key, this.initialWeight = 70});

  final int initialWeight;

  @override
  State<EditWeightPage> createState() => _EditWeightPageState();
}

class _EditWeightPageState extends State<EditWeightPage> {
  late int _weight = widget.initialWeight;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return EditPickerScaffold(
      title: l10n.what_is_your_weight,
      subtitle: l10n.personalized_plan_subtitle,
      child: GlassContainer(
        children: [
          Text(
            l10n.kg,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
          ),
          SizedBox(height: 16.h),
          Center(
            child: NumberPicker(
              value: _weight,
              minValue: 30,
              maxValue: 200,
              selectedTextStyle: Theme.of(context).textTheme.headlineLarge
                  ?.copyWith(color: AppColors.primaryColor),
              textStyle: Theme.of(context).textTheme.titleLarge,
              itemHeight: 80.h,
              axis: Axis.horizontal,
              onChanged: (value) => setState(() => _weight = value),
            ),
          ),
          Icon(
            Icons.arrow_drop_up_sharp,
            color: AppColors.primaryColor,
            size: 50.sp,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 48.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, _weight),
              child: Text(l10n.done, style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
        ],
      ),
    );
  }
}
