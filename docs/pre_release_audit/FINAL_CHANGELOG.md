# Final audit changelog

## Baseline commits

- Mobile repository: `6089602 chore: checkpoint existing changes before final pre-release audit`.
- Dashboard repository: `87ec7e4 chore: checkpoint existing changes before final pre-release audit`.
- No remote push.
- The dashboard repository and Supabase functions were present beside the mobile repository; the previous audit’s “dashboard unavailable” finding is superseded. Live Firebase/Supabase/Paymob configuration remains unavailable.

## New audit changes

- `lib/Core/services/HiveService.dart`: added single-key deletion.
- `lib/Core/services/FireBase/FirebaseAuth_Service.dart`: clear cached `UserData` in sign-out `finally`.
- `android/app/build.gradle.kts`: environment-only release signing; no debug fallback.
- `android/app/src/main/AndroidManifest.xml`: explicit backup enabled and targeted backup rules references.
- `android/app/src/main/res/xml/backup_rules.xml`, `data_extraction_rules.xml`: exclude the encrypted Hive box and Flutter Secure Storage files for cloud/device transfer.
- Dashboard `lib/Core/Services/DioService.dart`: request/response body logging only in debug builds.
- Dashboard `lib/main.dart`: use Supabase `publishableKey` parameter rather than deprecated `anonKey` parameter.
- Dashboard `supabase/functions/_shared/video.ts`: let playback reach student enrollment check; enforce active role/ownership/entitlement in playback policy.
- Dashboard `supabase/functions/_shared/video_access_test.ts`: three playback authorization tests.
- Dashboard `supabase/functions/_shared/paymob.ts`: require explicit allowlisted payout origin; validate credentials.
- Dashboard `supabase/functions/teacher-withdrawal/index.ts`: reject unconfigured payout service before balance reservation.
- Dashboard `supabase/functions/_shared/withdrawal_logic_test.ts`: payout origin tests.
- Removed dashboard `test/widget_test.dart`, a confirmed stale Flutter starter counter test.
- Added reports under `docs/pre_release_audit/`.
- Removed 19 individually reviewed, unreferenced Dart candidates; retained the two directly used widgets, three overlay widgets used transitively, and the Flutter Intl generated file.
- Removed the direct `expansion_widget` dependency and removed four unnecessary direct dependency declarations (`cli_util`, `flutter_secure_storage_darwin`, `material_color_utilities`, `test_api`). Pub retained the latter four transitively and refreshed `pubspec.lock` without package upgrades.

## Validation and not done

Mobile 77 tests, dashboard 3 tests, and Deno 32 tests pass; all 12 Edge Functions type-check. Mobile analysis reports 755 findings, dashboard targeted analysis passes, and dashboard web release build passes. The Android AAB built successfully on retry with obfuscation and split Dart symbols; it is unsigned and not store-ready. No iOS archive, local emulator, live service test, deployment, production data change, financial transaction, or media deletion was performed.

No runtime package upgrade, asset deletion, schema change, SQL migration, Firebase rule change, or production secret edit was made.
