# SINTIR Baseline Audit

Date: 2026-11-02  
Scope: Accessible checkout at branch `test`, commit `1fdf553` (`transactions view Ui completed`). This is the baseline before audit fixes.

## Repository state and scope

- The working tree already contained edits in `android/app/src/main/kotlin/com/example/sintir/MainActivity.kt`, `macos/Flutter/GeneratedPluginRegistrant.swift`, `windows/flutter/generated_plugin_registrant.cc`, and `windows/flutter/generated_plugins.cmake`. These are pre-existing and were preserved.
- The repository contains a Flutter application (`lib/`, 1,144 Dart files), 18 feature modules, native Android/iOS and desktop scaffolding, 19 existing tests, 91 assets, and localization resources. No `AGENTS.md` was present in the accessible workspace.
- No dashboard source, Supabase Edge Function source, Supabase migrations/policies, Firebase Storage rules, Firebase Emulator setup, or configured/deployed Firestore rules file was found. `firestore.rules.proposed` is present, but `firebase.json` only records FlutterFire app metadata and does not configure it for deployment. The dashboard and backend authorization cannot be independently audited from this checkout.
- The README describes a companion dashboard and backend functions but is not evidence that those implementations are present or deployed. A remote dashboard URL is documented, but it was not treated as audited.
- `.env` is ignored and is not tracked by Git. `lib/constant.dart` is also ignored; it contains a Supabase publishable key reference (not printed here). Firebase client configuration is present. No secret values are reproduced in this report.

## Architecture map

```text
main.dart
  ├─ initializes Firebase, Supabase, SharedPreferences, Hive, HydratedBloc
  ├─ registers shared repositories/services through get_it
  └─ installs global cubits and GoRouter in MaterialApp.router

lib/Core
  ├─ services: Firebase Auth/Firestore, Supabase Storage, video upload, Paymob, Hive
  ├─ repos: shared repository interfaces/implementations, including checkout gateway
  ├─ Managers/Cubits: cross-feature state and checkout orchestration
  ├─ utils/App_router.dart: navigation
  ├─ Themes and localization helpers
  └─ reusable widgets and wrappers

lib/Features/<feature>
  ├─ Presentation: views, widgets, Cubits/Blocs
  ├─ Domain: entities and repository contracts (consistency varies)
  └─ Data: models and repository implementations (consistency varies)

External dependencies
  ├─ Firebase Auth + Firestore
  ├─ Supabase Storage + Edge Functions (clients invoke functions; server source absent)
  ├─ Paymob through server-side checkout function calls (function source absent)
  └─ Android/iOS and Flutter plugin integrations
```

The feature-first organization is recognizable, but it is not uniformly Clean Architecture: shared services and repositories coexist with feature-local data/domain layers, and some view/state modules access Firebase directly. The codebase includes many Dart files and large presentation trees, so safe unused-code deletion requires symbol-level and runtime-reference analysis beyond filename searches. No files or assets were removed at baseline.

## Verified baseline findings

