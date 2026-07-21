import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flowery/featrures/food/domain/entities/meal_details_entity.dart';
import 'package:flowery/featrures/food/presentation/assets/food_assets_navigation.dart';
import 'package:flowery/featrures/food/presentation/view_model/cubit/food_cubit.dart';
import 'package:flowery/featrures/food/presentation/view_model/state/food_state.dart';
import 'package:flowery/featrures/food/presentation/widgets/containers/section_container.dart';
import 'package:flowery/featrures/food/presentation/widgets/containers/ingredients_container.dart';
import 'package:flowery/featrures/food/presentation/widgets/headers/page_header.dart';
import 'package:flowery/featrures/food/presentation/widgets/containers/nutration_summary_container.dart';
import 'package:flowery/featrures/food/presentation/widgets/Images/blurred_background_image.dart';
import 'package:flowery/featrures/food/presentation/widgets/Images/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  late TextTheme textTheme;
  late AppLocalizations localizations;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context)!;
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit, FoodState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              // Background Image
              const BlurredBackgroundImage(
                image: FoodAssetsNavigation.background,
                blurStrength: 3,
              ),
              state.detailsState.when(
                initial: () {
                  return SafeArea(
                    child: Center(
                      child: SizedBox(
                        height: 50.h,
                        width: 50.w,
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
                loading: () {
                  return SafeArea(
                    child: Center(
                      child: SizedBox(
                        height: 50.h,
                        width: 50.w,
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
                error: (Exception exception) {
                  return SafeArea(
                    child: Center(child: Text(exception.toString())),
                  );
                },
                success: (MealDetailsEntity data) {
                  // Main Body
                  return Column(
                    children: [
                      // Cover Image + Title + Nutration Summary
                      ClipRRect(
                        borderRadius: const BorderRadiusGeometry.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Cover Image
                            SizedBox(
                              height: 320.h,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(20),
                                child: CustomCachedNetworkImage(
                                  imageUrl: data.img,
                                ),
                              ),
                            ),
                            // Filter Layer
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.0, 0.5, 0.6, 0.7, 1.0],
                                      colors: [
                                        Colors.transparent,
                                        AppColors.cardColor.withValues(
                                          alpha: 0.7,
                                        ),
                                        AppColors.cardColor.withValues(
                                          alpha: 0.8,
                                        ),
                                        AppColors.cardColor.withValues(
                                          alpha: 0.9,
                                        ),
                                        AppColors.cardColor,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Title & Nutration Summary
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    data.title,
                                    style: textTheme.headlineSmall,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const NutrationSummaryContainer(),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Instructions + Ingredients
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // Instructions
                              SectionContainer(
                                title: localizations.instructions,
                                style: textTheme.headlineLarge,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data.instructions,
                                    style: textTheme.titleMedium,
                                  ),
                                ),
                              ),

                              // Ingredients
                              SectionContainer(
                                title: localizations.ingredients,
                                style: textTheme.headlineLarge,
                                child: IngredientsContainer(
                                  ingredients: data.ingredients,
                                  style: textTheme,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              // Screen Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 62.h),
                child: PageHeader(style: textTheme.headlineLarge, title: ""),
              ),
            ],
          ),
        );
      },
    );
  }
}
