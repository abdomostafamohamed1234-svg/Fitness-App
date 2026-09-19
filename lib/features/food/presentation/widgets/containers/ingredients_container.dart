import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/core/widgets/glass_container.dart';
import 'package:flutter/material.dart';

class IngredientsContainer extends StatelessWidget {
  final TextTheme style;
  final Map<String, String> ingredients;
  const IngredientsContainer({
    super.key,
    required this.style,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassContainer(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final i = index + 1;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          ingredients["strIngredient$i"] ?? "",
                          style: style.bodyLarge,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ingredients["strMeasure$i"] ?? "",
                          textAlign: TextAlign.end,
                          style: style.bodyMedium?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  i != ((ingredients.length) / 2).toInt()
                      ? const Divider(
                          thickness: 1.0,
                          color: AppColors.borderColor,
                        )
                      : const SizedBox.shrink(),
                ],
              );
            },
            itemCount: ((ingredients.length) / 2).toInt(),
          ),
        ],
      ),
    );
  }
}
