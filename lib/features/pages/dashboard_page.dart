import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Welcome back! 👋', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('Here’s a quick summary of your progress.', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              _FilterChip(label: 'All Tests', selected: true),
              _FilterChip(label: 'CAT'),
              _FilterChip(label: 'GATE'),
              _FilterChip(label: 'Custom'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _StatCard(title: 'Attempted', value: '12'),
            _StatCard(title: 'Avg. Score', value: '72%'),
            _StatCard(title: 'Best Rank', value: 'Top 9%'),
          ],
        ),
        const SizedBox(height: 24),
        Text('Recommendations', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
  ...List.generate(3, (i) => const _RecommendationTile()),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

class _RecommendationTile extends StatelessWidget {
  const _RecommendationTile();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.lightbulb_outline),
        title: const Text('Focus on Quantitative Aptitude: Algebra'),
        subtitle: const Text('Practice 15 AI-curated questions to boost accuracy.'),
  trailing: ElevatedButton(
          onPressed: () {},
          child: const Text('Start'),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _FilterChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {},
      ),
    );
  }
}
