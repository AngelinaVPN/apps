import 'package:angelinavpn/models/models.dart';
import 'package:angelinavpn/providers/providers.dart';
import 'package:angelinavpn/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _cGreen = Color(0xFF00E675);
const _cInk = Color(0xFF111111);
const _cLine = Color(0xFF1A1A1A);
const _cLine2 = Color(0x1FFFFFFF); // white ~12%

class SubscriptionSection extends ConsumerStatefulWidget {
  const SubscriptionSection({super.key});

  @override
  ConsumerState<SubscriptionSection> createState() =>
      _SubscriptionSectionState();
}

class _SubscriptionSectionState extends ConsumerState<SubscriptionSection> {
  final _urlCtrl = TextEditingController();
  bool _showField = false;
  bool _isLoading = false;
  String? _loadError;

  @override
  void dispose() {
    _urlCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadSubscription() async {
    final url = _urlCtrl.text.trim();
    if (url.isEmpty) return;

    setState(() {
      _isLoading = true;
      _loadError = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final shouldSend = prefs.getBool('sendDeviceHeaders') ?? true;

      final currentId = ref.read(currentProfileIdProvider);
      final profiles = ref.read(profilesProvider);
      final existingProfile = profiles.getProfile(currentId);

      if (existingProfile != null) {
        // Editing an existing profile
        if (existingProfile.url == url) {
          // Same URL — just refresh data
          await globalState.appController.updateProfile(existingProfile);
        } else {
          // URL changed — replace: delete old, import new
          await globalState.appController.deleteProfile(existingProfile.id);
          final newProfile = await Profile.normal(url: url)
              .update(shouldSendHeaders: shouldSend);
          await globalState.appController.addProfile(newProfile);
          // Force-activate new profile in case addProfile skipped activation
          // (addProfile early-returns when currentProfileId is non-null)
          ref.read(currentProfileIdProvider.notifier).value = newProfile.id;
          globalState.appController.applyProfileDebounce(silence: true);
        }
      } else {
        // Fresh import — check for duplicate URL first
        final duplicate = profiles
            .where((p) => p.url == url)
            .cast<Profile?>()
            .firstOrNull;
        if (duplicate != null) {
          // Already have this subscription — switch to it and refresh
          ref.read(currentProfileIdProvider.notifier).value = duplicate.id;
          await globalState.appController.updateProfile(duplicate);
          globalState.appController.applyProfileDebounce(silence: true);
        } else {
          final profile = await Profile.normal(url: url)
              .update(shouldSendHeaders: shouldSend);
          await globalState.appController.addProfile(profile);
          // Force-activate new profile — addProfile early-returns when a
          // stale currentProfileId exists (e.g. after reinstall or data reset)
          ref.read(currentProfileIdProvider.notifier).value = profile.id;
          globalState.appController.applyProfileDebounce(silence: true);
        }
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
          _showField = false;
          _loadError = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadError = 'Не удалось загрузить серверы. Проверьте URL.';
        });
      }
    }
  }

