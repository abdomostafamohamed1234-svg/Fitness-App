import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/home/domian/entities/food_for_you_model.dart';
import 'package:flutter/material.dart';

class FoodSectionWidget extends StatelessWidget {
  final List<CategoryModel> categories;

  const FoodSectionWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Flexible(
              child: Text(
                'Recommendation For You',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'See All',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primaryColor,
                decorationThickness: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 130,
                      height: 140,
                      child: Image.network(
                        category.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          color: Colors.grey[850],
                          child: const Icon(
                            Icons.restaurant,
                            color: Colors.orange,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 140,
                      color: Colors.black.withValues(alpha: 0.35),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
