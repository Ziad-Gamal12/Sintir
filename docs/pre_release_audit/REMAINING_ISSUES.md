# Remaining issues and blockers

| Priority | Issue | Evidence / location | Required action |
|---|---|---|---|
| P1 | Deployed Firestore/Storage rules unknown | `firebase.json` contains no active rules configuration; `firestore.rules.proposed` is not deployed | Obtain current rules from project owner; test complete app/dashboard roles and cross-user access in emulator; review before deployment |
| P1 | No store release signing key/configured values | Release AAB built and verified unsigned; no signing credentials are available | Supply authorized keystore through secure CI/environment, rebuild, and verify the signed AAB |
| P1 | Store application ID is generic | Built manifest and bundle metadata identify `com.example.sintir`, version `1.0.0+1` | Confirm intended Android/iOS store identity before first publication |
| P1 | Production Paymob configuration inaccessible | Function secret/callback state unavailable; prior ops doc says `PAYMOB_API_KEY` was missing | Confirm current secrets, callback for every integration, production payout base URL, and sandbox outcomes |
| P1 | App identity is generic | Android and iOS both use `com.example.sintir`; version `1.0.0+1` | Confirm intended store IDs/version before first publication |
| P1 | Local Firestore/Supabase security testing blocked | No Docker/Podman; CLI reports missing container runtime | Enable disposable local stack and emulator; test policies/functions/migrations |
| P2 | SharedPreferences stores payout retry snapshot unencrypted | `TeacherWithdrawalService.dart` stores amount/issuer/phone/idempotency key | Migrate crash-safely to Flutter Secure Storage while preserving old pending request |
| P2 | Gradle/Kotlin plugin versions outside documented fully supported range | AGP 9.1.1 / Gradle 9.3.1 / KGP 2.3.20 | Verify plugin compatibility/build or align versions after full plugin test matrix |
| P2 | Checkout WebView redirect host policy unverified | `WebViewBody.dart` and Paymob 3DS flow | Obtain official host contract; enforce HTTPS/allowlist without breaking issuer redirects |
| P2 | Release-mode installation and UI matrix absent | No Android device/emulator or Xcode/device | Install the signed candidate on representative devices; validate screen protection, localization, themes, navigation, accessibility |
| P2 | Native ELF debug symbols remain in generated libraries | Gradle warned release ELF libraries contain unobfuscated DWARF information; Dart symbols were produced separately | Review native library stripping and secure symbol retention before distribution |
| P2 | iOS archive blocked; Podfile absent | Windows host; no tracked `ios/Podfile` or lockfile | Prepare CocoaPods/Xcode build on macOS; verify signing/ATS/Keychain |
| P2 | `MuxWebhookEvents` retention undefined | Firestore collection has no TTL migration/policy in checkout | Define retention/idempotency window and authorized cleanup job |
| P2 | Supabase live secret/function state unknown | Static source only | Verify via project owner/console without exposing secret values |
| P2 | Secure-storage missing-key recovery is poor | `HiveService.init` generates new key then old encrypted box open fails | Add fail-closed, recoverable startup state; never delete old box automatically |
| P2 | Sign-out cache deletion lacks dedicated plugin integration test | New `Hive_Services.delete` call in Firebase signout | Add injected storage/auth test and device account-switch test |
| P3 | Dynamic Facebook SDK version | `android/app/build.gradle.kts` uses `latest.release` | Pin compatible version after verifying native plugin requirements |
| P3 | README SDK requirements stale | README vs `pubspec.yaml` | Update install guidance |
| P3 | Asset/dependency/Dart cleanup candidate lists absent | Prior report does not list requested 4/5/25 candidate paths | Provide candidates or generate reference reports; no speculative deletions made |

No production migration, rule, secret, credential, payout, payment, video asset, or user record was changed.
