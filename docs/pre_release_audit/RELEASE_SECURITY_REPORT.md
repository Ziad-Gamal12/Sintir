# Release security report

## Android

- `applicationId` is `com.example.sintir`; mobile `version` is `1.0.0+1`. iOS bundle identifier is also `com.example.sintir`. Confirm the intended Play/App Store identity before first publication; changing it later creates a different app identity.
- Previous release signing selected the debug key. The current Gradle source now reads only `SINTIR_RELEASE_STORE_FILE`, `SINTIR_RELEASE_STORE_PASSWORD`, `SINTIR_RELEASE_KEY_ALIAS`, and `SINTIR_RELEASE_KEY_PASSWORD`. When absent, `release.signingConfig` is null; it does not fall back to debug.
- No authorized signing key or credentials were available. Static search found no release-to-debug signing reference. A release AAB built successfully without signing credentials, confirming the configured unsigned path does not select the debug key.
- Release minification is enabled; resource shrinking is disabled. Existing ProGuard keeps cover Firebase Storage/WorkManager classes; runtime compatibility was not verified.
- Global Android cleartext opt-in is gone. Release backup remains enabled with targeted exclusions for the encrypted Hive box and Flutter Secure Storage files.
- Built `build/app/outputs/bundle/release/app-release.aab` (92.5 MB) with `--obfuscate --split-debug-info=debug_info`. The bundle metadata reports `com.example.sintir`; the merged release manifest reports version `1.0.0` / code `1`. `jarsigner -verify` confirms the AAB is unsigned. Split Dart symbols exist for arm, arm64, and x64 under `debug_info/`; preserve those with the exact release artifact. No install/device smoke test was possible.
- Gradle warned that generated native ELF libraries include unobfuscated DWARF debugging information. This is separate from Dart obfuscation; assess native symbol stripping and symbol retention before distribution.

## Compatibility risks

Android uses AGP 9.1.1, Gradle 9.3.1, and Kotlin Gradle Plugin 2.3.20 with `android.builtInKotlin=false`. Android’s compatibility table requires Gradle 9.3.1 for AGP 9.1. Kotlin’s published fully-supported range for KGP 2.3.20 tops out at AGP 9.0.0, so the exact AGP/KGP pair is outside the documented fully-supported range. Flutter 3.47 has built-in Kotlin support after plugins migrate; plugin readiness is unknown. Keep as P2 until a real build or compatible toolchain alignment succeeds. Sources: [Android AGP compatibility](https://developer.android.com/build/releases/about-agp), [Kotlin/Gradle compatibility](https://kotlinlang.org/docs/gradle-configure-project.html), [Flutter AGP 9 migration](https://docs.flutter.dev/release/breaking-changes/migrate-to-built-in-kotlin).

`com.facebook.android:facebook-login:latest.release` is dynamic and undermines reproducible builds. Pin after verifying compatibility with `flutter_facebook_auth`; no dependency was updated blindly.

## iOS

`Info.plist` has no global ATS arbitrary-load exception. No archive, signing, deployment-target, Keychain, or runtime permission validation was possible on Windows. No Podfile/Podfile.lock is tracked; inspect CocoaPods integration on macOS.

## Dashboard

`flutter build web --release --no-pub` passed. Release bundle scan found no markers for Paymob/Mux/Firebase service secrets and no source maps. Public Firebase/Supabase client configuration remains client-visible by design; security must be enforced by backend rules/functions. No deployment occurred.

## Distribution status

Not ready for store distribution. Required: authorized release signing, successful Android AAB/signature/install verification, confirmed app IDs, Android runtime smoke tests, iOS archive on macOS, and production backend/rule/Paymob checks.
