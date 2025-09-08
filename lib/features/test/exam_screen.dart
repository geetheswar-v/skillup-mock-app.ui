import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late Timer _timer;
  Duration _remaining = const Duration(minutes: 60);
  int _current = 0;
  final int _total = 20;
  final Map<int, int> _answers = {};
  bool _showSecurityOverlay = true;

  @override
  void initState() {
    super.initState();
  // Enter immersive fullscreen where supported (mobile)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        if (_remaining.inSeconds > 0) {
          _remaining -= const Duration(seconds: 1);
        } else {
          t.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
  // Restore system UI overlays
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _toggleSecurity() => setState(() => _showSecurityOverlay = !_showSecurityOverlay);

  @override
  Widget build(BuildContext context) {
    final mm = _remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = _remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Mode'),
        actions: [
          IconButton(onPressed: _toggleSecurity, tooltip: 'Toggle Security Overlay', icon: const Icon(Icons.shield_outlined)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(child: Text('Time: $mm:$ss')),
          )
        ],
      ),
      body: Stack(
        children: [
          Row(
            children: [
              // Question area
              Expanded(
                child: _QuestionView(
                  index: _current,
                  total: _total,
                  selected: _answers[_current],
                  onSelect: (v) => setState(() => _answers[_current] = v),
                ),
              ),
              // Navigation panel
              Container(
                width: 260,
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: Theme.of(context).dividerColor)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    const Text('Questions'),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: _total,
                        itemBuilder: (context, i) {
                          final answered = _answers.containsKey(i);
                          final selected = i == _current;
                          return InkWell(
                            onTap: () => setState(() => _current = i),
                            child: Container(
                              decoration: BoxDecoration(
                color: selected
                  ? Theme.of(context).colorScheme.primary
                  : answered
                    ? const Color(0xFF4CAF50).withValues(alpha: 0.2)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text('${i + 1}',
                                    style: TextStyle(
                                        color: selected ? Colors.white : null, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _current > 0 ? () => setState(() => _current--) : null,
                              child: const Text('Prev'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _current < _total - 1 ? () => setState(() => _current++) : null,
                              child: const Text('Next'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          if (_showSecurityOverlay) const _SecurityOverlay(),
        ],
      ),
    );
  }
}

class _QuestionView extends StatelessWidget {
  final int index;
  final int total;
  final int? selected;
  final ValueChanged<int> onSelect;
  const _QuestionView({required this.index, required this.total, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {}, // helps block text selection in mobile
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question ${index + 1} of $total', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            const Text(
                'If f(x) = x² - 5x + 6, what is the value of f(3)? Choose the correct option below.'),
            const SizedBox(height: 16),
            ...List.generate(4, (i) => _OptionTile(index: i, selected: selected, onSelect: onSelect)),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final int index;
  final int? selected;
  final ValueChanged<int> onSelect;
  const _OptionTile({required this.index, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: RadioListTile<int>(
        value: index,
        groupValue: selected,
        title: Text('Option ${index + 1}'),
        onChanged: (v) => onSelect(v!),
      ),
    );
  }
}

class _SecurityOverlay extends StatelessWidget {
  const _SecurityOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: Container(
  color: const Color(0xFF000000).withValues(alpha: 0.6),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.no_photography, color: Colors.white, size: 64),
              SizedBox(height: 12),
              Text('No Screenshot / Copy Allowed', style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(height: 8),
              Text('(Demo-only security overlay)', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}