| Priority | Finding and evidence | Impact / status |
|---|---|---|
| P1 | Android `android/app/src/main/AndroidManifest.xml` sets `android:usesCleartextTraffic="true"`; iOS `ios/Runner/Info.plist` sets `NSAppTransportSecurity/NSAllowsArbitraryLoads` to true. | Platform transport protections are disabled globally. Application literals searched in `lib/` do not show an intentional `http://` service URL; runtime-generated/backend URLs still need validation. Fix candidate after confirming build/runtime assumptions. |
| P1 | Android release build in `android/app/build.gradle.kts` explicitly uses `signingConfigs.getByName("debug")`. | A release artifact built from this configuration is signed with a debug key and is not suitable for store release/update identity. A production signing key/config is intentionally unavailable; do not invent or alter credentials. |
| P1 | Checkout, video playback/upload, and payout clients call authenticated Supabase Edge Functions, but function code and deployment policies are absent. | Client code cannot establish server-side amount validation, webhook authenticity/idempotency, ownership checks, wallet balance integrity, or video entitlement enforcement. These remain unverified pending backend source/access. |
| P1 | `firestore.rules.proposed` is only a proposed rules file; no configured/deployed Firestore rules or Firebase Storage rules are in this repository. | Actual authorization and storage access controls are unknown. Do not treat the proposed rules as live protection. |
| P2 | `Webviewbody` creates an unrestricted-JavaScript WebView and loads the checkout URL supplied by the payment-attempt response. Navigation notices success-like URLs and asks `CourseCheckoutCubit.refreshStatus` for server status before setting terminal success. | Client status does not itself grant success, which is a useful boundary. There is no explicit origin allowlist for the initial or redirected checkout URLs. Verify backend URL constraints and narrow navigation if compatible with Paymob redirect behavior. |
| P2 | `CourseCheckoutRepoImpl` logs payment attempt identifiers and server-returned payment status metadata. | No bearer tokens or checkout URLs are logged in this path, but attempt IDs can be correlatable identifiers. Consider redaction/minimization. |
| P2 | `SupabaseStorageServices` logs bucket names and detailed storage/unexpected exception messages; file URLs are made public via `getPublicUrl`. | Logs can disclose operational details. Public URLs may be intentional for public assets but are unsuitable for protected course material unless bucket/object policy and URL type guarantee access control. Backend policy is unavailable. |
| P2 | `HiveService` stores its encryption key with `FlutterSecureStorage`, encrypts the `app_storage` Hive box, and has no visible account-scoped cleanup in the service. | At-rest protection exists for this box. Whether user-specific records persist across logout/account switching requires tracing actual callers; do not assert cleanup without that trace. HydratedBloc also uses its default storage configuration. |
| P3 | `android/app/src/main/AndroidManifest.xml` declares INTERNET twice and includes several Bluetooth permissions; app features should be mapped before removing permissions. | Manifest cleanup is possible, but no permission was removed at baseline because Bluetooth use and plugin requirements need confirmation. |
| P3 | Root/pubspec/README contain stale/inconsistent environment claims: current `pubspec.yaml` requires Dart `^3.10.0` and Flutter `>=3.38.1`, while README advertises Dart `^3.5.0`; dependency declarations include direct packages that may be transitive-only. | Setup guidance is likely stale. Dependency removal requires import/native/config verification and resolution/build validation. |

## Trust-boundary observations

- Checkout creation, quote, payment status, and subscription checks are invoked through named Supabase functions with a Firebase ID token. The client parser validates response shapes and logs status metadata. The function implementations are absent, so payment amount authority, reconciliation, idempotency, fulfillment, and authorization are not verifiable here.
- `PayMobService.createPaymentIntention` and `PaymobRepoImp.payWithWallet` fail closed; the active course checkout implementation is separate. This does not show direct client-side payment success handling.
- `VideoUploadService` sends Firebase ID tokens and a Supabase publishable key to function endpoints; upload transfer URLs are returned by the server. Playback authorization is therefore dependent on unavailable Edge Function policy and Mux token handling.
- Firebase platform options and Android Google Services config are client identifiers/configuration, not automatically private credentials. `.env` being ignored is positive, but ignored local configuration cannot prove deployment secrets are correctly managed.
- `firestore.rules.proposed` describes server-controlled writes, but its applicability, correctness against every data path, and deployment status are unverified.

## Baseline validation

Commands and runtime checks will be recorded in `TESTING_REPORT.md` after the environment is inspected. No tests, builds, production services, database rules, payment provider, or external backend were modified during this baseline phase.

## Required follow-up

1. Run local Flutter analysis and existing test suite; inspect the results as baseline.
2. Confirm Flutter/Dart, Java, Gradle, and available build targets.
3. Review checkout/WebView host constraints, logout/account-switch behavior, roles/routes, and data-access code.
4. Apply only fixes supported by local evidence and add regression coverage for sensitive behavior where feasible.
5. Complete the requested audit reports with distinct verified, inferred, and blocked findings.
