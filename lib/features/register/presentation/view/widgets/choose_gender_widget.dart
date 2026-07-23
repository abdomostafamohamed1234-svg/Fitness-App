import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseGenderWidget extends StatefulWidget {
  const ChooseGenderWidget({super.key});

  @override
  State<ChooseGenderWidget> createState() => _ChooseGenderWidgetState();
}

class _ChooseGenderWidgetState extends State<ChooseGenderWidget> {
  bool? male = false;
  bool? feMale = false;

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    final height = MediaQuery.of(context).size.height;
    final locale = AppLocalizations.of(context)!;

    if (registerCubit.gender == 'male') {
      male = true;
      feMale = false;
    } else if (registerCubit.gender == 'female') {
      male = false;
      feMale = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.tellUsAboutYourself,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontSize: 20),
        ),
        Text(
          locale.weNeedToKnowYourGender,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
        ),
        SizedBox(height: height * 0.02),
        GlassContainer(
          children: [
            InkWell(
              onTap: () {
                feMale = false;
                male = true;
                registerCubit.gender = 'male';
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: male == true ? Theme.of(context).primaryColor : null,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.male_outlined,
                      color: Colors.white,
                      size: 60,
                    ),
                    Text(
                      locale.male,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(fontSize: 15),
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
                registerCubit.gender = 'female';
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: feMale == true ? Theme.of(context).primaryColor : null,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.female_outlined,
                      color: Colors.white,
                      size: 60,
                    ),
                    Text(
                      locale.female,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(fontSize: 15),
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
                    registerCubit.doIntent(RegisterNextStep());
                  },
                  child: Text(
                    locale.next,
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
