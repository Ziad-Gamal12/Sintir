import 'dart:async';

import 'package:flutter/material.dart';

class ResultsTimelineEntry extends StatefulWidget {
  const ResultsTimelineEntry(
      {super.key, required this.index, required this.child});
  final int index;
  final Widget child;

  @override
  State<ResultsTimelineEntry> createState() => _ResultsTimelineEntryState();
}

class _ResultsTimelineEntryState extends State<ResultsTimelineEntry>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  Timer? _staggerTimer;
  bool _staggerStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(begin: const Offset(0, .035), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    if (widget.index >= 6) {
      _controller.value = 1;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else if (widget.index < 6 && !_staggerStarted) {
      _staggerStarted = true;
      _staggerTimer = Timer(Duration(milliseconds: widget.index * 50), () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _staggerTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child));
}
