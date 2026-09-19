import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutItem extends StatelessWidget {
  final String name;
  final String? image;

  const WorkoutItem({
    super.key,
    required this.name,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: NetworkImage(
            image ?? "https://via.placeholder.com/150",
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            // ignore: deprecated_member_use
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(16.w),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
