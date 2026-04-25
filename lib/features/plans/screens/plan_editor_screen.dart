import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/features/plans/providers/plan_editor_provider.dart';

const _difficultyOptions = ['novice', 'intermediate', 'advanced'];
const _difficultyLabels = ['Novice', 'Intermediate', 'Advanced'];
const _equipmentOptions = [
  'bodyweight',
  'dumbbells',
  'garage_gym',
  'commercial_gym'
];
const _equipmentLabels = ['Bodyweight', 'Dumbbells', 'Garage Gym', 'Commercial Gym'];
const _durationOptions = [30, 45, 60, 75, 90];

/// Step 1 of the plan creation/editing flow.
/// Collects plan metadata; exercises are configured in PlanSessionBuilderScreen.
class PlanEditorScreen extends ConsumerStatefulWidget {
  const PlanEditorScreen({super.key});

  @override
  ConsumerState<PlanEditorScreen> createState() => _PlanEditorScreenState();
}

class _PlanEditorScreenState extends ConsumerState<PlanEditorScreen> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;

  @override
  void initState() {
    super.initState();
    final s = ref.read(planEditorNotifierProvider);
    _titleCtrl = TextEditingController(text: s?.title ?? '');
    _descCtrl = TextEditingController(text: s?.description ?? '');
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _confirmDiscard() async {
    final discard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard plan?'),
        content: const Text('Unsaved changes will be lost.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style:
                TextButton.styleFrom(foregroundColor: Colors.red.shade400),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    if (discard == true && mounted) {
      ref.read(planEditorNotifierProvider.notifier).discard();
      context.pop();
    }
  }

  void _onNext() {
    final notifier = ref.read(planEditorNotifierProvider.notifier);
    if (_titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Title is required')));
      return;
    }
    notifier.setTitle(_titleCtrl.text);
    notifier.setDescription(_descCtrl.text);
    context.push('/plans/sessions-builder');
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(planEditorNotifierProvider);
    if (s == null) {
      return Scaffold(appBar: AppBar(), body: const SizedBox.shrink());
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) await _confirmDiscard();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _confirmDiscard,
          ),
          title: Text(s.planId == null ? 'New Plan' : 'Edit Plan'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Basic info ────────────────────────────────────────────────
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                  labelText: 'Plan title *', border: OutlineInputBorder()),
              onChanged: (v) =>
                  ref.read(planEditorNotifierProvider.notifier).setTitle(v),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  border: OutlineInputBorder()),
              maxLines: 2,
              onChanged: (v) =>
                  ref.read(planEditorNotifierProvider.notifier).setDescription(v),
            ),
            const SizedBox(height: 4),
            SwitchListTile(
              title: const Text('Public'),
              subtitle: const Text('Visible to other users'),
              value: s.isPublic,
              onChanged: (v) =>
                  ref.read(planEditorNotifierProvider.notifier).setIsPublic(v),
              contentPadding: EdgeInsets.zero,
            ),

            const Divider(height: 24),

            // ── Plan structure ────────────────────────────────────────────
            Text('Plan Structure',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _LabeledStepper(
                    label: 'Weeks',
                    value: s.weeks,
                    min: 1,
                    max: 52,
                    onChanged: (v) => ref
                        .read(planEditorNotifierProvider.notifier)
                        .setWeeks(v),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _LabeledStepper(
                    label: 'Sessions / week',
                    value: s.sessionsPerWeek,
                    min: 1,
                    max: 7,
                    onChanged: (v) => ref
                        .read(planEditorNotifierProvider.notifier)
                        .setSessionsPerWeek(v),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Text('Avg Duration',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.white54)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: _durationOptions
                  .map((d) => ChoiceChip(
                        label: Text('$d min'),
                        selected: s.avgDurationMins == d,
                        onSelected: (_) => ref
                            .read(planEditorNotifierProvider.notifier)
                            .setAvgDurationMins(d),
                      ))
                  .toList(),
            ),

            const SizedBox(height: 16),
            Text('Difficulty',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.white54)),
            const SizedBox(height: 6),
            SegmentedButton<String>(
              segments: List.generate(
                _difficultyOptions.length,
                (i) => ButtonSegment(
                    value: _difficultyOptions[i],
                    label: Text(_difficultyLabels[i])),
              ),
              selected: {s.difficulty},
              onSelectionChanged: (v) => ref
                  .read(planEditorNotifierProvider.notifier)
                  .setDifficulty(v.first),
              showSelectedIcon: false,
            ),

            const SizedBox(height: 16),
            Text('Equipment',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.white54)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: List.generate(
                _equipmentOptions.length,
                (i) => ChoiceChip(
                  label: Text(_equipmentLabels[i]),
                  selected: s.equipment == _equipmentOptions[i],
                  onSelected: (_) => ref
                      .read(planEditorNotifierProvider.notifier)
                      .setEquipment(_equipmentOptions[i]),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: FilledButton.icon(
              onPressed: _onNext,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next: Configure Sessions'),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Labeled stepper ──────────────────────────────────────────────────────────

class _LabeledStepper extends StatelessWidget {
  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  const _LabeledStepper({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.white54)),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: value > min ? () => onChanged(value - 1) : null,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Icon(Icons.remove,
                    size: 18,
                    color: value > min ? null : Colors.white24),
              ),
            ),
            SizedBox(
              width: 40,
              child: Text('$value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            InkWell(
              onTap: value < max ? () => onChanged(value + 1) : null,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Icon(Icons.add,
                    size: 18,
                    color: value < max ? null : Colors.white24),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
