import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/helpers/bloc/bloc_observer.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_generator.dart';
import 'package:flowery/core/cubits/locale/locale_cubit.dart';
import 'package:flowery/core/cubits/locale/locale_state.dart';
import 'package:flowery/core/theme/app_theme.dart';
import 'package:flowery/core/widgets/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<LocaleCubit>())],
      child: const DriverApp(),
    ),
  );
}

class DriverApp extends StatelessWidget {
  const DriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Fitness-Ap',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: state.locale,
              onGenerateRoute: RouteGenerator.getRoute,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.darkTheme,
              // initialRoute: AppRoutes.,
              home: const TestScreen(),
            );
          },
        );
      },
    );
  }
}