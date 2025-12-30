import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/api_service.dart';
import 'compatibility_results_modal.dart';

class SpecSelectionDialog extends HookConsumerWidget {
  final String gameId;
  final String gameTitle;

  const SpecSelectionDialog({
    super.key,
    required this.gameId,
    required this.gameTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showManual = useState(false);
    final cpuController = useTextEditingController();
    final gpuController = useTextEditingController();
    final ramController = useTextEditingController();
    final isLoading = useState(false);

    final error = useState<String?>(null);

    Future<void> check(Map<String, dynamic>? specs) async {
      isLoading.value = true;
      error.value = null;
      try {
        final api = ref.read(apiServiceProvider);
        final report = await api.checkCompatibility(gameId, userSpecs: specs);
        if (context.mounted) {
          Navigator.pop(context); // Close dialog
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => CompatibilityResultsModal(
              report: report,
              gameTitle: gameTitle,
            ),
          );
        }
      } on DioException catch (e) {
        final data = e.response?.data;
        String message = 'Compatibility check failed';
        if (data['detail'] is String) {
          message = data['detail'];
        } else if (data['detail'] is Map<String, dynamic> && data['detail'].containsKey('message')) {
          message = data['detail']['message'];
        } else if (data['message'] is String) {
          message = data['message'];
        }

        error.value = message;
      } finally {
        isLoading.value = false;
      }
    }

    return AlertDialog(
      title: Text("Check Compatibility"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!showManual.value) ...[
              const Text("Would you like to use your current system specs or enter them manually?"),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isLoading.value ? null : () => check(null),
                  icon: isLoading.value
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.computer),
                  label: const Text("Use Current PC"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              if (error.value != null) ...[
                const SizedBox(height: 12),
                Text(error.value!, style: const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => showManual.value = true,
                child: const Text("Enter Specs Manually"),
              ),
            ] else ...[
              const Text("Enter your hardware details:"),
              const SizedBox(height: 16),
              TextField(
                controller: cpuController,
                decoration: const InputDecoration(
                  labelText: "CPU",
                  hintText: "e.g. Intel Core i5-12400",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: gpuController,
                decoration: const InputDecoration(
                  labelText: "GPU",
                  hintText: "e.g. NVIDIA RTX 3060",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ramController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "RAM (GB)",
                  hintText: "e.g. 16",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => showManual.value = false,
                    child: const Text("Back"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: isLoading.value
                        ? null
                        : () {
                            final specs = {
                              "cpu": cpuController.text,
                              "gpu": gpuController.text,
                              "ram": int.tryParse(ramController.text) ?? 0,
                            };
                            check(specs);
                          },
                    child: isLoading.value
                        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text("Check"),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
