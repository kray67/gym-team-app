import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/features/plans/providers/plans_provider.dart';

class DiscoverPlansScreen extends ConsumerWidget {
  const DiscoverPlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(publicPlansProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Discover Plans')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (plans) => plans.isEmpty
            ? Center(
                child: Text(
                  'No public plans yet.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: plans.length,
                itemBuilder: (context, i) {
                  final plan = plans[i];
                  final count = plan.exercises.length;
                  final ownerName = plan.owner?.displayName ??
                      plan.owner?.username ??
                      'Unknown';
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    child: ListTile(
                      title: Text(plan.title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        'by $ownerName · $count ${count == 1 ? 'exercise' : 'exercises'}',
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 13),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/plans/${plan.id}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
