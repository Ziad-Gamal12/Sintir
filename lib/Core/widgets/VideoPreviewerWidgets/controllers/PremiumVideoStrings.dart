import 'dart:async';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/VideoPreviewerWidgets/controllers/video_player_controller_helper.dart';

/// TODO: move these to LocaleKeys.
class PremiumVideoStrings {
  static const auto = 'Auto';
  static const quality = 'Quality';
  static const speed = 'Playback speed';
  static const normal = 'Normal';
  static const retry = 'Retry';
  static const loadFailedHint = 'Unable to load this video.';
}

class PremiumVideoControls extends StatefulWidget {
  final BetterPlayerController player;
  final CustomVideoControllerBetter controller;
  final String? title;

  const PremiumVideoControls({
    super.key,
    required this.player,
    required this.controller,
    this.title,
  });

  @override
  State<PremiumVideoControls> createState() => _PremiumVideoControlsState();
}

class _PremiumVideoControlsState extends State<PremiumVideoControls> {
  static const _hideDelay = Duration(seconds: 3);
  static const _skip = Duration(seconds: 10);
  static const _speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  ChangeNotifier? _videoNotifier;
  Timer? _hideTimer;
  Timer? _hintTimer;

  bool _visible = true;
  bool _dragging = false;
  double _dragMs = 0;
  int _hintSide = 0; // -1 back, 1 forward

  @override
  void initState() {
    super.initState();
    _videoNotifier = widget.player.videoPlayerController;
    _videoNotifier?.addListener(_onTick);
    widget.controller.addListener(_onTick);
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _hintTimer?.cancel();
    _videoNotifier?.removeListener(_onTick);
    widget.controller.removeListener(_onTick);
    super.dispose();
  }

  // ───────── state helpers ─────────

  dynamic get _value => widget.player.videoPlayerController?.value;

  bool get _isPlaying => (_value?.isPlaying as bool?) ?? false;
  bool get _isBuffering => (_value?.isBuffering as bool?) ?? false;
  Duration get _position => (_value?.position as Duration?) ?? Duration.zero;
  Duration get _total => (_value?.duration as Duration?) ?? Duration.zero;

  bool get _ended =>
      _total > Duration.zero &&
      _position >= _total - const Duration(milliseconds: 300) &&
      !_isPlaying;

  Duration get _buffered {
    final ranges = _value?.buffered as List?;
    if (ranges == null || ranges.isEmpty) return Duration.zero;
    return ranges.last.end as Duration;
  }

  void _onTick() {
    if (!mounted) return;
    if (_visible &&
        _isPlaying &&
        !_dragging &&
        !(_hideTimer?.isActive ?? false)) {
      _scheduleHide();
    }
    setState(() {});
  }

  void _scheduleHide() {
    _hideTimer?.cancel();
    _hideTimer = Timer(_hideDelay, () {
      if (mounted && _isPlaying && !_dragging) setState(() => _visible = false);
    });
  }

  void _toggleVisible() {
    setState(() => _visible = !_visible);
    if (_visible) {
      _scheduleHide();
    } else {
      _hideTimer?.cancel();
    }
  }

  Future<void> _togglePlay() async {
    if (_ended) {
      await widget.player.seekTo(Duration.zero);
      await widget.player.play();
      _scheduleHide();
    } else if (_isPlaying) {
      await widget.player.pause();
      _hideTimer?.cancel();
      if (mounted) setState(() => _visible = true);
    } else {
      await widget.player.play();
      _scheduleHide();
    }
  }

