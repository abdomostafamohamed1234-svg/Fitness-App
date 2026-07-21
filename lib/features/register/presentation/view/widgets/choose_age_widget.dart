// import 'package:flowery/core/theme/app_colors.dart';
// import 'package:flowery/core/widgets/glass_container.dart';
// import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
// import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
// import 'package:flutter/material.dart';
// import 'package:numberpicker/numberpicker.dart';

// // ignore: must_be_immutable
// class ChooseAgeWidget extends StatefulWidget {
//   ChooseAgeWidget({super.key, required this.registerCubit});
//   RegisterCubit registerCubit;

//   @override
//   State<ChooseAgeWidget> createState() => _ChooseAgeWidgetState();
// }

// class _ChooseAgeWidgetState extends State<ChooseAgeWidget> {
//   int _currentAge = 20;

//   @override
//   void initState() {
//     super.initState();
//     _currentAge = int.tryParse(widget.registerCubit.age ?? '20') ?? 20;
//     widget.registerCubit.age = _currentAge.toString();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'How Old Are You?',
//           style: Theme.of(context).textTheme.headlineLarge,
//         ),
//         Text(
//           'This helps us create your personalized plan',
//           style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
//         ),
//         SizedBox(height: height * 0.04),
//         GlassContainer(
//           children: [
//             Text(
//               'Year',
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
//             ),
//             SizedBox(height: height * 0.02),

//             Center(
//               child: NumberPicker(
//                 value: int.parse(widget.registerCubit.age ?? "20"),
//                 minValue: 10,
//                 maxValue: 60,
//                 selectedTextStyle: Theme.of(context).textTheme.headlineLarge!
//                     .copyWith(color: AppColors.primaryColor),
//                 textStyle: Theme.of(context).textTheme.titleLarge,
//                 itemHeight: height * 0.1,
//                 step: 1,
//                 axis: Axis.horizontal,
//                 onChanged: (value) => setState(() {
//                   widget.registerCubit.age = value.toString();
//                 }),
//               ),
//             ),
//             const Icon(
//               Icons.arrow_drop_up_sharp,
//               color: AppColors.primaryColor,
//               size: 50,
//             ),

//             SizedBox(height: height * 0.02),
//             SizedBox(
//               height: height * 0.06,
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   widget.registerCubit.doIntent(RegisterNextStep());
//                 },
//                 child: Text(
//                   'Next',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flowery/features/register/presentation/view_model/cubit/register_events.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

// ignore: must_be_immutable
class ChooseAgeWidget extends StatefulWidget {
  ChooseAgeWidget({super.key, required this.registerCubit});
  RegisterCubit registerCubit;

  @override
  State<ChooseAgeWidget> createState() => _ChooseAgeWidgetState();
}

class _ChooseAgeWidgetState extends State<ChooseAgeWidget> {
  int _currentAge = 20;

  @override
  void initState() {
    super.initState();
    _currentAge = int.tryParse(widget.registerCubit.age ?? '20') ?? 20;
    widget.registerCubit.age = _currentAge.toString();
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
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
            ),
            SizedBox(height: height * 0.02),

            Center(
              child: NumberPicker(
                value: int.parse(widget.registerCubit.age ?? "20"),
                minValue: 10,
                maxValue: 60,
                selectedTextStyle: Theme.of(context).textTheme.headlineLarge!
                    .copyWith(color: AppColors.primaryColor),
                textStyle: Theme.of(context).textTheme.titleLarge,
                itemHeight: height * 0.1,
                step: 1,
                axis: Axis.horizontal,
                onChanged: (value) => setState(() {
                  widget.registerCubit.age = value.toString();
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