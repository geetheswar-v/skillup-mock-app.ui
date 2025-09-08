import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../core/router/app_router.dart';
import '../../core/services/prefs_service.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  int index = 0;

  Future<void> _finish() async {
    await PrefsService().setOnboardingSeen(true);
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRouterDelegate.routeLogin);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (i) => setState(() => index = i),
                  children: const [
                    _OnboardSlide(title: 'Welcome! Sharpen your skills with smart test simulations.', subtitle: 'Your Prep Journey – Track your progress across subjects and test attempts.'),
                    _OnboardSlide(title: 'Adaptive Practice', subtitle: 'Personalized recommendations that grow with you.'),
                    _OnboardSlide(title: 'Insightful Analysis', subtitle: 'Charts to track accuracy and speed.'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(3, (i) => Padding(
                      padding: const EdgeInsets.only(left: 16, right: 4, bottom: 8),
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == index ? Theme.of(context).primaryColor : Colors.black26,
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    TextButton(onPressed: _finish, child: const Text('Skip')),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (index < 2) {
                          controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
                        } else {
                          _finish();
                        }
                      },
                      child: Text(index < 2 ? 'Next' : 'Get Started'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      desktop: (_) => const _DesktopOnboardingPlaceholder(),
      tablet: (_) => const _DesktopOnboardingPlaceholder(),
    );
  }
}

class _OnboardSlide extends StatelessWidget {
  final String title;
  final String subtitle;
  const _OnboardSlide({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 260,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12)),
            child: const Center(child: Icon(Icons.image_outlined, size: 48)),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _DesktopOnboardingPlaceholder extends StatelessWidget {
  const _DesktopOnboardingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('SkillUP', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  const Text('Onboarding is mobile-only in this demo. Continue to login.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(AppRouterDelegate.routeLogin),
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
