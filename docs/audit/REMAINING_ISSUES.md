# SINTIR Remaining Issues

Audit date: 2026-11-03.

| Priority | Issue | Location | Required action |
|---|---|---|---|
| P1 | Release uses debug signing. | android/app/build.gradle.kts | Configure organization-managed release signing in protected CI and verify update identity. |
| P1 | Deployed Firebase Firestore/Storage rules unavailable. | Backend project | Obtain deployed rules/source and test with emulator; firestore.rules.proposed is not configured as active. |
| P1 | Supabase RLS/storage policies, Edge Functions, Paymob webhooks/reconciliation, payout, and Mux signing unavailable. | Backend project | Review deployed code/config and test ownership, amount authority, idempotency, fulfillment, balances, and playback access in isolated environments. |
| P1 | Dashboard source unavailable. | Companion repo referenced in README | Audit auth, roles, browser storage, XSS/CSP/CORS, and production build separately. |
| P2 | Checkout WebView lacks explicit HTTPS/origin policy. | lib/Core/widgets/WebViewer/WebViewBody.dart | Obtain Paymob/3DS redirect host contract; enforce HTTPS and compatible allowlist. |
| P2 | User profile cache survives logout. | lib/Core/widgets/LogOutDialog.dart; Hive | Inventory persisted user state and add logout/account-switch cleanup tests. |
| P2 | No GoRouter session/role redirect. | lib/Core/utils/App_router.dart | Verify backend permissions first; decide if UX route guards are needed and test transitions. |
| P2 | Whole-project analyzer reports 785 issues. | Repository | Retain machine-readable severity breakdown and fix errors/warnings in tested feature groups. |
| P2 | Android release build did not finish. | Android/Gradle | Re-run where Gradle dependencies are available; inspect task output, Kotlin plugin migration, and signing. |
| P2 | Runtime-generated endpoints not verified as HTTPS. | Checkout/media/upload/file endpoints | Check staging URLs on both platforms after removing global transport exceptions. |
| P2 | 38 French and 3 Arabic values equal English. | assets/l10n/*.json | Fluent reviewer should classify intentional names/units and translate remaining text. |
| P2 | Theme, RTL, and accessibility not comprehensively rendered. | All screens | Run device matrix for themes, Arabic RTL, large text, keyboard/safe areas, and semantics. |
| P2 | No measured performance baseline. | Startup/lists/video/images | Profile representative devices and preserve traces before optimization. |
| P3 | Dynamic Gradle dependency version. | android/app/build.gradle.kts | Pin a Facebook SDK version supported by flutter_facebook_auth after compatibility verification. |
| P3 | README SDK guidance is stale. | README.md | Align setup requirements with Dart ^3.10.0 and Flutter >=3.38.1. |
| P3 | Duplicate INTERNET and Bluetooth/audio permissions need mapping. | android/app/src/main/AndroidManifest.xml | Map to active features/plugins and callback behavior before removing permissions. |
