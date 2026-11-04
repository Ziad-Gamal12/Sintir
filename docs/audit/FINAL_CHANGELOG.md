# SINTIR Audit Changelog

Audit date: 2026-11-03.

## Application changes

- android/app/src/main/AndroidManifest.xml: removed global cleartext traffic opt-in.
- ios/Runner/Info.plist: removed global NSAllowsArbitraryLoads exception.
- lib/Core/helper/GetUserData.dart: added a local map parser that returns the existing empty-user sentinel for an empty cache, avoiding invalid deserialization.
- test/get_user_data_test.dart: added empty-cache regression test.
- No dependencies, credentials, backend rules, migrations, payment contracts, schemas, assets, permissions, or existing generated files were deleted or otherwise changed by this audit.

## Documentation created

BASELINE_ANALYSIS.md, EXECUTIVE_SUMMARY.md, SECURITY_AUDIT.md, PERFORMANCE_AUDIT.md, LOCALIZATION_AUDIT.md, THEME_AUDIT.md, CODE_CLEANUP.md, TESTING_REPORT.md, REMAINING_ISSUES.md, and FINAL_CHANGELOG.md under docs/audit/.

## Preserved pre-existing working-tree edits

- android/app/src/main/kotlin/com/example/sintir/MainActivity.kt
- macos/Flutter/GeneratedPluginRegistrant.swift
- windows/flutter/generated_plugin_registrant.cc
- windows/flutter/generated_plugins.cmake
