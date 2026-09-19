import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PopularTrainingSectionWidget extends StatelessWidget {
  const PopularTrainingSectionWidget({super.key});

  static const List<_TrainingItem> _items = [
    _TrainingItem(
      title: 'Exercises That\nStrengthen Your Chest',
      tasks: 24,
      level: 'Beginner',
      levelColor: Color(0xFFFF8C00),
      imageUrl:
          'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
    ),
    _TrainingItem(
      title: 'Exercises That\nStrengthen Your Back',
      tasks: 36,
      level: 'Interm.',
      levelColor: Color(0xFF4CAF50),
      imageUrl:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
    ),
    _TrainingItem(
      title: 'Full Body\nIntense Workout',
      tasks: 18,
      level: 'Advanced',
      levelColor: Color(0xFFF44336),
      imageUrl:
          'https://images.unsplash.com/photo-1549060279-7e168fcee0c2?w=400',
    ),
    _TrainingItem(
      title: 'Core & Abs\nDaily Routine',
      tasks: 20,
      level: 'Beginner',
      levelColor: Color(0xFFFF8C00),
      imageUrl:
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Training',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigator.pushNamed(context, Routes.workouts);
              },
              child: const Text(
                'See All',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryColor,
                  decorationThickness: 2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, index) => _TrainingCard(item: _items[index]),
          ),
        ),
      ],
    );
  }
}

class _TrainingCard extends StatelessWidget {
  final _TrainingItem item;

  const _TrainingCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          // Background image
          SizedBox(
            width: 170,
            height: 190,
            child: Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: const Color(0xFF1E1E1E),
                child: const Icon(
                  Icons.fitness_center,
                  color: Colors.orange,
                  size: 40,
                ),
              ),
            ),
          ),
          // Dark gradient overlay
          Container(
            width: 170,
            height: 190,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.75),
                ],
              ),
            ),
          ),
          // Content
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${item.tasks} Tasks',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: item.levelColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: item.levelColor.withValues(alpha: 0.6),
                          width: 0.8,
                        ),
                      ),
                      child: Text(
                        item.level,
                        style: TextStyle(
                          color: item.levelColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrainingItem {
  final String title;
  final int tasks;
  final String level;
  final Color levelColor;
  final String imageUrl;

  const _TrainingItem({
    required this.title,
    required this.tasks,
    required this.level,
    required this.levelColor,
    required this.imageUrl,
  });
}
