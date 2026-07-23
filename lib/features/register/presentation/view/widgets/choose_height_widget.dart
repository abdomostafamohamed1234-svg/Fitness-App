import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

class ChooseHeightWidget extends StatefulWidget {
  const ChooseHeightWidget({super.key});

  @override
  State<ChooseHeightWidget> createState() => _ChooseHeightWidgetState();
}

class _ChooseHeightWidgetState extends State<ChooseHeightWidget> {
  late final RegisterCubit registerCubit;
  int _currentHeight = 170;

  @override
  void initState() {
    super.initState();
    registerCubit = context.read<RegisterCubit>();
    _currentHeight = registerCubit.height ?? 170 ;
    registerCubit.height = _currentHeight;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
        final locale = AppLocalizations.of(context)!;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.whatIsYourHeight,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          locale.personalizedPlanHint,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
        ),
        SizedBox(height: height * 0.04),
        GlassContainer(
          children: [
            Text(locale.cm, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).primaryColor )),
            SizedBox(height: height * 0.02),

            Center(
              child: NumberPicker(
                value: registerCubit.height ?? 170,
                minValue: 140,
                maxValue: 250,
                selectedTextStyle: Theme.of(context).textTheme.headlineLarge!
                    .copyWith(color: Theme.of(context).primaryColor),
                textStyle: Theme.of(context).textTheme.titleLarge,
                itemHeight: height * 0.1,
                step: 1,
                axis: Axis.horizontal,
                onChanged: (value) => setState(() {
                  registerCubit.height = value;
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