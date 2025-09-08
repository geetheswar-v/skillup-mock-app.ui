import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  String _range = 'Last 30 days';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Performance Trends', style: Theme.of(context).textTheme.headlineSmall),
            ),
            _RangeDropdown(
              value: _range,
              onChanged: (v) => setState(() => _range = v),
            )
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 200,
              child: LineChart(LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: Theme.of(context).colorScheme.primary,
                    barWidth: 3,
                    spots: const [
                      FlSpot(0, 40),
                      FlSpot(1, 55),
                      FlSpot(2, 48),
                      FlSpot(3, 62),
                      FlSpot(4, 70),
                      FlSpot(5, 66),
                      FlSpot(6, 74),
                    ],
                  )
                ],
              )),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Section-wise Accuracy', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _DonutCard(label: 'Quant', percent: 0.72),
            _DonutCard(label: 'VARC', percent: 0.64),
            _DonutCard(label: 'DILR', percent: 0.58),
          ],
        ),
      ],
    );
  }
}

class _RangeDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const _RangeDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final items = const ['All time', 'Last 90 days', 'Last 30 days', 'Last 7 days'];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class _DonutCard extends StatelessWidget {
  final String label;
  final double percent;
  const _DonutCard({required this.label, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 220,
        height: 220,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PieChart(PieChartData(
                  startDegreeOffset: -90,
                  sectionsSpace: 0,
                  centerSpaceRadius: 48,
                  sections: [
                    PieChartSectionData(
                      color: Theme.of(context).colorScheme.primary,
                      value: percent * 100,
                      radius: 16,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      value: (1 - percent) * 100,
                      radius: 16,
                      showTitle: false,
                    ),
                  ],
                )),
              ),
              const SizedBox(height: 8),
              Text(label),
              Text('${(percent * 100).toStringAsFixed(0)}%'),
            ],
          ),
        ),
      ),
    );
  }
}
