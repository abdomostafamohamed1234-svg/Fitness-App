import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/featrures/food/presentation/widgets/items/nutration_item.dart';
import 'package:flutter/material.dart';

class NutrationSummaryContainer extends StatefulWidget {
  const NutrationSummaryContainer({super.key});

  @override

  State<NutrationSummaryContainer> createState() =>
      _NutrationContainerSummaryState();
}

class _NutrationContainerSummaryState extends State<NutrationSummaryContainer> {
  late AppLocalizations localizations;
  final String totalEnergy = "100 K";
  final String totalProtein = "15 G";
  final String totalCarbs = "58 G";
  final String totalFats = "20 G";

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          NutritionItem(value: totalEnergy, title: localizations.energy),
          NutritionItem(value: totalProtein, title: localizations.protein),
          NutritionItem(value: totalCarbs, title: localizations.carbs),
          NutritionItem(value: totalFats, title: localizations.fats),
        ],
      ),
    );
  }
}
