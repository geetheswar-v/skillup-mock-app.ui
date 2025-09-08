import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/router/app_router.dart';
import '../../core/state/app_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _onLogin(BuildContext context) {
    context.read<AppState>().demoLogin();
    Navigator.of(context).pushNamedAndRemoveUntil(AppRouterDelegate.routeHome, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Welcome to SkillUP', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  TextFormField(decoration: const InputDecoration(hintText: 'Email Address')),
                  const SizedBox(height: 8),
                  TextFormField(decoration: const InputDecoration(hintText: 'Password'), obscureText: true),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(onPressed: () {}, child: const Text('Forgot password?')),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => _onLogin(context), child: const Text('Login')),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member? '),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(AppRouterDelegate.routeSignup),
                        child: Text('Register now', style: TextStyle(color: Theme.of(context).primaryColor)),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  _OAuthButton(icon: Icons.g_mobiledata, label: 'Continue with Google', onTap: () => _onLogin(context)),
                  const SizedBox(height: 8),
                  _OAuthButton(icon: Icons.code, label: 'Continue with GitHub', onTap: () => _onLogin(context)),
                  const SizedBox(height: 8),
                  _OAuthButton(icon: Icons.email_outlined, label: 'Continue with Email', onTap: () => _onLogin(context)),
                  const SizedBox(height: 16),
                  const Text('Demo-only authentication. No backend required.'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OAuthButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _OAuthButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        onPressed: onTap,
      ),
    );
  }
}
