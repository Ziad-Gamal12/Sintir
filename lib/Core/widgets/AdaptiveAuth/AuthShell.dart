// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthBrandPanel.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthHeader.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/constant.dart';

/// Adaptive page frame shared by the sign-in / sign-up screens.
///
/// * compact  (< 600):  app bar + one scrolling column (the phone layout).
/// * medium   (600–839): app bar + the form in a centred card, max [cardMaxWidth].
/// * expanded (≥ 840):  split — [AuthBrandPanel] on the start side, the form on
///   the end side, max [contentMaxWidth].
///
/// [child] is the form only: no Scaffold, padding or scroll view. It is kept
/// under a [GlobalKey], so typed text and validation state survive a rotation
/// that switches the layout.
class AuthShell extends StatefulWidget {
  const AuthShell({
    super.key,
    required this.title,
    required this.brand,
    required this.child,
    this.illustration,
    this.headline,
    this.subtitle,
    this.badge,
    this.contentMaxWidth = 440,
    this.cardMaxWidth = 520,
    this.brandWidthFactor = 0.42,
    this.onBack,
  });

  /// App bar title (compact / medium); the form-pane title when [headline] is null.
  final String title;
  final AuthBrandContent brand;
  final Widget child;
  final String? illustration;
  final Widget? headline;
  final String? subtitle;
  final Widget? badge;
  final double contentMaxWidth;
  final double cardMaxWidth;
  final double brandWidthFactor;
  final VoidCallback? onBack;

  @override
  State<AuthShell> createState() => _AuthShellState();
}

class _AuthShellState extends State<AuthShell> {
  final GlobalKey _contentKey = GlobalKey();

  bool get _hasHeader =>
      widget.illustration != null ||
      widget.headline != null ||
      widget.subtitle != null;

  void _back() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else {
      GoRouter.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = KeyedSubtree(key: _contentKey, child: widget.child);

    return LayoutBuilder(
      builder: (context, constraints) {
        return switch (Breakpoints.of(constraints.maxWidth)) {
          WindowSize.expanded => _buildSplit(context, constraints, content),
          WindowSize.medium => _buildCentered(context, content),
          WindowSize.compact => _buildCompact(context, content),
        };
      },
    );
  }

  Widget _buildCompact(BuildContext context, Widget content) {
    return Scaffold(
      appBar: CustomAppBar(
        appBartitle: widget.title,
        onBackPressed: widget.onBack,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding,
            vertical: KVerticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_hasHeader) ...[
                AuthHeader(
                  illustration: widget.illustration,
                  illustrationMaxHeight: 150,
                  headline: widget.headline,
                  subtitle: widget.subtitle,
                ),
                const SizedBox(height: 32),
              ],
              content,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCentered(BuildContext context, Widget content) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final background =
        isDark ? theme.scaffoldBackgroundColor : const Color(0xFFF4F6FB);

    return Scaffold(
      backgroundColor: background,
      appBar: CustomAppBar(
        appBartitle: widget.title,
        onBackPressed: widget.onBack,
        backgroundColor: background,
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(40, 16, 40, 40),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: widget.cardMaxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_hasHeader) ...[
                    AuthHeader(
                      illustration: widget.illustration,
                      illustrationMaxHeight: 220,
                      headline: widget.headline,
                      subtitle: widget.subtitle,
                    ),
                    const SizedBox(height: 28),
                  ],
                  _AuthCard(child: content),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSplit(
    BuildContext context,
    BoxConstraints constraints,
    Widget content,
  ) {
    final brandWidth =
        (constraints.maxWidth * widget.brandWidthFactor)
            .clamp(340.0, 560.0)
            .toDouble();
    final paneWidth = constraints.maxWidth - brandWidth;
    final panePadding = paneWidth >= 640 ? 56.0 : 32.0;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: brandWidth,
            child: AuthBrandPanel(
              content: widget.brand,
              illustration: widget.illustration,
              onBack: _back,
            ),
          ),
          Expanded(
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: panePadding,
                    vertical: 40,
                  ),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: widget.contentMaxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.badge != null) ...[
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: widget.badge!,
                          ),
                          const SizedBox(height: 16),
                        ],
                        AuthHeader(
                          headline: widget.headline ??
                              Text(
                                widget.title,
                                style: AppTextStyles(context).bold24,
                              ),
                          subtitle: widget.subtitle,
                          centered: false,
                        ),
                        const SizedBox(height: 28),
                        content,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthCard extends StatelessWidget {
  const _AuthCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white10 : const Color(0xFFE9ECF2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? .25 : .05),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
