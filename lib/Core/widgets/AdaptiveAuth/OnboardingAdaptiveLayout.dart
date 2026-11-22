// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/Themes/brand_palette.dart';
import 'package:sintir/Core/entities/Customonboardingpageviewentity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthBrandPanel.dart';
import 'package:sintir/Core/widgets/AdaptiveAuth/AuthParts.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class OnboardingAdaptiveLayout extends StatelessWidget {
  const OnboardingAdaptiveLayout({
    super.key,
    required this.pages,
    required this.pageView,
    required this.currentPageNotifier,
    required this.pageController,
    required this.badge,
    required this.onFinish,
    required this.stacked,
  });

  final List<CustomOnBoardingPageViewEntity> pages;
  final Widget pageView;
  final ValueNotifier<int> currentPageNotifier;
  final PageController pageController;
  final Widget badge;
  final VoidCallback onFinish;
  final bool stacked;

  static const Duration _pageDuration = Duration(milliseconds: 500);

  bool get _isLast => currentPageNotifier.value >= pages.length - 1;

  void _next() {
    if (_isLast) {
      onFinish();
    } else {
      pageController.nextPage(duration: _pageDuration, curve: Curves.easeIn);
    }
  }

  void _previous() {
    if (currentPageNotifier.value > 0) {
      pageController.previousPage(
        duration: _pageDuration,
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final forward =
        isRtl ? LogicalKeyboardKey.arrowLeft : LogicalKeyboardKey.arrowRight;
    final backward =
        isRtl ? LogicalKeyboardKey.arrowRight : LogicalKeyboardKey.arrowLeft;

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        SingleActivator(forward): _next,
        SingleActivator(backward): _previous,
      },
      child: ColoredBox(
        color: BrandPalette.of(context).page,
        child: stacked ? _buildStacked(context) : _buildSplit(context),
      ),
    );
  }

  Widget _buildSplit(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final brandWidth = AuthBrandPanel.widthFor(constraints.maxWidth);
        final paneWidth = constraints.maxWidth - brandWidth;
        final panePadding = paneWidth >= 640 ? 64.0 : 32.0;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: brandWidth,
              child: AuthBrandPanel(stage: pageView),
            ),
            Expanded(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(panePadding, 24, panePadding, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _TopBar(
                        pagesCount: pages.length,
                        currentPageNotifier: currentPageNotifier,
                        onSkip: onFinish,
                      ),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 560),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _Copy(
                                    pages: pages,
                                    currentPageNotifier: currentPageNotifier,
                                    badge: badge,
                                  ),
                                  const SizedBox(height: 40),
                                  _Controls(
                                    pagesCount: pages.length,
                                    currentPageNotifier: currentPageNotifier,
                                    onNext: _next,
                                    onPrevious: _previous,
                                  ),
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
            ),
          ],
        );
      },
    );
  }

  Widget _buildStacked(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(48, 24, 48, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TopBar(
              pagesCount: pages.length,
              currentPageNotifier: currentPageNotifier,
              onSkip: onFinish,
              showWordmark: true,
            ),
            const SizedBox(height: 24),
            Expanded(
              flex: 5,
              child: AuthIllustrationStage(
                padding: const EdgeInsets.all(40),
                child: pageView,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              flex: 3,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: _Copy(
                      pages: pages,
                      currentPageNotifier: currentPageNotifier,
                      badge: badge,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _Controls(
              pagesCount: pages.length,
              currentPageNotifier: currentPageNotifier,
              onNext: _next,
              onPrevious: _previous,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.pagesCount,
    required this.currentPageNotifier,
    required this.onSkip,
    this.showWordmark = false,
  });

  final int pagesCount;
  final ValueNotifier<int> currentPageNotifier;
  final VoidCallback onSkip;
  final bool showWordmark;

  @override
  Widget build(BuildContext context) {
    final palette = BrandPalette.of(context);

    return SizedBox(
      height: 44,
      child: ValueListenableBuilder<int>(
        valueListenable: currentPageNotifier,
        builder: (context, index, _) {
          final isLast = index >= pagesCount - 1;
          return Row(
            spacing: 16,
            children: [
              if (showWordmark)
                SintirWordmark(color: Theme.of(context).colorScheme.onSurface),
              Text(
                '${index + 1} / $pagesCount',
                textDirection: TextDirection.ltr,
                style: AppTextStyles(context)
                    .bold14
                    .copyWith(color: palette.textMuted),
              ),
              const Spacer(),
              if (!isLast)
                TextButton(
                  onPressed: onSkip,
                  style: TextButton.styleFrom(
                    foregroundColor: palette.link,
                    minimumSize: const Size(64, 44),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Text(
                    LocaleKeys.completeProfileSkip,
                    style: AppTextStyles(context).bold14,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Copy extends StatelessWidget {
  const _Copy({
    required this.pages,
    required this.currentPageNotifier,
    required this.badge,
  });

  final List<CustomOnBoardingPageViewEntity> pages;
  final ValueNotifier<int> currentPageNotifier;
  final Widget badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = BrandPalette.of(context);
    final styles = AppTextStyles(context);

    return ValueListenableBuilder<int>(
      valueListenable: currentPageNotifier,
      builder: (context, index, _) {
        final page = pages[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            badge,
            const SizedBox(height: 20),
            DefaultTextStyle.merge(
              style: styles.bold24.copyWith(
                color: theme.colorScheme.onSurface,
                height: 1.4,
              ),
              child: page.title,
            ),
            const SizedBox(height: 16),
            Text(
              page.description,
              style: styles.regular14.copyWith(
                color: palette.textMuted,
                height: 1.8,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({
    required this.pagesCount,
    required this.currentPageNotifier,
    required this.onNext,
    required this.onPrevious,
  });

  final int pagesCount;
  final ValueNotifier<int> currentPageNotifier;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  Widget build(BuildContext context) {
    final palette = BrandPalette.of(context);
    final styles = AppTextStyles(context);
    final localizations = MaterialLocalizations.of(context);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return ValueListenableBuilder<int>(
      valueListenable: currentPageNotifier,
      builder: (context, index, _) {
        final isLast = index >= pagesCount - 1;
        return Row(
          children: [
            OnboardingDots(count: pagesCount, index: index),
            const Spacer(),
            if (index > 0) ...[
              OutlinedButton.icon(
                key: const ValueKey('onboarding-previous'),
                onPressed: onPrevious,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 48),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  side: BorderSide(color: palette.outline),
                  shape: shape,
                ),
                icon: const Icon(Icons.arrow_back_rounded, size: 20),
                label: Text(
                  localizations.backButtonTooltip,
                  style: styles.semiBold14,
                ),
              ),
              const SizedBox(width: 12),
            ],
            FilledButton(
              key: const ValueKey('onboarding-next'),
              autofocus: true,
              onPressed: onNext,
              style: FilledButton.styleFrom(
                minimumSize: const Size(152, 48),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                backgroundColor: KMainColor,
                foregroundColor: Colors.white,
                shape: shape,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Text(
                    isLast
                        ? LocaleKeys.login
                        : localizations.continueButtonLabel,
                    style: styles.bold16.copyWith(color: Colors.white),
                  ),
                  const Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
