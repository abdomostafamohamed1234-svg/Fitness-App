import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

// ignore: must_be_immutable
class ChooseHeightWidget extends StatefulWidget {
  ChooseHeightWidget({super.key, required this.registerCubit});
  RegisterCubit registerCubit;

  @override
  State<ChooseHeightWidget> createState() => _ChooseHeightWidgetState();
}

class _ChooseHeightWidgetState extends State<ChooseHeightWidget> {
  int _currentHeight = 170;

  @override
  void initState() {
    super.initState();
    _currentHeight = int.tryParse(widget.registerCubit.height ?? '170') ?? 170;
    widget.registerCubit.height = _currentHeight.toString();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What is Your Height?',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          'This helps us create your personalized plan',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
        ),
        SizedBox(height: height * 0.04),
        GlassContainer(
          children: [
            Text('CM', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor )),
            SizedBox(height: height * 0.02),

            Center(
              child: NumberPicker(
                value: int.parse(widget.registerCubit.height ?? "170"),
                minValue: 140,
                maxValue: 250,
                selectedTextStyle: Theme.of(context).textTheme.headlineLarge!
                    .copyWith(color: AppColors.primaryColor),
                textStyle: Theme.of(context).textTheme.titleLarge,
                itemHeight: height * 0.1,
                step: 1,
                axis: Axis.horizontal,
                onChanged: (value) => setState(() {
                  widget.registerCubit.height = value.toString();
                }),
              ),
            ),
            const Icon(
              Icons.arrow_drop_up_sharp,
              color: AppColors.primaryColor,
              size: 50,
            ),

            SizedBox(height: height * 0.02),
            SizedBox(
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
          ],
        ),
      ],
    );
  }
}
