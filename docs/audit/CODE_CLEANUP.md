# SINTIR Code Cleanup

Audit date: 2026-11-03.

## Changes made

- Removed no Dart files, assets, packages, generated registrations, or platform permissions.
- Added test/get_user_data_test.dart for empty local user fallback.
- Updated lib/Core/helper/GetUserData.dart to return UserEntity.empty() for an empty map.

No deletion candidate was safe to remove based on this audit. The workspace has 1,144 Dart files, platform registrations, generated localization/assets, route registrations, and dynamic assets. Lack of an obvious import is not proof of dead code.

## Dependency review

- flutter pub get --offline succeeded from pubspec.lock. Pub reported 15 packages with newer versions outside current constraints; none was upgraded.
- pubspec.yaml includes a targeted image_picker_android override documented as compatibility workaround; retain until compatibility with secure_content is tested.
- android/app/build.gradle.kts declares com.facebook.android:facebook-login:latest.release. This dynamic Gradle version reduces build reproducibility. Pin only after confirming a version compatible with flutter_facebook_auth.
- No package was removed. Direct/transitive/native/generated reachability review was not sufficient to justify deletion.
- README advertises Dart ^3.5.0 while pubspec requires Dart ^3.10.0 and Flutter >=3.38.1; setup guidance is stale.

## Preserved pre-existing edits

- android/app/src/main/kotlin/com/example/sintir/MainActivity.kt
- macos/Flutter/GeneratedPluginRegistrant.swift
- windows/flutter/generated_plugin_registrant.cc
- windows/flutter/generated_plugins.cmake
