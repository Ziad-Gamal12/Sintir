// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sintir/Core/Themes/brand_palette.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

/// An optional image of a question: an outlined button until one is picked,
/// then a fixed-height preview with change and remove actions.
class ExamQuestionImageTile extends StatelessWidget {
  const ExamQuestionImageTile({
    super.key,
    required this.label,
    required this.file,
    required this.isLoading,
    required this.onPick,
    required this.onRemove,
  });

  final String label;
  final File? file;
  final bool isLoading;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  static const double previewHeight = 180;
  static final BorderRadius _radius = BorderRadius.circular(14);

  @override
  Widget build(BuildContext context) {
    final picked = file;
    return picked == null
        ? _buildPlaceholder(context)
        : _buildPreview(context, picked);
  }

  Widget _buildPlaceholder(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final color = BrandPalette.of(context).link;

    // Its own Material so the ink shows above the card's background.
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: isLoading ? null : onPick,
        borderRadius: _radius,
        child: Ink(
          decoration: BoxDecoration(
            color: tokens.neutralBackground,
            borderRadius: _radius,
            border: Border.all(color: tokens.cardBorder),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 88),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Center(
                child: isLoading
                    ? const SizedBox.square(
                        dimension: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            color: color,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              label,
                              textAlign: TextAlign.center,
                              style: AppTextStyles(
                                context,
                              ).semiBold14.copyWith(color: color),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreview(BuildContext context, File picked) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final dpr = MediaQuery.devicePixelRatioOf(context);

    return ClipRRect(
      borderRadius: _radius,
      child: SizedBox(
        height: previewHeight,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: tokens.neutralBackground),
            LayoutBuilder(
              builder: (context, constraints) => Image.file(
                picked,
                fit: BoxFit.cover,
                // Decode at preview size: every card stays mounted, so
                // full-resolution photos would add up quickly.
                cacheWidth: constraints.maxWidth.isFinite
                    ? (constraints.maxWidth * dpr).round()
                    : null,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image_outlined,
                  color: tokens.mutedText,
                  size: 32,
                ),
              ),
            ),
            PositionedDirectional(
              start: 0,
              end: 0,
              bottom: 0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xB3000000), Color(0x00000000)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 16, 4, 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles(
                            context,
                          ).semiBold13.copyWith(color: Colors.white),
                        ),
                      ),
                      _PreviewAction(
                        icon: Icons.edit_outlined,
                        tooltip: LocaleKeys.changeImage,
                        onPressed: isLoading ? null : onPick,
                      ),
                      _PreviewAction(
                        icon: Icons.delete_outline_rounded,
                        tooltip: LocaleKeys.removeImage,
                        onPressed: isLoading ? null : onRemove,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading)
              const ColoredBox(
                color: Color(0x61000000),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PreviewAction extends StatelessWidget {
  const _PreviewAction({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      color: Colors.white,
      icon: Icon(icon, size: 20),
    );
  }
}
