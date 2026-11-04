# Code cleanup report

## Candidate review

The four asset candidates and all 25 Dart candidates in section 14 of the request were checked against pubspec assets, imports/exports, symbols, routes, dependency injection, widget parents, tests, generated-code configuration, and dynamic localization loading.

### Assets

| Candidate | Status | Evidence / action |
|---|---|---|
| `assets/l10n/en.json` | Dynamically referenced; kept | Declared under `flutter.assets`; Localingo loads `assets/l10n/${locale.languageCode}.json` through `rootBundle`. |
| `assets/l10n/ar.json` | Dynamically referenced; kept | Same runtime loader; Arabic locale is supported. |
| `assets/l10n/fr.json` | Dynamically referenced; kept | Same runtime loader; French locale is supported. |
| `lib/generated/l10n.dart` | Generated; kept | Flutter Intl generation remains enabled in `pubspec.yaml`. The current app uses its `AppLocalizations` delegate, not this file's `S` delegate; retain the generated artifact until the generator setup is intentionally retired. |

No asset was removed.

### Dependencies

| Candidate | Status | Action |
|---|---|---|
| `cli_util` | Unused as a direct app dependency; still transitive | Removed from `pubspec.yaml`; retained transitively in `pubspec.lock` through another package. |
| `expansion_widget` | Confirmed unused | Removed from `pubspec.yaml` and the resolved lock graph; no source imports or symbols. |
| `flutter_secure_storage_darwin` | Required transitively | Removed its direct declaration; Pub retains it transitively for the federated secure-storage plugin. |
| `material_color_utilities` | Required transitively | Removed its direct declaration; Pub retains it transitively. |
| `test_api` | Required transitively | Removed its direct runtime declaration; Pub retains it transitively for the Flutter test stack. |

`flutter pub get --offline` succeeded. No package version was upgraded; four packages moved from direct to transitive and `expansion_widget` left the graph.

### Dart files

| # | Candidate | Status / action |
|---:|---|---|
| 1 | `lib/generated/l10n.dart` | Generated; kept, as described above. |
| 2 | `TeacherWalletDetailsViewWidgets/teacher_wallet_balance_details_card.dart` | Confirmed unused; removed. No import or constructor use found. |
| 3 | `TeacherWalletDetailsViewWidgets/teacher_wallet_balance_details_bottom.dart` | Confirmed unused; removed. No import or constructor use found. |
| 4 | `TeacherWalletDetailsViewWidgets/ExpandableWalletDetailsWidgets/WalletDetailStatusValue .dart` | Confirmed unused; removed. No import or constructor use found. |
| 5 | `SubscriberDetails/widgets/SubscriberPerformanceStatCard.dart` | Confirmed unused; removed. No import or constructor use found. |
| 6 | `SubscriberDetails/widgets/SubscriberLowestScoreCard.dart` | Confirmed unused; removed. No import or constructor use found. |
| 7 | `SubscriberDetails/widgets/SubscriberHighestScoreCard.dart` | Confirmed unused; removed. No import or constructor use found. |
| 8 | `SubscriberDetails/widgets/SubscriberEnrolledDisplayedCoursesListView.dart` | Confirmed unused; removed. No import or constructor use found. |
| 9 | `SubscriberDetails/widgets/SubscriberEnrolledCoursesListViewLoading.dart` | Confirmed unused; removed. No import or constructor use found. |
| 10 | `SubscriberDetails/widgets/SubscriberAverageScoreCard.dart` | Confirmed unused; removed. No import or constructor use found. |
| 11 | `CourseDetailsSubscribersGridviewItemSchoolLevel.dart` | Confirmed unused; removed. No import or constructor use found. |
| 12 | `CourseDetailsCourseInfoSectionWidgets/CustomCourseDetailsBodyCourse_Info.dart` | Confirmed unused; removed. Its separately referenced info card remains. |
| 13 | `AddExamWidgets/ReviewExamWidgets/CustomReviewExamButtonAction.dart` | Confirmed unused; removed. No import or constructor use found. |
| 14 | `AddExamWidgets/CustomAddExamStepsRowItem.dart` | Confirmed unused; removed. The shared row entity and its used sibling remain. |
| 15 | `AddCourseSectionVedio/AddcoursesectionvedioviewBody.dart` | Confirmed used; kept. `AddCourseSectionVedioView.dart` imports and constructs it. |
| 16 | `data/Repos/TeacherWalletRepoImpl.dart` | Confirmed unused; removed. No DI registration or reference to the implementation was found. |
| 17 | `MyTransactions/Presentation/Views/Widgets/MyTransactionListView.dart` | Confirmed unused; removed. No import or constructor use found. |
| 18 | `MyResults/Presentation/Views/Widgets/results_app_bar.dart` | Confirmed unused; removed. No import or constructor use found. |
| 19 | `ReviewTestResultWidgets/CustomSolvedQuestionListItemQuestionTitle .dart` | Confirmed used; kept. `CustomSolvedQuestionListItem.dart` imports and constructs it. |
| 20 | `Overlay Container Widget.dart` | Confirmed used; kept. `CustomUnAvilableSectionWidget.dart` constructs `OverlayContainer`. |
| 21 | `Lock Message Widget.dart` | Confirmed used; kept through `OverlayContainer`. |
| 22 | `Lock Icon Widget.dart` | Confirmed used; kept through `LockMessage`. |
| 23 | `Core/services/FireBase/firebaseStorageService.dart` | Confirmed unused; removed. Entire implementation was commented out. |
| 24 | `Core/repos/TeacherTranscationsRepo/TeacherTranscationsRepoImpl.dart` | Confirmed unused; removed. No DI registration or reference to the implementation was found. |
| 25 | `Core/Enums/TransactionType.dart` | Confirmed unused; removed. No enum references were found. |

Nineteen Dart files were removed. The mobile suite passed all 77 tests after the removals and dependency resolution.

## Other cleanup

- Removed dashboard `test/widget_test.dart`, a stock Flutter counter smoke test that failed because the dashboard has no counter UI; three authorization tests pass.
- Dashboard Dio request/response body logging is debug-only.
- Dashboard Supabase initialization uses `publishableKey`.
- Kept all 91 mobile assets, localization, generated files, and native/plugin registrations not specifically established as unused.
- Kept Android Facebook SDK `latest.release` and the `image_picker_android` override pending compatibility verification.
- README SDK guidance remains stale relative to mobile `pubspec.yaml` (Dart `^3.10.0`, Flutter `>=3.38.1`).

No database tables, permissions, production data, or runtime-required packages were deleted.
