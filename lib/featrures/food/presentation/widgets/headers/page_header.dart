import 'package:flowery/config/routing/routing_extensions.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final TextStyle? style;
  const PageHeader({super.key, required this.style, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            onTap: () => context.pop(),
            customBorder: const CircleBorder(),
            child: const Center(child: Icon(Icons.first_page, size: 18)),
          ),
        ),
        SizedBox(width: 20.w),
        Text(title, style: style),
      ],
    );
  }
}
