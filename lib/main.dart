import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/router/app_router.dart';
import 'core/services/prefs_service.dart';
import 'core/state/app_state.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appState = AppState(PrefsService());
  await appState.load();
  runApp(SkillUpApp(appState: appState));
}

class SkillUpApp extends StatelessWidget {
  final AppState appState;
  const SkillUpApp({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: appState,
      child: Consumer<AppState>(
        builder: (context, state, _) {
          return FutureBuilder<String>(
            future: AppRouterDelegate.initialRoute(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return MaterialApp(
                  title: 'SkillUP',
                  debugShowCheckedModeBanner: false,
                  themeMode: state.themeMode,
                  theme: buildLightTheme(),
                  darkTheme: buildDarkTheme(),
                  home: const Scaffold(body: Center(child: CircularProgressIndicator())),
                );
              }
              return MaterialApp(
                title: 'SkillUP',
                debugShowCheckedModeBanner: false,
                themeMode: state.themeMode,
                theme: buildLightTheme(),
                darkTheme: buildDarkTheme(),
                routes: AppRouterDelegate.routes(context),
                initialRoute: snapshot.data,
              );
            },
          );
        },
      ),
    );
  }
}
