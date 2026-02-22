import 'dart:ui';

import 'package:angelinavpn/common/common.dart';
import 'package:angelinavpn/enum/enum.dart';
import 'package:angelinavpn/models/models.dart' hide Action;
import 'package:angelinavpn/pages/pages.dart';
import 'package:angelinavpn/providers/providers.dart';
import 'package:angelinavpn/state.dart';
import 'package:angelinavpn/views/profiles/edit_profile.dart';
import 'package:angelinavpn/views/profiles/override_profile.dart';
import 'package:angelinavpn/views/profiles/scripts.dart';
import 'package:angelinavpn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'add_profile.dart';

class ProfilesView extends StatefulWidget {
  const ProfilesView({super.key});

  @override
  State<ProfilesView> createState() => _ProfilesViewState();
}

class _ProfilesViewState extends State<ProfilesView> with PageMixin {
  Function? applyConfigDebounce;

  void _handleShowAddExtendPage() {
    showExtend(
      globalState.navigatorKey.currentState!.context,
      builder: (_, type) => AdaptiveSheetScaffold(
          type: type,
          body: AddProfileView(
            context: globalState.navigatorKey.currentState!.context,
          ),
          title: "${appLocalizations.add}${appLocalizations.profile}",
        ),
    );
  }

  Future<void> _updateProfiles() async {
    final profiles = globalState.config.profiles;
    final messages = [];
    final updateProfiles = profiles.map<Future>(
      (profile) async {
        if (profile.type == ProfileType.file) return;
        globalState.appController.setProfile(
          profile.copyWith(isUpdating: true),
        );
        try {
          await globalState.appController.updateProfile(profile);
        } catch (e) {
          messages.add("${profile.label ?? profile.id}: $e \n");
          globalState.appController.setProfile(
            profile.copyWith(
              isUpdating: false,
            ),
          );
        }
      },
    );
    final titleMedium = context.textTheme.titleMedium;
    await Future.wait(updateProfiles);
    if (messages.isNotEmpty) {
      globalState.showMessage(
        title: appLocalizations.tip,
        message: TextSpan(
          children: [
            for (final message in messages)
              TextSpan(text: message, style: titleMedium)
          ],
        ),
      );
    }
  }

  @override
  List<Widget> get actions => [
        IconButton(
          onPressed: _updateProfiles,
          icon: const Icon(Icons.sync),
        ),
        IconButton(
          onPressed: () {
            showExtend(
              context,
              builder: (_, type) => const ScriptsView(),
            );
          },
          icon: Consumer(
            builder: (context, ref, __) {
              final isScriptMode = ref.watch(
                  scriptStateProvider.select((state) => state.realId != null));
              return Icon(
                Icons.functions,
                color: isScriptMode ? context.colorScheme.primary : null,
              );
            },
          ),
        ),
        IconButton(
          onPressed: () {
            final profiles = globalState.config.profiles;
            showSheet(
              context: context,
              builder: (_, type) => ReorderableProfilesSheet(
                  type: type,
                  profiles: profiles,
                ),
            );
          },
          icon: const Icon(Icons.sort),
          iconSize: 26,
        ),
      ];

  @override
  Widget? get floatingActionButton => FloatingActionButton(
        heroTag: null,
        onPressed: _handleShowAddExtendPage,
        child: const Icon(
          Icons.add,
        ),
      );

