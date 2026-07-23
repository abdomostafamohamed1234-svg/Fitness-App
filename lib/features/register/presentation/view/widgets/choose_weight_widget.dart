import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

class ChooseWeightWidget extends StatefulWidget {
  const ChooseWeightWidget({super.key});

  @override
  State<ChooseWeightWidget> createState() => _ChooseWeightWidgetState();
}

class _ChooseWeightWidgetState extends State<ChooseWeightWidget> {
  late final RegisterCubit registerCubit;
  int _currentWeight = 70;

  @override
  void initState() {
    super.initState();
    registerCubit = context.read<RegisterCubit>();
    _currentWeight = registerCubit.weight ?? 70 ;
    registerCubit.weight = _currentWeight;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.whatIsYourWeight,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
         AppLocalizations.of(context)!.personalizedPlanHint,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
        ),
        SizedBox(height: height * 0.04),
        GlassContainer(
          children: [
            Text(
              AppLocalizations.of(context)!.kg,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: height * 0.02),

            Center(
              child: NumberPicker(
                value: registerCubit.weight ?? 70,
                minValue: 50,
                maxValue: 140,
                selectedTextStyle: Theme.of(context).textTheme.headlineLarge!
                    .copyWith(color: Theme.of(context).primaryColor),
                textStyle: Theme.of(context).textTheme.titleLarge,
                itemHeight: height * 0.1,
                step: 1,
                axis: Axis.horizontal,
                onChanged: (value) => setState(() {
                  registerCubit.weight = value;
                }),
              ),
            ),
            Icon(
              Icons.arrow_drop_up_sharp,
              color: Theme.of(context).primaryColor,
              size: 50,
            ),

            SizedBox(height: height * 0.02),
            SizedBox(
              height: height * 0.06,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  registerCubit.doIntent(RegisterNextStep());
                },
                child: Text(
                  AppLocalizations.of(context)!.next,
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