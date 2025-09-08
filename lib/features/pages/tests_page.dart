import 'package:flutter/material.dart';
import '../../core/router/app_router.dart';

class TestsPage extends StatefulWidget {
  const TestsPage({super.key});

  @override
  State<TestsPage> createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  int _segment = 0; // 0: To do, 1: Recommended, 2: Finished

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text('AI Mock Tests', style: Theme.of(context).textTheme.headlineSmall),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pushNamed(AppRouterDelegate.routeExam),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start New Test'),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _SegmentedPill(
            segments: const ['To do', 'Recommended', 'Finished'],
            index: _segment,
            onChanged: (i) => setState(() => _segment = i),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(child: _buildBody(context)),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_segment == 0) {
      // To do list
      return ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.assignment_outlined)),
            title: Text('CAT Quant Practice ${index + 1}'),
            subtitle: const Text('AI generated • 60 min • 66 questions'),
            trailing: ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(AppRouterDelegate.routeExam),
              child: const Text('Start'),
            ),
          ),
        ),
      );
    }
    if (_segment == 1) {
      // Recommended list
      return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.auto_awesome)),
            title: Text('Recommended Set ${index + 1}'),
            subtitle: const Text('Adaptive • 30 min • 40 questions'),
            trailing: ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(AppRouterDelegate.routeExam),
              child: const Text('Attempt'),
            ),
          ),
        ),
      );
    }
    // Finished segment
    return ListView(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.check_circle_outline)),
            title: const Text('CAT Mock 5'),
            subtitle: const Text('Completed • Score 78%'),
            trailing: TextButton(
              onPressed: () {},
              child: const Text('View Analysis'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Icon(Icons.hourglass_empty, color: Theme.of(context).disabledColor),
                const SizedBox(height: 8),
                Text('Want more practice?', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _segment = 0),
                  child: const Text('Start a Mock Test'),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _SegmentedPill extends StatelessWidget {
  final List<String> segments;
  final int index;
  final ValueChanged<int> onChanged;
  const _SegmentedPill({required this.segments, required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final border = Border.all(color: Theme.of(context).dividerColor);
  return Container(
      decoration: BoxDecoration(
    border: border,
    borderRadius: BorderRadius.circular(28),
    color: Theme.of(context).cardColor.withValues(alpha: 0.6),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          for (int i = 0; i < segments.length; i++)
            Expanded(
              child: _SegmentItem(
                label: segments[i],
                selected: index == i,
                onTap: () => onChanged(i),
              ),
            )
        ],
      ),
    );
  }
}

class _SegmentItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SegmentItem({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bg = selected ? Theme.of(context).colorScheme.primary : Colors.transparent;
    final fg = selected ? Colors.white : Theme.of(context).textTheme.bodyMedium?.color;
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: fg)),
      ),
    );
  }
}