  @override
  Widget build(BuildContext context) => Consumer(
      builder: (_, ref, __) {
        ref.listenManual(
          isCurrentPageProvider(PageLabel.profiles),
          (prev, next) {
            if (prev != next && next == true) {
              initPageState();
            }
          },
          fireImmediately: true,
        );
        final profilesSelectorState = ref.watch(profilesSelectorStateProvider);
        if (profilesSelectorState.profiles.isEmpty) {
          return NullStatus(
            label: appLocalizations.nullProfileDesc,
          );
        }
        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 88,
            ),
            child: Grid(
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              crossAxisCount: profilesSelectorState.columns,
              children: [
                for (int i = 0; i < profilesSelectorState.profiles.length; i++)
                  GridItem(
                    child: ProfileItem(
                      key: Key(profilesSelectorState.profiles[i].id),
                      profile: profilesSelectorState.profiles[i],
                      groupValue: profilesSelectorState.currentProfileId,
                      onChanged: (profileId) {
                        ref.read(currentProfileIdProvider.notifier).value =
                            profileId;
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
}

class ProfileItem extends StatefulWidget {

  const ProfileItem({
    super.key,
    required this.profile,
    required this.groupValue,
    required this.onChanged,
  });
  final Profile profile;
  final String? groupValue;
  final void Function(String? value) onChanged;

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  final FocusNode _menuFocusNode = FocusNode();
  bool _isMenuFocused = false;
  bool _isTV = false;

  @override
  void initState() {
    super.initState();
    _checkIfTV();
    _menuFocusNode.addListener(() {
      if (mounted) {
        setState(() {
          _isMenuFocused = _menuFocusNode.hasFocus;
        });
      }
    });
  }

  Future<void> _checkIfTV() async {
    final isTV = await system.isAndroidTV;
    if (mounted) {
      setState(() {
        _isTV = isTV;
      });
    }
  }

  @override
  void dispose() {
    _menuFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleDeleteProfile(BuildContext context) async {
    final res = await globalState.showMessage(
      title: appLocalizations.tip,
      message: TextSpan(
        text: appLocalizations.deleteTip(appLocalizations.profile),
      ),
    );
    if (res != true) {
      return;
    }
    await globalState.appController.deleteProfile(widget.profile.id);
  }

  Future updateProfile() async {
    final appController = globalState.appController;
    if (widget.profile.type == ProfileType.file) return;
    await globalState.safeRun(silence: false, () async {
      try {
        appController.setProfile(
          widget.profile.copyWith(
            isUpdating: true,
          ),
        );
        await appController.updateProfile(widget.profile);
      } catch (e) {
        appController.setProfile(
          widget.profile.copyWith(
            isUpdating: false,
          ),
        );
        rethrow;
      }
    });
  }

  void _handleShowEditExtendPage(BuildContext context) {
    showExtend(
      context,
      builder: (_, type) => AdaptiveSheetScaffold(
          type: type,
          disableBackground: false,
          body: EditProfileView(
            profile: widget.profile,
            context: context,
          ),
          title: "${appLocalizations.edit}${appLocalizations.profile}",
        ),
    );
  }

  static const _monoStyle = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 10,
    color: Colors.white38,
    letterSpacing: 0.5,
  );

  List<Widget> _buildUrlProfileInfo(BuildContext context) {
    final subscriptionInfo = widget.profile.subscriptionInfo;

    if (subscriptionInfo == null) {
      return [
        const SizedBox(height: 3),
        Text(
          widget.profile.lastUpdateDate?.lastUpdateTimeDesc ?? "",
          style: _monoStyle,
        ),
      ];
    }

    final isUnlimited = subscriptionInfo.total == 0;
    final expireDate = subscriptionInfo.expire > 0
        ? DateFormat('dd.MM.yyyy').format(
            DateTime.fromMillisecondsSinceEpoch(subscriptionInfo.expire * 1000))
        : null;

    return [
      const SizedBox(height: 4),
      if (!isUnlimited)
        Builder(builder: (context) {
          final totalTraffic = TrafficValue(value: subscriptionInfo.total);
          final usedTrafficValue =
              subscriptionInfo.upload + subscriptionInfo.download;
          final usedTraffic = TrafficValue(value: usedTrafficValue);

          var progress = 0.0;
          if (subscriptionInfo.total > 0) {
            progress = usedTrafficValue / subscriptionInfo.total;
          }
          progress = progress.clamp(0.0, 1.0);

          Color progressColor = const Color(0xFF00E675);
          if (progress > 0.9) {
            progressColor = Colors.red.shade400;
          } else if (progress > 0.7) {
            progressColor = Colors.orange.shade400;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'traffic: ${usedTraffic.showValue} ${usedTraffic.showUnit} / ${totalTraffic.showValue} ${totalTraffic.showUnit}',
                style: _monoStyle,
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 3,
                  backgroundColor: const Color(0xFF1A1A1A),
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                ),
              ),
              const SizedBox(height: 4),
            ],
          );
        }),
      if (expireDate != null)
        Text(
          'expires: $expireDate',
          style: _monoStyle,
        )
      else if (isUnlimited)
        Text(
          'expires: unlimited',
          style: _monoStyle.copyWith(color: const Color(0xFF00E675).withValues(alpha: 0.5)),
        ),
    ];
  }



  Future<void> _handleExportFile(BuildContext context) async {
    final commonScaffoldState = context.commonScaffoldState;
    final res = await commonScaffoldState?.loadingRun<bool>(
      () async {
        final file = await widget.profile.getFile();
        final value = await picker.saveFile(
          widget.profile.label ?? widget.profile.id,
          file.readAsBytesSync(),
        );
        if (value == null) return false;
        return true;
      },
      title: appLocalizations.tip,
    );
    if (res == true && context.mounted) {
      context.showNotifier(appLocalizations.exportSuccess);
    }
  }

  void _handlePushGenProfilePage(BuildContext context, String id) {
    final overrideProfileView = OverrideProfileView(
      profileId: id,
    );
    BaseNavigator.modal(
      context,
      overrideProfileView,
    );
  }

  static const _cGreen = Color(0xFF00E675);
  static const _cGreenDim = Color(0x1200E675);
  static const _cGreenBorder = Color(0x4000E675);
  static const _cInk = Color(0xFF111111);
  static const _cLine = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.profile.id == widget.groupValue;
    return GestureDetector(
      onTap: _isTV
          ? null
          : () => widget.onChanged(widget.profile.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? _cGreenDim : _cInk,
          border: Border.all(
            color: isSelected ? _cGreenBorder : _cLine,
            width: isSelected ? 1.5 : 1.0,
          ),
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: _cGreen.withValues(alpha: 0.08),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          child: Row(
            children: [
              // Selection indicator dot
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? _cGreen : const Color(0xFF333333),
                  boxShadow: isSelected
                      ? [BoxShadow(color: _cGreen.withValues(alpha: 0.5), blurRadius: 6)]
                      : null,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: _isTV ? () => widget.onChanged(widget.profile.id) : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Section tag style label
                      Row(
                        children: [
                          Text(
                            '// ',
                            style: TextStyle(
                              fontFamily: 'JetBrainsMono',
                              fontSize: 10,
                              color: isSelected ? _cGreen : const Color(0xFF444444),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (widget.profile.label ?? widget.profile.id).toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'JetBrainsMono',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? _cGreen : Colors.white70,
                                letterSpacing: 1.5,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      ..._buildUrlProfileInfo(context),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 36,
                width: 36,
                child: FadeThroughBox(
                  child: widget.profile.isUpdating
                      ? const Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: _cGreen,
                          ),
                        )
                      : CommonPopupBox(
                          popup: CommonPopupMenu(
                            items: [
                              if (_isTV)
                                PopupMenuItemData(
                                  icon: Icons.check_circle_outline,
                                  label: appLocalizations.selectProfile,
                                  onPressed: () {
                                    widget.onChanged(widget.profile.id);
                                  },
                                ),
                              PopupMenuItemData(
                                icon: Icons.edit_outlined,
                                label: appLocalizations.edit,
                                onPressed: () {
                                  _handleShowEditExtendPage(context);
                                },
                              ),
                              if (widget.profile.type == ProfileType.url) ...[
                                PopupMenuItemData(
                                  icon: Icons.sync_alt_sharp,
                                  label: appLocalizations.sync,
                                  onPressed: updateProfile,
                                ),
                              ],
                              if (system.isMobile && !_isTV)
                                PopupMenuItemData(
                                  icon: Icons.tv_outlined,
                                  label: appLocalizations.sendToTv,
                                  onPressed: () {
                                    BaseNavigator.push(context,
                                        SendToTvPage(profileUrl: widget.profile.url));
                                  },
                                ),
                              if (widget.profile.providerHeaders['support-url'] != null &&
                                  widget.profile.providerHeaders['support-url']!.isNotEmpty &&
                                  !_isTV)
                                PopupMenuItemData(
                                  icon: widget.profile.providerHeaders['support-url']!
                                          .toLowerCase()
                                          .contains('t.me')
                                      ? Icons.telegram
                                      : Icons.insert_link,
                                  label: appLocalizations.support,
                                  onPressed: () {
                                    globalState.openUrl(
                                        widget.profile.providerHeaders['support-url']!);
                                  },
                                ),
                              PopupMenuItemData(
                                icon: Icons.extension_outlined,
                                label: appLocalizations.override,
                                onPressed: () {
                                  _handlePushGenProfilePage(context, widget.profile.id);
                                },
                              ),
                              PopupMenuItemData(
                                icon: Icons.file_copy_outlined,
                                label: appLocalizations.exportFile,
                                onPressed: () {
                                  _handleExportFile(context);
                                },
                              ),
                              PopupMenuItemData(
                                icon: Icons.delete_outlined,
                                label: appLocalizations.delete,
                                onPressed: () {
                                  _handleDeleteProfile(context);
                                },
                              ),
                            ],
                          ),
                          targetBuilder: (open) => Focus(
                              focusNode: _menuFocusNode,
                              canRequestFocus: true,
                              child: Material(
                                color: _isMenuFocused
                                    ? const Color(0xFF1A1A1A)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: open,
                                  icon: const Icon(Icons.more_vert, size: 18),
                                  color: Colors.white38,
                                ),
                              ),
                            ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReorderableProfilesSheet extends StatefulWidget {

  const ReorderableProfilesSheet({
    super.key,
    required this.profiles,
    required this.type,
  });
  final List<Profile> profiles;
  final SheetType type;

  @override
  State<ReorderableProfilesSheet> createState() =>
      _ReorderableProfilesSheetState();
}

class _ReorderableProfilesSheetState extends State<ReorderableProfilesSheet> {
  late List<Profile> profiles;

  @override
  void initState() {
    super.initState();
    profiles = List.from(widget.profiles);
  }

  Widget proxyDecorator(
    Widget child,
    int index,
    Animation<double> animation,
  ) {
    final profile = profiles[index];
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        final animValue = Curves.easeInOut.transform(animation.value);
        final scale = lerpDouble(1, 1.02, animValue)!;
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: Container(
        key: Key(profile.id),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: CommonCard(
          type: CommonCardType.filled,
          child: ListTile(
            contentPadding: const EdgeInsets.only(
              right: 44,
              left: 16,
            ),
            title: Text(profile.label ?? profile.id),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AdaptiveSheetScaffold(
      type: widget.type,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            globalState.appController.setProfiles(profiles);
          },
          icon: const Icon(
            Icons.save,
          ),
        )
      ],
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 32,
          top: 16,
        ),
        child: ReorderableListView.builder(
          buildDefaultDragHandles: false,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          proxyDecorator: proxyDecorator,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final profile = profiles.removeAt(oldIndex);
              profiles.insert(newIndex, profile);
            });
          },
          itemBuilder: (_, index) {
            final profile = profiles[index];
            return Container(
              key: Key(profile.id),
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: CommonCard(
                type: CommonCardType.filled,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(
                    right: 16,
                    left: 16,
                  ),
                  title: Text(profile.label ?? profile.id),
                  trailing: ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.drag_handle),
                  ),
                ),
              ),
            );
          },
          itemCount: profiles.length,
        ),
      ),
      title: appLocalizations.profilesSort,
    );
}
