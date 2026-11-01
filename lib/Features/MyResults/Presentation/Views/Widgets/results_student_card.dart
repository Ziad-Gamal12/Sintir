import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_active_badge.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_date_formatter.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_tokens.dart';
import 'package:sintir/locale_keys.dart';

class ResultsStudentCard extends StatelessWidget {
  const ResultsStudentCard(
      {super.key, required this.result, required this.isActive});
  final TestResultEntity result;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = AppTextStyles(context);
    final name = LocaleKeys.resultsStudentName(result.joinedbyentity.name);
    final tokens = ResultsTokens.of(theme);
    return Padding(
      padding: const EdgeInsetsDirectional.all(16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsetsDirectional.all(2.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Container(
            padding: const EdgeInsetsDirectional.all(3),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: tokens.card),
            child: CircleAvatar(
              radius: 22.5,
              backgroundColor: tokens.inner,
              child: ClipOval(
                child: result.joinedbyentity.imageUrl.isEmpty
                    ? Icon(Icons.person_rounded, color: tokens.muted)
                    : CachedNetworkImage(
                        imageUrl: result.joinedbyentity.imageUrl,
                        width: 45,
                        height: 45,
                        memCacheWidth: 120,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Icon(Icons.person_rounded, color: tokens.muted),
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 4,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 220),
                  child: Text(name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: style.semiBold16
                          .copyWith(color: theme.colorScheme.onSurface)),
                ),
                if (isActive) const ResultsActiveBadge(),
              ],
            ),
            const SizedBox(height: 8),
            Row(children: [
              Icon(Icons.calendar_month_rounded, size: 16, color: tokens.muted),
              const SizedBox(width: 5),
              Expanded(
                  child: Text(
                      LocaleKeys.resultsJoined(ResultsDateFormatter.format(
                          context, result.joinedbyentity.joinedDate)),
                      style: style.regular12.copyWith(color: tokens.muted))),
            ]),
          ]),
        ),
      ]),
    );
  }
}
