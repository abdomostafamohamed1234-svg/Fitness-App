import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

class ChooseAgeWidget extends StatefulWidget {
  const ChooseAgeWidget({super.key});

  @override
  State<ChooseAgeWidget> createState() => _ChooseAgeWidgetState();
}

class _ChooseAgeWidgetState extends State<ChooseAgeWidget> {
  late final RegisterCubit registerCubit;
  int _currentAge = 20;

  @override
  void initState() {
    super.initState();
    registerCubit = context.read<RegisterCubit>();
    _currentAge = registerCubit.surveyData.age ?? 20;
    registerCubit.surveyData.age = _currentAge;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final locale = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.howOldAreYou,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          locale.personalizedPlanHint,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
        ),
        SizedBox(height: height * 0.04),
        GlassContainer(
          children: [
            Text(
              locale.year,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: height * 0.02),

            Center(
              child: NumberPicker(
                value: registerCubit.surveyData.age ?? 20,
                minValue: 10,
                maxValue: 60,
                selectedTextStyle: Theme.of(context).textTheme.headlineLarge!
                    .copyWith(color: Theme.of(context).primaryColor),
                textStyle: Theme.of(context).textTheme.titleLarge,
                itemHeight: height * 0.1,
                step: 1,
                axis: Axis.horizontal,
                onChanged: (value) => setState(() {
                  registerCubit.surveyData.age = value;
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
                  locale.next,
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