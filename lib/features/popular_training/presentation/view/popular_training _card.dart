import 'package:flutter/material.dart';

import '../../domain/entities/exercise_entity.dart';

class PopularTrainingCard extends StatelessWidget {
  final ExerciseEntity exercise;
  final VoidCallback? onTap;

  const PopularTrainingCard({super.key, required this.exercise, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        height: 210,
        margin: const EdgeInsets.only(right: 12),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background: the muscle image fetched together with this batch
            if (exercise.muscleImage != null)
              Image.network(
                exercise.muscleImage!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: Colors.grey.shade800),
              )
            else
              Container(color: Colors.grey.shade800),

            // Dark gradient so the text stays readable
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),

            // Name + level
            Positioned(
              left: 12,
              right: 12,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      exercise.difficultyLevel,
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
