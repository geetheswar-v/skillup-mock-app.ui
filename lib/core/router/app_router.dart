import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/auth/login_page.dart';
import '../../features/auth/signup_page.dart';
import '../../features/home/home_shell.dart';
import '../../features/onboarding/onboarding_page.dart';
import '../../features/subscription/subscription_page.dart';
import '../../features/test/exam_screen.dart';
import '../services/prefs_service.dart';
import '../state/app_state.dart';

class AppRouterDelegate {
  static const routeOnboarding = '/onboarding';
  static const routeLogin = '/login';
  static const routeSignup = '/signup';
  static const routeHome = '/';
  static const routeSubscription = '/subscription';
  static const routeExam = '/exam';

  static Map<String, WidgetBuilder> routes(BuildContext context) => {
        routeOnboarding: (_) => const OnboardingPage(),
        routeLogin: (_) => const LoginPage(),
  routeSignup: (_) => const SignupPage(),
        routeHome: (_) => const HomeShell(),
        routeSubscription: (_) => const SubscriptionPage(),
        routeExam: (_) => const ExamScreen(),
      };

  static Future<String> initialRoute(BuildContext context) async {
  final prefs = PrefsService();
  final loggedIn = context.read<AppState>().loggedIn; // read before awaiting
  final seen = await prefs.getOnboardingSeen();
    if (!seen) return routeOnboarding;
    return loggedIn ? routeHome : routeLogin;
  }
}
