import 'package:flowery/config/di/di_config.dart';
import 'package:flowery/config/helpers/bloc/bloc_observer.dart';
import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/config/routing/routing_generator.dart';
import 'package:flowery/core/cubits/locale/locale_cubit.dart';
import 'package:flowery/core/cubits/locale/locale_state.dart';
import 'package:flowery/core/theme/app_theme.dart';
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
              title: 'Fitness-App',
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

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Test"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (_) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Typography
            Text(
              "Display Large",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "Headline Large",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text("Title Large", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text("Body Large", style: Theme.of(context).textTheme.bodyLarge),
            Text("Body Medium", style: Theme.of(context).textTheme.bodyMedium),

            const SizedBox(height: 30),

            /// TextFields
            const TextField(
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),

            const SizedBox(height: 16),

            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: Icon(Icons.visibility_off_outlined),
              ),
            ),

            const SizedBox(height: 30),

            /// Buttons
            ElevatedButton(
              onPressed: () {},
              child: const Text("Elevated Button"),
            ),

            const SizedBox(height: 16),

            OutlinedButton(
              onPressed: () {},
              child: const Text("Outlined Button"),
            ),

            const SizedBox(height: 16),

            FilledButton(onPressed: () {}, child: const Text("Filled Button")),

            const SizedBox(height: 30),

            /// Card
            const Card(
              child:  Padding(
                padding: EdgeInsets.all(20),
                child:  Column(
                  children: [
                    Text("Card Title"),
                    SizedBox(height: 8),
                    Text("This card uses your CardTheme."),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Checkbox
            Row(
              children: [
                Checkbox(value: true, onChanged: (_) {}),
                const Text("Checkbox"),
              ],
            ),

            /// Switch
            Row(
              children: [
                Switch(value: true, onChanged: (_) {}),
                const SizedBox(width: 8),
                const Text("Switch"),
              ],
            ),

            const SizedBox(height: 20),

            /// Progress Indicators
            const LinearProgressIndicator(value: .6),

            const SizedBox(height: 20),

            const Center(child: CircularProgressIndicator()),

            const SizedBox(height: 30),

            /// Chips
            Wrap(
              spacing: 10,
              children: [
                Chip(label: const Text("Chip"), onDeleted: () {}),
                ActionChip(label: const Text("Action Chip"), onPressed: () {}),
              ],
            ),

            const SizedBox(height: 30),

            /// Divider
            const Divider(),

            const SizedBox(height: 20),

            /// List Tile
            const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text("Ahmed Mohamed"),
              subtitle: Text("Flutter Developer"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),

            // GlassContainer(),
          ],
        ),
      ),
    );
  }
}
