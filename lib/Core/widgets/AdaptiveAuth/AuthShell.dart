// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Themes/brand_palette.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthBrandPanel.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthHeader.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthParts.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/constant.dart';
import 'package:svg_flutter/svg.dart';

class AuthShell extends StatefulWidget {
  const AuthShell({
    super.key,
    required this.title,
    required this.brand,
    required this.child,
    this.illustration,
    this.brandIllustration,
    this.headline,
    this.subtitle,
    this.badge,
    this.contentMaxWidth = 440,
    this.cardMaxWidth = 520,
    this.onBack,
  });

  final String title;
  final AuthBrandContent brand;
  final Widget child;
  final String? illustration;
  final String? brandIllustration;
  final Widget? headline;
  final String? subtitle;
  final Widget? badge;
  final double contentMaxWidth;
  final double cardMaxWidth;
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

  String? get _stageIllustration =>
      widget.brandIllustration ?? widget.illustration;

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
          WindowSize.large ||
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

  Widget _formHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.badge != null) ...[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: widget.badge!,
          ),
          const SizedBox(height: 20),
        ],
        AuthHeader(
          headline: widget.headline ??
              Text(widget.title, style: AppTextStyles(context).bold24),
          subtitle: widget.subtitle,
          centered: false,
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildCentered(BuildContext context, Widget content) {
    final palette = BrandPalette.of(context);
    final stageHeight =
        (MediaQuery.sizeOf(context).height * 0.25).clamp(160.0, 280.0).toDouble();
    final stageIllustration = _stageIllustration;

    return Scaffold(
      backgroundColor: palette.page,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(40, 24, 40, 40),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: widget.cardMaxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      AuthBackButton(onPressed: _back),
                      const Spacer(),
                      SintirWordmark(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  if (stageIllustration != null) ...[
                    SizedBox(
                      height: stageHeight,
                      child: AuthIllustrationStage(
                        child: SvgPicture.asset(
                          stageIllustration,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                  _formHeader(context),
                  content,
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
    final palette = BrandPalette.of(context);
    final brandWidth = AuthBrandPanel.widthFor(constraints.maxWidth);
    final paneWidth = constraints.maxWidth - brandWidth;
    final panePadding = paneWidth >= 640 ? 64.0 : 32.0;

    return Scaffold(
      backgroundColor: palette.page,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: brandWidth,
            child: AuthBrandPanel(
              content: widget.brand,
              illustration: _stageIllustration,
            ),
          ),
          Expanded(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      panePadding,
                      24,
                      panePadding,
                      0,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: AuthBackButton(onPressed: _back),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: panePadding,
                          vertical: 32,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: widget.contentMaxWidth,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _formHeader(context),
                              content,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
