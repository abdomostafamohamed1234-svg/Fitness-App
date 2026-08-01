import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectableOptionList extends StatelessWidget {
  const SelectableOptionList({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  /// Maps the stable value sent to the API to its localized display label.
  final Map<String, String> options;
  final String? selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.entries.map((entry) {
        final value = entry.key;
        final label = entry.value;
        final isSelected = value == selected;
        return GestureDetector(
          onTap: () => onChanged(value),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 6.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              color: isSelected
                  ? AppColors.primaryColor.withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.05),
              border: Border.all(
                color: isSelected ? AppColors.primaryColor : Colors.white.withValues(alpha: 0.15),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 13.sp),
                ),
                const Spacer(),
                Container(
                  width: 22.w,
                  height: 22.w,
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
      }).toList(),
    );
  }
}
