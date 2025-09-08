import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  String _billing = 'Yearly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscription')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Upgrade to Premium', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('Unlock unlimited AI tests and deep analytics.', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _PlanTile(
                    title: 'Yearly',
                    price: '₹249/mo',
                    sub: 'Billed ₹2,988 yearly',
                    value: 'Yearly',
                    groupValue: _billing,
                    badge: 'Save 30%',
                    onChanged: (v) => setState(() => _billing = v),
                  ),
                  const Divider(height: 0),
                  _PlanTile(
                    title: 'Monthly',
                    price: '₹359/mo',
                    sub: 'Billed monthly',
                    value: 'Monthly',
                    groupValue: _billing,
                    onChanged: (v) => setState(() => _billing = v),
                  ),
                  const Divider(height: 0),
                  _PlanTile(
                    title: 'Weekly',
                    price: '₹129/wk',
                    sub: 'Billed weekly',
                    value: 'Weekly',
                    groupValue: _billing,
                    onChanged: (v) => setState(() => _billing = v),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Benefit(text: 'Unlimited AI mock tests'),
                  _Benefit(text: 'Advanced performance analytics'),
                  _Benefit(text: 'Create custom practice sets'),
                  _Benefit(text: 'Priority support'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text('Subscribe'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  final String title;
  final String price;
  final String sub;
  final String value;
  final String groupValue;
  final String? badge;
  final ValueChanged<String> onChanged;
  const _PlanTile({
    required this.title,
    required this.price,
    required this.sub,
    required this.value,
    required this.groupValue,
    this.badge,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: (v) => v != null ? onChanged(v) : null,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleMedium),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(badge!, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12)),
                        )
                      ]
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(price, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 2),
                  Text(sub, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary)
            else
              const Icon(Icons.circle_outlined),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  final String text;
  const _Benefit({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(Icons.check, color: Theme.of(context).colorScheme.primary, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
