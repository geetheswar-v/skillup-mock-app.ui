import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/router/app_router.dart';
import '../../core/state/app_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  bool _agree = false;

  void _submit() {
    if (!_agree) return;
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AppState>().demoLogin();
      Navigator.of(context).pushNamedAndRemoveUntil(AppRouterDelegate.routeHome, (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Create an account to get started', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 16),
                      const Text('Name'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _name,
                        decoration: const InputDecoration(hintText: 'Your name'),
                        validator: (v) => (v == null || v.isEmpty) ? 'Enter your name' : null,
                      ),
                      const SizedBox(height: 12),
                      const Text('Email Address'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(hintText: 'name@email.com'),
                        validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
                      ),
                      const SizedBox(height: 12),
                      const Text('Password'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _pass,
                        obscureText: true,
                        decoration: const InputDecoration(hintText: 'Create a password'),
                        validator: (v) => (v == null || v.length < 6) ? 'Minimum 6 characters' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _confirm,
                        obscureText: true,
                        decoration: const InputDecoration(hintText: 'Confirm password'),
                        validator: (v) => v != _pass.text ? 'Passwords do not match' : null,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Checkbox(value: _agree, onChanged: (v) => setState(() => _agree = v ?? false)),
                          Expanded(
                            child: Text.rich(TextSpan(children: [
                              const TextSpan(text: 'I’ve read and agree with the '),
                              TextSpan(text: 'Terms and Conditions', style: TextStyle(color: Theme.of(context).primaryColor)),
                              const TextSpan(text: ' and the '),
                              TextSpan(text: 'Privacy Policy', style: TextStyle(color: Theme.of(context).primaryColor)),
                            ])),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: _agree ? _submit : null, child: const Text('Create account')),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text.rich(
                          TextSpan(children: [
                            const TextSpan(text: 'Already have an account? '),
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(color: Theme.of(context).primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).pushReplacementNamed(AppRouterDelegate.routeLogin),
                            )
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
