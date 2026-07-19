import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChooseGenderWidget extends StatefulWidget {
  ChooseGenderWidget({super.key, required this.registerCubit});
  RegisterCubit registerCubit;

  @override
  State<ChooseGenderWidget> createState() => _ChooseGenderWidgetState();
}

class _ChooseGenderWidgetState extends State<ChooseGenderWidget> {
  bool? male = false;
  bool? feMale = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    if (widget.registerCubit.gender == 'male') {
      male = true;
      feMale = false;
    } else if (widget.registerCubit.gender == 'female') {
      male = false;
      feMale = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tell Us About Yourself!',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 20),
        ),
        Text(
          'We need to know your gender',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
        ),
        SizedBox(height: height * 0.02),
        GlassContainer(
          children: [
            InkWell(
              onTap: () {
                feMale = false;
                male = true;
                widget.registerCubit.gender = 'male';
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  color: male == true ? AppColors.primaryColor : null,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.male_outlined, color: Colors.white, size: 60),
                    Text(
                      'Male',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            InkWell(
              onTap: () {
                feMale = true;
                male = false;
                widget.registerCubit.gender = 'female';
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  color: feMale == true ? AppColors.primaryColor : null,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.female_outlined, color: Colors.white, size: 60),
                    Text(
                      'Female',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Visibility(
              visible: male == true || feMale == true,
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