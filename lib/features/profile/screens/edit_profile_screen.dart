import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_team/core/supabase/supabase_client.dart';
import 'package:gym_team/features/profile/providers/profile_provider.dart';
import 'package:gym_team/shared/widgets/user_avatar.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _displayNameController = TextEditingController();
  final _bioController = TextEditingController();
  bool _loading = false;
  bool _initialized = false;

  int? _selectedAvatarId;
  String? _selectedAvatarColor;

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _initFromProfile(dynamic profile) {
    if (_initialized) return;
    _initialized = true;
    _displayNameController.text = profile.displayName ?? '';
    _bioController.text = profile.bio ?? '';
    _selectedAvatarId = profile.avatarId;
    _selectedAvatarColor = profile.avatarColor;
  }

  Future<void> _save() async {
    setState(() => _loading = true);
    try {
      final userId = supabase.auth.currentUser!.id;
      await supabase.from('profiles').update({
        'display_name': _displayNameController.text.trim().isEmpty
            ? null
            : _displayNameController.text.trim(),
        'bio': _bioController.text.trim().isEmpty
            ? null
            : _bioController.text.trim(),
        'avatar_id': _selectedAvatarId,
        'avatar_color': _selectedAvatarColor,
      }).eq('id', userId);

      ref.invalidate(myProfileProvider);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(myProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: _loading ? null : _save,
            child: _loading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (profile) {
          _initFromProfile(profile);
          final previewName = _displayNameController.text.trim().isNotEmpty
              ? _displayNameController.text.trim()
              : profile.username;
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              // ── Avatar preview ───────────────────────────────────────────
              Center(
                child: UserAvatar(
                  name: previewName,
                  avatarId: _selectedAvatarId,
                  avatarColor: _selectedAvatarColor,
                  radius: 44,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '@${profile.username}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Icon picker (accordion) ──────────────────────────────────
              ExpansionTile(
                title: const Text('Avatar icon'),
                subtitle: _selectedAvatarId == null
                  ? const Text('Initials', style: TextStyle(fontSize: 12))
                  : Row(
                      children: [
                        Icon(kAvatarIcons[_selectedAvatarId!],
                            size: 16, color: Colors.white54),
                        const SizedBox(width: 6),
                        const Text('Icon selected',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                childrenPadding:
                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  _IconPicker(
                    selected: _selectedAvatarId,
                    onSelected: (id) => setState(() => _selectedAvatarId = id),
                  ),
                ],
              ),

              // ── Color picker (accordion) ─────────────────────────────────
              ExpansionTile(
                title: const Text('Background'),
                subtitle: _buildColorSubtitle(),
                childrenPadding:
                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  _SwatchPicker(
                    selected: _selectedAvatarColor,
                    onSelected: (hex) =>
                        setState(() => _selectedAvatarColor = hex),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),

              // ── Text fields ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: _displayNameController,
                      decoration: const InputDecoration(
                        labelText: 'Display name',
                        hintText: 'Your name shown to others',
                        border: OutlineInputBorder(),
                      ),
                      textCapitalization: TextCapitalization.words,
                      maxLength: 50,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _bioController,
                      decoration: const InputDecoration(
                        labelText: 'Bio',
                        hintText: 'A short description about yourself',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 3,
                      maxLength: 160,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildColorSubtitle() {
    final hex = _selectedAvatarColor;
    if (hex == null) return const Text('None', style: TextStyle(fontSize: 12));
    if (hex.startsWith('gradient:')) {
      final idx = int.tryParse(hex.substring(9)) ?? 0;
      return Text(
        idx < kGradientLabels.length ? kGradientLabels[idx] : 'Gradient',
        style: const TextStyle(fontSize: 12),
      );
    }
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: parseAvatarColor(hex),
          ),
        ),
        const SizedBox(width: 6),
        Text(hex, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// ── Icon picker ───────────────────────────────────────────────────────────────

class _IconPicker extends StatelessWidget {
  final int? selected;
  final ValueChanged<int?> onSelected;

  const _IconPicker({required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        // Initials tile
        _buildTile(
          context,
          isSelected: selected == null,
          onTap: () => onSelected(null),
          child: Text(
            'Aa',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: selected == null
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        // Icon tiles
        ...List.generate(kAvatarIcons.length, (i) {
          final isSelected = selected == i;
          return _buildTile(
            context,
            isSelected: isSelected,
            onTap: () => onSelected(i),
            child: Icon(
              kAvatarIcons[i],
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              size: 26,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required bool isSelected,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 2)
              : null,
        ),
        child: Center(child: child),
      ),
    );
  }
}

// ── Swatch picker (solid colors + gradients) ──────────────────────────────────

class _SwatchPicker extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelected;

  const _SwatchPicker({required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Solid colors
        Text('Solid', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white38)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(kAvatarColors.length, (i) {
            final hex = kAvatarColorHex[i];
            final isSelected = selected == hex;
            return _SwatchTile(
              hex: hex,
              isSelected: isSelected,
              onTap: () => onSelected(hex),
            );
          }),
        ),
        const SizedBox(height: 16),
        // Gradients
        Text('Gradients', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white38)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(kAvatarGradients.length, (i) {
            final hex = kAvatarGradientHex[i];
            final isSelected = selected == hex;
            return _SwatchTile(
              hex: hex,
              isSelected: isSelected,
              onTap: () => onSelected(hex),
              label: kGradientLabels[i],
            );
          }),
        ),
      ],
    );
  }
}

class _SwatchTile extends StatelessWidget {
  final String hex;
  final bool isSelected;
  final VoidCallback onTap;
  final String? label;

  const _SwatchTile({
    required this.hex,
    required this.isSelected,
    required this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: label ?? hex,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 40,
          height: 40,
          decoration: buildAvatarDecoration(hex).copyWith(
            border: isSelected
                ? Border.all(color: Colors.white, width: 3)
                : Border.all(color: Colors.transparent, width: 3),
          ),
          child: isSelected
              ? const Icon(Icons.check, color: Colors.white, size: 18)
              : null,
        ),
      ),
    );
  }
}