  void _seekBy(Duration delta, int side) {
    var target = _position + delta;
    if (target < Duration.zero) target = Duration.zero;
    if (_total > Duration.zero && target > _total) target = _total;
    widget.player.seekTo(target);

    _hintTimer?.cancel();
    setState(() => _hintSide = side);
    _hintTimer = Timer(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _hintSide = 0);
    });
  }

  // ───────── sheets ─────────

  Future<T?> _openSheet<T>({
    required String title,
    required T selected,
    required List<_SheetOption<T>> options,
  }) async {
    _hideTimer?.cancel();
    final theme = Theme.of(context);

    final result = await showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              for (final o in options)
                ListTile(
                  onTap: () => Navigator.of(ctx).pop(o.value),
                  title: Row(
                    children: [
                      Text(
                        o.label,
                        style: TextStyle(
                          fontWeight: o.value == selected
                              ? FontWeight.w800
                              : FontWeight.w500,
                          color: o.value == selected
                              ? theme.colorScheme.primary
                              : null,
                        ),
                      ),
                      if (o.badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.12,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            o.badge!,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  trailing: o.value == selected
                      ? Icon(
                          Icons.check_rounded,
                          color: theme.colorScheme.primary,
                        )
                      : null,
                ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );

    if (mounted && _isPlaying) _scheduleHide();
    return result;
  }

  Future<void> _pickQuality() async {
    final heights = widget.controller.qualityHeights;
    final picked = await _openSheet<int>(
      title: PremiumVideoStrings.quality,
      selected: widget.controller.selectedHeight ?? 0,
      options: [
        _SheetOption(0, PremiumVideoStrings.auto),
        for (final h in heights)
          _SheetOption(h, '${h}p', badge: h >= 720 ? 'HD' : null),
      ],
    );
    if (picked == null) return;
    widget.controller.setQuality(picked == 0 ? null : picked);
  }

  Future<void> _pickSpeed() async {
    final picked = await _openSheet<double>(
      title: PremiumVideoStrings.speed,
      selected: widget.controller.speed,
      options: [
        for (final s in _speeds)
          _SheetOption(s, s == 1.0 ? PremiumVideoStrings.normal : '${s}x'),
      ],
    );
    if (picked != null) widget.controller.setSpeed(picked);
  }

  // ───────── build ─────────

  @override
  Widget build(BuildContext context) {
    final isFull = widget.player.isFullScreen;
    final pad = isFull ? MediaQuery.of(context).padding : EdgeInsets.zero;
    final buffering = _isBuffering && !_ended;

    return Directionality(
      textDirection: TextDirection.ltr, // timeline is always LTR
      child: Stack(
        fit: StackFit.expand,
        children: [
          Row(
            children: [
              Expanded(child: _tapZone(() => _seekBy(-_skip, -1))),
              Expanded(child: _tapZone(() => _seekBy(_skip, 1))),
            ],
          ),
          _buildSkipHint(),
          Positioned.fill(
            child: IgnorePointer(
              ignoring: !_visible,
              child: AnimatedOpacity(
                opacity: _visible ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: _buildOverlay(pad, buffering),
              ),
            ),
          ),
          if (buffering)
            const IgnorePointer(
              child: Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _tapZone(VoidCallback onDouble) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: _toggleVisible,
    onDoubleTap: onDouble,
  );

  Widget _buildSkipHint() {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedOpacity(
          opacity: _hintSide == 0 ? 0 : 1,
          duration: const Duration(milliseconds: 150),
          child: Align(
            alignment: _hintSide < 0
                ? const Alignment(-0.6, 0)
                : const Alignment(0.6, 0),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _hintSide < 0
                    ? Icons.replay_10_rounded
                    : Icons.forward_10_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlay(EdgeInsets pad, bool buffering) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 90,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.65),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 120,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.75),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        if (widget.title != null)
          Positioned(
            top: 10 + pad.top,
            left: 14 + pad.left,
            right: 14 + pad.right,
            child: IgnorePointer(
              child: Text(
                widget.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  shadows: [Shadow(blurRadius: 10, color: Colors.black87)],
                ),
              ),
            ),
          ),
        if (!buffering) Center(child: _buildCenterButton()),
        Positioned(
          left: 12 + pad.left,
          right: 12 + pad.right,
          bottom: 4 + pad.bottom,
          child: _buildBottomBar(),
        ),
      ],
    );
  }

  Widget _buildCenterButton() {
    final icon = _ended
        ? Icons.replay_rounded
        : _isPlaying
        ? Icons.pause_rounded
        : Icons.play_arrow_rounded;

    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      shape: const CircleBorder(side: BorderSide(color: Colors.white24)),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: _togglePlay,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: Colors.white, size: 38),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    final primary = Theme.of(context).colorScheme.primary;
    final totalMs = _total.inMilliseconds.toDouble();
    final max = totalMs <= 0 ? 1.0 : totalMs;
    final posMs = (_dragging ? _dragMs : _position.inMilliseconds.toDouble())
        .clamp(0.0, max);
    final bufMs = _buffered.inMilliseconds.toDouble().clamp(0.0, max);

    final heights = widget.controller.qualityHeights;
    final selected = widget.controller.selectedHeight;
    final speed = widget.controller.speed;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 3,
            activeTrackColor: primary,
            inactiveTrackColor: Colors.white24,
            secondaryActiveTrackColor: Colors.white38,
            thumbColor: primary,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
            overlayColor: primary.withValues(alpha: 0.2),
          ),
          child: Slider(
            value: posMs,
            max: max,
            secondaryTrackValue: bufMs,
            onChangeStart: (_) {
              _hideTimer?.cancel();
              setState(() => _dragging = true);
            },
            onChanged: (v) => setState(() => _dragMs = v),
            onChangeEnd: (v) async {
              await widget.player.seekTo(Duration(milliseconds: v.round()));
              if (!mounted) return;
              setState(() => _dragging = false);
              if (_isPlaying) _scheduleHide();
            },
          ),
        ),
        Row(
          children: [
            Text(
              '${_fmt(Duration(milliseconds: posMs.round()))} / ${_fmt(_total)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            _pill(
              label: speed == 1.0 ? '1x' : '${speed}x',
              icon: Icons.speed_rounded,
              onTap: _pickSpeed,
            ),
            if (heights.isNotEmpty) ...[
              const SizedBox(width: 8),
              _pill(
                label: selected == null
                    ? PremiumVideoStrings.auto
                    : '${selected}p',
                icon: Icons.high_quality_rounded,
                onTap: _pickQuality,
              ),
            ],
            const SizedBox(width: 4),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () {
                widget.player.toggleFullScreen();
                _scheduleHide();
              },
              icon: Icon(
                widget.player.isFullScreen
                    ? Icons.fullscreen_exit_rounded
                    : Icons.fullscreen_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _pill({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.black.withValues(alpha: 0.45),
      shape: const StadiumBorder(side: BorderSide(color: Colors.white24)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _fmt(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    return h > 0 ? '$h:${two(m)}:${two(s)}' : '${two(m)}:${two(s)}';
  }
}

class _SheetOption<T> {
  final T value;
  final String label;
  final String? badge;
  const _SheetOption(this.value, this.label, {this.badge});
}
