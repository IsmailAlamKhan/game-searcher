import 'package:flutter/material.dart';

import '../models/compatibility_report.dart';

class CompatibilityResultsModal extends StatelessWidget {
  final CompatibilityReport report;
  final String gameTitle;

  const CompatibilityResultsModal({
    super.key,
    required this.report,
    required this.gameTitle,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'passed':
        return Colors.green;
      case 'minimum met':
        return Colors.blue;
      case 'limited':
      case 'might struggle':
        return Colors.orange;
      case 'failed':
      case 'insufficient space':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'passed':
        return Icons.check_circle;
      case 'minimum met':
        return Icons.info;
      case 'limited':
      case 'might struggle':
        return Icons.warning;
      case 'failed':
      case 'insufficient space':
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final overallColor = _getStatusColor(report.overall);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Compatibility Report",
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            gameTitle,
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
          ),
          const SizedBox(height: 24),

          // Overall Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: overallColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: overallColor.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Icon(_getStatusIcon(report.overall), color: overallColor, size: 48),
                const SizedBox(height: 12),
                Text(
                  report.overall.toUpperCase(),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: overallColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (report.predictedPreset != null && report.predictedPreset != "N/A") ...[
                  const SizedBox(height: 8),
                  Text(
                    "Predicted Setting: ${report.predictedPreset}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Details List
          ...report.details.entries.map((entry) {
            final key = entry.key;
            final val = entry.value;
            final color = _getStatusColor(val.status);

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(_getStatusIcon(val.status), color: color, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              key.toUpperCase(),
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.hintColor,
                              ),
                            ),
                            Text(
                              val.status,
                              style: TextStyle(color: color, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          val.user,
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        if (val.requirement != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            "Required: ${val.requirement}",
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                          ),
                        ],
                        if (val.message != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            val.message!,
                            style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          if (report.warnings.isNotEmpty) ...[
            const Divider(height: 32),
            ...report.warnings.map(
              (w) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber, color: Colors.orange, size: 16),
                    const SizedBox(width: 8),
                    Expanded(child: Text(w, style: const TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Got it"),
            ),
          ),
        ],
      ),
    );
  }
}
