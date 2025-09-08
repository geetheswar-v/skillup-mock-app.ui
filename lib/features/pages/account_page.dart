import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/router/app_router.dart';
import '../../core/state/app_state.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        const ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text('Demo User'),
          subtitle: Text('demo@skillup.app'),
        ),
        const Divider(),
        Text('Settings', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        const ListTile(
          leading: Icon(Icons.auto_awesome),
          title: Text('AI Settings'),
          trailing: Icon(Icons.chevron_right),
        ),
        const ListTile(
          leading: Icon(Icons.delete_outline),
          title: Text('Data Deletion'),
          trailing: Icon(Icons.chevron_right),
        ),
        const ListTile(
          leading: Icon(Icons.devices_other_outlined),
          title: Text('Connected Devices'),
          trailing: Icon(Icons.chevron_right),
        ),
        const ListTile(
          leading: Icon(Icons.notifications_outlined),
          title: Text('Notifications'),
          trailing: Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: const Icon(Icons.brightness_6),
          title: const Text('Theme'),
          subtitle: Text(app.themeMode.name),
          trailing: DropdownButton<ThemeMode>(
            value: app.themeMode,
            items: const [
              DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
              DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
            ],
            onChanged: (m) => m != null ? app.setThemeMode(m) : null,
          ),
        ),
        const ListTile(
          leading: Icon(Icons.language_outlined),
          title: Text('Language'),
          trailing: Icon(Icons.chevron_right),
        ),
        const ListTile(
          leading: Icon(Icons.privacy_tip_outlined),
          title: Text('Privacy & Security'),
          trailing: Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: const Icon(Icons.workspace_premium_outlined),
          title: const Text('Subscription Plans'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed(AppRouterDelegate.routeSubscription),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            context.read<AppState>().demoLogout();
            Navigator.of(context).pushNamedAndRemoveUntil(AppRouterDelegate.routeLogin, (route) => false);
          },
        )
      ],
    );
  }
}
