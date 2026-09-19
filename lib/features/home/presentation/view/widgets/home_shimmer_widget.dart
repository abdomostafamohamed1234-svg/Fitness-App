import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ─── shared helper ───────────────────────────────────────────────────────────
class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const _ShimmerBox({
    required this.width,
    required this.height,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

// ─── base shimmer wrapper ─────────────────────────────────────────────────────
class _Shimmer extends StatelessWidget {
  final Widget child;
  const _Shimmer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[850]!,
      highlightColor: Colors.grey[600]!,
      child: child,
    );
  }
}

// ─── Category shimmer ─────────────────────────────────────────────────────────
class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _Shimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title bar
          const _ShimmerBox(width: 90, height: 18, radius: 6),
          const SizedBox(height: 12),
          // 5 icon+label tiles in a row
          Row(
            children: List.generate(5, (i) {
              final isLast = i == 4;
              return Expanded(
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        children: [
                          _ShimmerBox(width: 48, height: 48, radius: 10),
                          SizedBox(height: 6),
                          _ShimmerBox(width: 40, height: 10, radius: 4),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.blueGrey,
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ─── Recommendation shimmer ───────────────────────────────────────────────────
class RecommendationShimmer extends StatelessWidget {
  const RecommendationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _Shimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ShimmerBox(width: 180, height: 18, radius: 6),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (_, _) =>
                  const _ShimmerBox(width: 130, height: 140, radius: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Workout shimmer ──────────────────────────────────────────────────────────
class WorkoutShimmer extends StatelessWidget {
  const WorkoutShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _Shimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title + "See All"
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ShimmerBox(width: 160, height: 18, radius: 6),
              _ShimmerBox(width: 50, height: 14, radius: 4),
            ],
          ),
          const SizedBox(height: 12),
          // filter chips
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, _) =>
                  const _ShimmerBox(width: 72, height: 36, radius: 20),
            ),
          ),
          const SizedBox(height: 14),
          // workout cards
          SizedBox(
            height: 130,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (_, _) =>
                  const _ShimmerBox(width: 120, height: 130, radius: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Food shimmer ─────────────────────────────────────────────────────────────
class FoodShimmer extends StatelessWidget {
  const FoodShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _Shimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title + "See All"
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ShimmerBox(width: 200, height: 18, radius: 6),
              _ShimmerBox(width: 50, height: 14, radius: 4),
            ],
          ),
          const SizedBox(height: 12),
          // food cards
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (_, _) =>
                  const _ShimmerBox(width: 130, height: 140, radius: 16),
            ),
          ),
        ],
      ),
    );
  }
}
