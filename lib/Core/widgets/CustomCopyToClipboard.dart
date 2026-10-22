import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomCopyToClipboard extends StatefulWidget {
  const CustomCopyToClipboard({
    super.key,
    required this.value,
  });

  final String value;

  @override
  State<CustomCopyToClipboard> createState() => _CustomCopyToClipboardState();
}

class _CustomCopyToClipboardState extends State<CustomCopyToClipboard> {
  bool _copied = false;

  Future<void> _copyToClipboard() async {
    try {
      await Clipboard.setData(
        ClipboardData(text: widget.value),
      );

      if (!mounted) return;

      setState(() => _copied = true);

      await Future.delayed(
        const Duration(milliseconds: 1500),
      );

      if (!mounted) return;

      setState(() => _copied = false);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to copy text'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      tooltip: _copied ? 'Copied!' : 'Copy to clipboard',
      onPressed: _copied ? null : _copyToClipboard,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeOutBack,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: Icon(
          _copied ? Icons.check_rounded : Icons.copy_rounded,
          key: ValueKey<bool>(_copied),
          size: 15,
          color: _copied
              ? Colors.green
              : isDarkMode
                  ? Colors.white
                  : Colors.black,
        ),
      ),
    );
  }
}