  Future<void> _refreshProfile(Profile profile) async {
    setState(() => _isLoading = true);
    try {
      await globalState.appController.updateProfile(profile);
    } catch (_) {}
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _deleteProfile(Profile profile) async {
    final isStart = ref.read(runTimeProvider.select((s) => s != null));
    if (isStart) {
      await globalState.appController.updateStatus(false);
    }
    await globalState.appController.deleteProfile(profile.id);
    if (mounted) {
      final hasProfiles = ref.read(profilesProvider).isNotEmpty;
      setState(() {
        // Show URL form only when all profiles are deleted
        _showField = !hasProfiles;
        if (_showField) _urlCtrl.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profiles = ref.watch(profilesProvider);
    final currentId = ref.watch(currentProfileIdProvider);
    final profile = profiles.getProfile(currentId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section tag ──
        _SectionTag(text: 'ПОДПИСКА'),
        const SizedBox(height: 8),

        // ── Content ──
        if (profile == null || _showField)
          _buildUrlInput()
        else
          _buildStatus(profile),
      ],
    );
  }

  Widget _buildUrlInput() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // URL field
          Container(
            decoration: BoxDecoration(
              color: _cLine,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: _loadError != null
                    ? Colors.red.withValues(alpha: 0.5)
                    : _cLine2,
              ),
            ),
            child: TextField(
              controller: _urlCtrl,
              style: const TextStyle(
                fontFamily: 'JetBrainsMono',
                fontSize: 13,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Вставьте ссылку на подписку...',
                hintStyle: TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.25),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 11,
                ),
                border: InputBorder.none,
                suffixIcon: _urlCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          size: 14,
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                        onPressed: () {
                          _urlCtrl.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _loadSubscription(),
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
            ),
          ),

          // Error message
          if (_loadError != null) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.orange.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 13,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _loadError!,
                      style: TextStyle(
                        fontFamily: 'JetBrainsMono',
                        fontSize: 12,
                        color: Colors.orange.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 6),

          // Load button
          GestureDetector(
            onTap: (_urlCtrl.text.trim().isEmpty || _isLoading)
                ? null
                : _loadSubscription,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: _urlCtrl.text.trim().isEmpty
                    ? _cGreen.withValues(alpha: 0.25)
                    : _cGreen,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isLoading)
                    const SizedBox(
                      width: 13,
                      height: 13,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: Colors.black,
                      ),
                    )
                  else
                    Icon(
                      Icons.download_rounded,
                      size: 14,
                      color: _urlCtrl.text.trim().isEmpty
                          ? Colors.white.withValues(alpha: 0.3)
                          : Colors.black,
                    ),
                  const SizedBox(width: 6),
                  Text(
                    _isLoading ? 'Загружаю серверы...' : 'Загрузить серверы',
                    style: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _urlCtrl.text.trim().isEmpty
                          ? Colors.white.withValues(alpha: 0.3)
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _buildStatus(Profile profile) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
        decoration: BoxDecoration(
          color: _cGreen.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _cGreen.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            _isLoading
                ? const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: _cGreen,
                    ),
                  )
                : const Icon(
                    Icons.check_circle,
                    color: _cGreen,
                    size: 15,
                  ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _subscriptionStatusText(profile),
                style: const TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Action buttons: refresh / edit / delete
            Row(
              children: [
                _IconBtn(
                  icon: Icons.refresh_rounded,
                  color: _cGreen,
                  onTap: _isLoading ? null : () => _refreshProfile(profile),
                ),
                const SizedBox(width: 6),
                _IconBtn(
                  icon: Icons.edit_outlined,
                  color: Colors.white.withValues(alpha: 0.4),
                  onTap: () {
                    _urlCtrl.text = profile.url;
                    setState(() => _showField = true);
                  },
                ),
                const SizedBox(width: 6),
                _IconBtn(
                  icon: Icons.delete_outline,
                  color: Colors.red.withValues(alpha: 0.65),
                  onTap: () => _confirmDelete(profile),
                ),
              ],
            ),
          ],
        ),
      );

  String _subscriptionStatusText(Profile profile) {
    final info = profile.subscriptionInfo;
    if (info == null) {
      return 'Подписка: неизвестно';
    }
    if (info.expire <= 0) {
      return 'Подписка: активна. Без срока';
    }
    final expireDate = DateTime.fromMillisecondsSinceEpoch(info.expire * 1000);
    final daysLeft = expireDate.difference(DateTime.now()).inDays;
    if (daysLeft <= 0) {
      return 'Подписка: истекла';
    }
    return 'Подписка: активна. Осталось $daysLeft д.';
  }

  void _confirmDelete(Profile profile) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text(
          'Удалить подписку?',
          style: TextStyle(
            fontFamily: 'JetBrainsMono',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        content: Text(
          'Все серверы и данные подписки будут удалены.',
          style: TextStyle(
            fontFamily: 'JetBrainsMono',
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _deleteProfile(profile);
            },
            child: const Text(
              'Удалить',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTag extends StatelessWidget {
  final String text;
  const _SectionTag({required this.text});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '// ',
            style: TextStyle(
              fontFamily: 'JetBrainsMono',
              fontSize: 11,
              color: _cGreen.withValues(alpha: 0.4),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'JetBrainsMono',
              fontSize: 11,
              color: _cGreen,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.5,
            ),
          ),
        ],
      );
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _IconBtn({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(icon, size: 14, color: color),
        ),
      );
}
