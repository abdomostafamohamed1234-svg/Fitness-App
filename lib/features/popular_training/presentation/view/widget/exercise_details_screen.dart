import 'package:flowery/features/popular_training/domain/entities/exercise_entity.dart';
import 'package:flowery/features/popular_training/presentation/view/widget/exercise_detail_row.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class ExerciseDetailsScreen extends StatefulWidget {
  final ExerciseEntity exercise;

  const ExerciseDetailsScreen({super.key, required this.exercise});

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    // Prefer the short demonstration video as the main embedded player;
    // fall back to the in-depth one if the short link isn't available.
    final videoUrl =
        widget.exercise.shortYoutubeDemonstrationLink ??
        widget.exercise.inDepthYoutubeExplanationLink;

    final videoId = videoUrl != null
        ? YoutubePlayer.convertUrlToId(videoUrl)
        : null;

    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // Only show a separate "in-depth explanation" button when it's a
  // different video than the one already embedded above.
  bool get _hasSeparateInDepthLink {
    final inDepth = widget.exercise.inDepthYoutubeExplanationLink;
    final short = widget.exercise.shortYoutubeDemonstrationLink;
    return inDepth != null && inDepth != short;
  }

  Future<void> _openInDepthVideo() async {
    final url = widget.exercise.inDepthYoutubeExplanationLink;
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;

    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFF0E0E0E),
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              exercise.name,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVideoOrFallbackImage(exercise),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.deepOrange),
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
                      const SizedBox(height: 24),

                      const Text(
                        'Exercise Info',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(color: Colors.white24, height: 24),

                      ExerciseDetailRow(
                        icon: Icons.track_changes,
                        label: 'Target Muscle Group',
                        value: exercise.targetMuscleGroup,
                      ),
                      ExerciseDetailRow(
                        icon: Icons.fitness_center,
                        label: 'Prime Mover Muscle',
                        value: exercise.primeMoverMuscle,
                      ),
                      if (exercise.secondaryMuscle != null)
                        ExerciseDetailRow(
                          icon: Icons.accessibility_new,
                          label: 'Secondary Muscle',
                          value: exercise.secondaryMuscle!,
                        ),
                      if (exercise.tertiaryMuscle != null)
                        ExerciseDetailRow(
                          icon: Icons.accessibility,
                          label: 'Tertiary Muscle',
                          value: exercise.tertiaryMuscle!,
                        ),
                      if (exercise.primaryEquipment != null)
                        ExerciseDetailRow(
                          icon: Icons.sports_gymnastics,
                          label: 'Primary Equipment',
                          value: exercise.primaryEquipment!,
                        ),
                      if (exercise.secondaryEquipment != null)
                        ExerciseDetailRow(
                          icon: Icons.sports_martial_arts,
                          label: 'Secondary Equipment',
                          value: exercise.secondaryEquipment!,
                        ),
                      if (exercise.posture != null)
                        ExerciseDetailRow(
                          icon: Icons.self_improvement,
                          label: 'Posture',
                          value: exercise.posture!,
                        ),

                      if (_hasSeparateInDepthLink) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: _openInDepthVideo,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white24),
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                            ),
                            icon: const Icon(Icons.play_circle_outline),
                            label: const Text('Watch In-Depth Explanation'),
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoOrFallbackImage(ExerciseEntity exercise) {
    if (_controller != null) {
      return YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.deepOrange,
      );
    }

    // No usable video link -> fall back to the muscle image so the
    // screen never shows an empty header.
    if (exercise.muscleImage != null) {
      return Image.network(
        exercise.muscleImage!,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholderHeader(),
      );
    }

    return _placeholderHeader();
  }

  Widget _placeholderHeader() {
    return Container(
      height: 220,
      width: double.infinity,
      color: Colors.grey.shade900,
      child: const Center(
        child: Icon(
          Icons.video_library_outlined,
          color: Colors.white38,
          size: 48,
        ),
      ),
    );
  }
}