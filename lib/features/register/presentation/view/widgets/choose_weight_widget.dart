import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

// ignore: must_be_immutable
class ChooseWeightWidget extends StatefulWidget {
  ChooseWeightWidget({super.key, required this.registerCubit});
  RegisterCubit registerCubit;

  @override
  State<ChooseWeightWidget> createState() => _ChooseWeightWidgetState();
}

class _ChooseWeightWidgetState extends State<ChooseWeightWidget> {
  int _currentWeight = 70;

  @override
  void initState() {
    super.initState();
    _currentWeight = int.tryParse(widget.registerCubit.weight ?? '70') ?? 70;
    widget.registerCubit.weight = _currentWeight.toString();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What is Your Weight?',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          'This helps us create your personalized plan',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
        ),
        SizedBox(height: height * 0.04),
        GlassContainer(
          children: [
            Text(
              'Kg',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
            ),
            SizedBox(height: height * 0.02),

            Center(
              child: NumberPicker(
                value: int.parse(widget.registerCubit.weight ?? "70"),
                minValue: 50,
                maxValue: 140,
                selectedTextStyle: Theme.of(context).textTheme.headlineLarge!
                    .copyWith(color: AppColors.primaryColor),
                textStyle: Theme.of(context).textTheme.titleLarge,
                itemHeight: height * 0.1,
                step: 1,
                axis: Axis.horizontal,
                onChanged: (value) => setState(() {
                  widget.registerCubit.weight = value.toString();
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
