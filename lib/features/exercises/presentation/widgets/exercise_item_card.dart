import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/exercises/domain/entities/exercises_entity.dart';
import 'package:flowery/features/exercises/presentation/view_model/base_state/exercise_state.dart';
import 'package:flowery/features/exercises/presentation/view_model/cubit/exercise_cubit.dart';
import 'package:flowery/features/exercises/presentation/view_model/events/exercise_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseItemCard extends StatefulWidget {
  final ExerciseEntity exercise;

  const ExerciseItemCard({super.key, required this.exercise});

  @override
  State<ExerciseItemCard> createState() => _ExerciseItemCardState();
}

class _ExerciseItemCardState extends State<ExerciseItemCard> {
  YoutubePlayerController? _controller;

  String? get _videoId => YoutubePlayer.convertUrlToId(
        widget.exercise.shortYoutubeDemonstrationLink ?? "",
      );

  void _startVideo() {
    final videoId = _videoId;
    if (videoId == null) return;
    setState(() {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          disableDragSeek: false,
        ),
      );
    });
  }

  void _stopVideo() {
    _controller?.dispose();
    setState(() => _controller = null);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = _controller != null;

    return BlocListener<ExerciseCubit, ExerciseState>(
      listenWhen: (previous, current) =>
          previous.playingExerciseId != current.playingExerciseId,
      listener: (context, state) {
        final isPlayingNow = state.playingExerciseId == widget.exercise.id;
        if (isPlayingNow && _controller == null) {
          _startVideo();
        } else if (!isPlayingNow && _controller != null) {
          _stopVideo();
        }
      },
      
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 14),
            decoration: const BoxDecoration(color: AppColors.darkGreyColor),
            padding: isPlaying ? EdgeInsets.zero : const EdgeInsets.all(12),
            child: isPlaying
                ? _buildExpandedPlayingLayout()
                : _buildCollapsedLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsedLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildThumbnail(),
        const SizedBox(width: 14),
        Expanded(child: _buildTexts()),
      ],
    );
  }


  Widget _buildExpandedPlayingLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: YoutubePlayer(
            controller: _controller!,
            showVideoProgressIndicator: true,
            progressColors: const ProgressBarColors(
              playedColor: AppColors.primaryColor,
              handleColor: AppColors.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTexts()),
              IconButton(
                onPressed: () {
                  context.read<ExerciseCubit>().doEvent(
                        ToggleExerciseVideoEvent(
                          exerciseId: widget.exercise.id ?? "",
                        ),
                      );
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.exercise.exercise ?? "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 6),
        Text(
          [
            widget.exercise.primaryEquipment,
            widget.exercise.mechanics,
          ].where((e) => e != null && e.isNotEmpty).join(" • "),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          widget.exercise.targetMuscleGroup ?? "",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildThumbnail() {
    final videoId = _videoId;

    return GestureDetector(
      onTap: () {
        context.read<ExerciseCubit>().doEvent(
              ToggleExerciseVideoEvent(exerciseId: widget.exercise.id ?? ""),
            );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 90,
          height: 90,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (videoId != null)
                _YoutubeThumbnail(videoId: videoId)
              else
                Container(color: AppColors.borderColor),
              Container(color: Colors.black.withValues(alpha: .25)),
              const Center(
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.whiteColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _YoutubeThumbnail extends StatefulWidget {
  final String videoId;
  const _YoutubeThumbnail({required this.videoId});

  @override
  State<_YoutubeThumbnail> createState() => _YoutubeThumbnailState();
}

class _YoutubeThumbnailState extends State<_YoutubeThumbnail> {
  static const List<String> _qualities = [
    "hqdefault", 
    "mqdefault",
    "default",
  ];

  int _qualityIndex = 0;

  String get _currentUrl =>
      "https://img.youtube.com/vi/${widget.videoId}/${_qualities[_qualityIndex]}.jpg";

  @override
  Widget build(BuildContext context) {
    return Image.network(
      _currentUrl,
      key: ValueKey(_qualityIndex),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        if (_qualityIndex < _qualities.length - 1) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _qualityIndex++);
          });
        }
        return Container(color: AppColors.borderColor);
      },
    );
  }
}