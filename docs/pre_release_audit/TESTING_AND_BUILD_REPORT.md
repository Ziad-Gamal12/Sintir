# Testing and build report

Environment: Windows, Flutter 3.47.0 stable, Dart 3.13.0, Deno 2.9.8, Supabase CLI 2.117.0. Flutter SDK/cache is outside the workspace; validation commands required normal SDK-cache access. No production credentials, transactions, or deployments were used.

| Command / check | Result |
|---|---|
| Mobile `flutter test --no-pub --reporter compact` | Passed: 77 tests after cleanup and dependency resolution. Existing localization-context warnings printed by some widgets. |
| Dashboard `flutter test --no-pub --reporter compact` | Initial run: 3 authorization tests passed; stock counter test failed because dashboard has no counter UI. Removed the stale starter test; final rerun passed 3/3. |
| Deno helper tests (`course_checkout_test.ts`, `withdrawal_logic_test.ts`, `video_access_test.ts`) | Passed: 32 tests. |
| `deno check` on all 12 function `index.ts` files | Passed. |
| `flutter analyze --no-pub` mobile | Non-zero exit, 755 findings after cleanup (previous audit: 785). Predominantly info-level naming/style; two warnings remain in test sources. |
| `flutter analyze --no-pub lib/main.dart lib/Core/Services/DioService.dart` dashboard | Passed: no issues found after the Supabase `publishableKey` update and debug-only logging change. Whole-dashboard analysis before the key update had 640 findings, mostly naming/style; its final count was not rerun. |
| Dashboard `flutter build web --release --no-pub` | Final build passed; output `build/web`; took 316.9 s. Secret-name marker scan found no server-secret markers or source maps. |
| Android release `flutter build appbundle --release --obfuscate --split-debug-info=debug_info --no-pub` | First attempt failed during daemon startup (`Address already in use`); retry succeeded in 1519.6 s. Produced `build/app/outputs/bundle/release/app-release.aab` (92.5 MB) and arm/arm64/x64 Dart symbols in `debug_info/`. Bundle metadata/merged manifest report `com.example.sintir`, version `1.0.0+1`; `jarsigner -verify` confirms it is unsigned. Gradle warned native ELF libraries retain unobfuscated DWARF information. No device install test was available. |
| Android/iOS XML parse | Passed for Android manifest, backup rules, extraction rules, and iOS `Info.plist`. |
| Supabase CLI `status` | CLI 2.117.0; linked project metadata was reported but status failed because Docker and Podman are absent. No remote action was issued. |
| iOS archive | Not run; Windows host has no Xcode. The repo also has no tracked Podfile/Podfile.lock. |

No Firebase Emulator, local Firestore, local Supabase stack, Paymob sandbox, Mux upload/webhook, device screenshot, or physical-device integration test was run. No test failure was hidden; the initial stale dashboard failure and Deno sandbox pipe panic are recorded here. Deno tests passed when run with normal runtime access.
