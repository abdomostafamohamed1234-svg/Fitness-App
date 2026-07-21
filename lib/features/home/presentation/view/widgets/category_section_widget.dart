import 'package:flowery/features/home/domian/entities/work_out_model.dart';
import 'package:flutter/material.dart';

class CategorySectionWidget extends StatelessWidget {
  final List<MuscleGroupModel> musclesGroup;

  const CategorySectionWidget({super.key, required this.musclesGroup});

  // Static icon mapping per category name
  static IconData iconFor(String name) {
    final n = name.toLowerCase();
    if (n.contains('gym')) return Icons.fitness_center;
    if (n.contains('yoga')) return Icons.self_improvement;
    if (n.contains('run') || n.contains('cardio')) return Icons.directions_run;
    if (n.contains('swim')) return Icons.pool;
    if (n.contains('bike') || n.contains('cycling')) {
      return Icons.directions_bike;
    }
    return Icons.sports_gymnastics;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/GymCategory.png"),
                    const Text("Gym"),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 1,
                child: Container(color: Colors.blueGrey),
              ),
              Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/fitnessCategory.png"),
                    const Text("Fitness"),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 1,
                child: Container(color: Colors.blueGrey),
              ),
              Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/YogaCategory.png"),
                    const Text("Yoga"),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 1,
                child: Container(color: Colors.blueGrey),
              ),
              Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/AerobicsCategory.png"),
                    const Text("Airobics"),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 1,
                child: Container(color: Colors.blueGrey),
              ),
              Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/TrainerCategory.png"),
                    const Text("Trainner"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
