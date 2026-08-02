import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/base/base_state.dart';
import 'package:flowery/core/theme/app_assets.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/features/edit_profile/presentation/view/pages/edit_activity_level_page.dart';
import 'package:flowery/features/edit_profile/presentation/view/pages/edit_goal_page.dart';
import 'package:flowery/features/edit_profile/presentation/view/pages/edit_weight_page.dart';
import 'package:flowery/features/edit_profile/presentation/view/widgets/editable_info_tile.dart';
import 'package:flowery/features/edit_profile/presentation/view/widgets/option_labels.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/cubit.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/event.dart';
import 'package:flowery/features/edit_profile/presentation/view_model/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileCubit>(
      create: (_) => getIt<EditProfileCubit>()..doEvent(GetProfileEvent()),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  late final EditProfileCubit _cubit;

  bool _initializedFromProfile = false;
  int? _weight;
  String? _goal;
  String? _activityLevel;
  File? _pickedPhoto;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = context.read<EditProfileCubit>();
  }

  void _syncFromProfile(EditProfileStates state) {
    if (_initializedFromProfile) return;
    final user = state.profileState.data?.user;
    if (user == null) return;
    _initializedFromProfile = true;
    _weight = user.weight;
    _goal = user.goal;
    _activityLevel = user.activityLevel;
  }

  Future<void> _pickPhoto() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    final path = result?.files.single.path;
    if (path == null || !mounted) return;
    final file = File(path);
    setState(() => _pickedPhoto = file);
    _cubit.doEvent(UploadPhotoEvent(file));
  }

  Future<void> _editWeight() async {
    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(builder: (_) => EditWeightPage(initialWeight: _weight ?? 70)),
    );
    if (result == null) return;
    setState(() => _weight = result);
  }

  Future<void> _editGoal() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => EditGoalPage(initialGoal: _goal)),
    );
    if (result == null) return;
    setState(() => _goal = result);
  }

  Future<void> _editActivityLevel() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => EditActivityLevelPage(initialLevel: _activityLevel),
      ),
    );
    if (result == null) return;
    setState(() => _activityLevel = result);
  }

  void _submitUpdate() {
    _cubit.doEvent(
      EditProfileEvent(
        firstName: _cubit.firstNameController.text,
        lastName: _cubit.lastNameController.text,
        email: _cubit.emailController.text,
        weight: _weight,
        goal: _goal,
        activityLevel: _activityLevel,
      ),
    );
  }

  InputDecoration _fieldDecoration({required String hint, required IconData icon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12.sp),
      prefixIcon: Icon(icon, color: Colors.white, size: 18.sp),
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: const BorderSide(color: Colors.white, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.r),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<EditProfileCubit, EditProfileStates>(
      listenWhen: (previous, current) =>
          previous.editProfileState != current.editProfileState ||
          previous.uploadPhotoState != current.uploadPhotoState,
      listener: (context, state) {
        state.editProfileState.when(
          initial: () {},
          loading: () {},
          success: (_) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.profile_updated))),
          error: (exception) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(exception.toString()))),
        );
        state.uploadPhotoState.when(
          initial: () {},
          loading: () {},
          success: (_) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.photo_updated))),
          error: (exception) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(exception.toString()))),
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                AppAssets.registerBackGround,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              BlocBuilder<EditProfileCubit, EditProfileStates>(
                buildWhen: (previous, current) =>
                    previous.profileState != current.profileState,
                builder: (context, state) {
                  _syncFromProfile(state);

                  return state.profileState.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: AppColors.primaryColor),
                    ),
                    error: (exception) => Center(
                      child: Text(
                        exception.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    success: (profile) {
                      final user = profile.user;
                      if (user == null) {
                        return Center(
                          child: Text(
                            l10n.no_profile_data,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.maybePop(context),
                                    child: Container(
                                      width: 36.w,
                                      height: 36.w,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.chevron_left,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      l10n.edit_profile_title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 36.w),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              GestureDetector(
                                onTap: _pickPhoto,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    CircleAvatar(
                                      radius: 50.r,
                                      backgroundColor: AppColors.greyColor,
                                      backgroundImage: _pickedPhoto != null
                                          ? FileImage(_pickedPhoto!)
                                          : (user.photo.isEmpty
                                                ? null
                                                : CachedNetworkImageProvider(user.photo)
                                                      as ImageProvider),
                                      child: _pickedPhoto == null && user.photo.isEmpty
                                          ? Icon(
                                              Icons.person,
                                              size: 60.sp,
                                              color: Colors.white70,
                                            )
                                          : null,
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 28.w,
                                        height: 28.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.blackColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 14.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                '${_cubit.firstNameController.text} '
                                '${_cubit.lastNameController.text}',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: 24.h),
                              TextFormField(
                                controller: _cubit.firstNameController,
                                style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                cursorColor: Colors.white,
                                decoration: _fieldDecoration(
                                  hint: l10n.first_name,
                                  icon: Icons.person_outline,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              TextFormField(
                                controller: _cubit.lastNameController,
                                style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                cursorColor: Colors.white,
                                decoration: _fieldDecoration(
                                  hint: l10n.last_name,
                                  icon: Icons.person_outline,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              TextFormField(
                                controller: _cubit.emailController,
                                style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                cursorColor: Colors.white,
                                decoration: _fieldDecoration(
                                  hint: l10n.email,
                                  icon: Icons.email_outlined,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              EditableInfoTile(
                                label: l10n.your_weight,
                                value: '${_weight ?? user.weight} ${l10n.kg}',
                                onTap: _editWeight,
                              ),
                              SizedBox(height: 16.h),
                              EditableInfoTile(
                                label: l10n.your_goal,
                                value: goalLabel(l10n, _goal ?? user.goal),
                                onTap: _editGoal,
                              ),
                              SizedBox(height: 16.h),
                              EditableInfoTile(
                                label: l10n.your_activity_level,
                                value: activityLevelLabel(
                                  l10n,
                                  _activityLevel ?? user.activityLevel,
                                ),
                                onTap: _editActivityLevel,
                              ),
                              SizedBox(height: 28.h),
                              _UpdateButton(onPressed: _submitUpdate),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpdateButton extends StatelessWidget {
  const _UpdateButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<EditProfileCubit, EditProfileStates>(
      buildWhen: (previous, current) =>
          previous.editProfileState != current.editProfileState,
      builder: (context, state) {
        final isLoading = state.editProfileState.state == StateType.loading;

        return SizedBox(
          height: 48.h,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            child: isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : Text(l10n.update, style: Theme.of(context).textTheme.titleLarge),
          ),
        );
      },
    );
  }
}
