# Hive and local storage security

## Inventory

| Store | Observed contents | Classification | Protection / lifecycle |
|---|---|---|---|
| Hive `app_storage` (`HiveService.dart`) | One `UserData` map written from `AuthRepoImpl`; profile fields include UID, name, phone/email, role/status, device ID, and for teachers wallet metadata | Personal/profile/educational and potentially financial | AES-256 via Hive `HiveAesCipher`; key generated with `Hive.generateSecureKey()` and base64url encoded into Flutter Secure Storage |
| `SharedPreferences` | Theme/locale and `pending_teacher_withdrawal_<uid>` snapshot | Non-sensitive preferences plus temporary financial data (amount, issuer, phone, idempotency key) | Android shared-preference storage, not encrypted by app code; withdrawal state is retained to retry ambiguous requests safely |
| HydratedBloc | ThemeMode and Locale in current hydrated cubits | Non-sensitive preferences | App documents directory; no user-auth token or profile serializer found |
| Firebase Auth SDK | Firebase session/token material | Authentication/session | SDK-managed platform persistence; not copied into app Hive by reviewed code |
| Supabase/Firebase client config | Public project URL/anon or publishable key | Public application configuration | Compiled into client; not a service credential |
| Network/image/video caches | `cached_network_image`, player and OS caches | Public course images; temporary protected media | No custom persistent video-token store found; signed Mux playback URL/token remains in runtime memory |
| Files | Picked video/file paths and temporary upload stream | Educational content / temporary | Upload uses a 5 MiB stream; signed Mux upload URL is held in active session memory, not written to Hive |

Search found no SQLite/sqflite store, local JSON file writer, Hive adapters, `TypeAdapter`, `@HiveType`, or type IDs. Hive’s box contains dynamic maps/lists and recursive map conversion. There is no old unencrypted Hive box in the current code path; therefore no format migration was justified or attempted.

## Encryption and key lifecycle

`flutter_secure_storage` is locked at 10.3.1. `HiveService.init` initializes Hive, checks the secure store for `encryptionKey`, generates a Hive secure key if absent, persists it, decodes it, then opens `app_storage` with `HiveAesCipher`. The key is not hardcoded, derived from user data, stored in Hive, or logged. The default Android secure-storage implementation uses platform-backed key wrapping; iOS uses Keychain. No biometric gate is configured.

If the secure-storage key is lost while the encrypted Hive file remains, the code currently generates a new key and opening the old box fails. The old records are not automatically deleted, but startup recovery is not user-friendly and the lost key cannot decrypt them. Report this as a recovery limitation; do not add a “delete box and retry” path.

## Account isolation and fixes

`UserData` is one global key, not UID-namespaced. Successful auth fetch overwrites it with the active backend profile. Previously, logout signed out but left it in the encrypted box. The audit adds a Hive key deletion in the `finally` of `firebaseAuthService.signout()`. The encryption key and app-wide preferences are retained. Logout does not clear the pending teacher-withdrawal idempotency snapshot because doing so after an ambiguous provider response could permit a duplicate payout.

An interrupted login/account-switch integration test was not possible; the ordinary mobile suite passed 77 tests. No test directly invokes the native secure-storage plugin or verifies the deletion on device.

## Android backup behavior

Android had no backup rules and platform backup would otherwise include app data. Backup remains enabled, but `backup_rules.xml` (Android 11 and earlier) and `data_extraction_rules.xml` (Android 12+) exclude `app_flutter/app_storage.hive`, its lock file, and Flutter Secure Storage preference/configuration files for cloud backup and device transfer. Other app backup data is not globally disabled. This avoids restoring ciphertext without its device-bound key; sign-in can repopulate profile data. XML parsing passed; an actual backup/restore device test remains blocked. See [Flutter Secure Storage Android backup guidance](https://pub.dev/packages/flutter_secure_storage) and [Android Auto Backup rules](https://developer.android.com/identity/data/autobackup).

## Remaining work

- Move the withdrawal snapshot to secure storage using a crash-safe, read-secure/write/verify/delete-legacy migration; preserve pending idempotency and phone number exactly.
- Add testable storage injection and migration tests for first install, existing profile, empty/partial profile, interrupted migration, invalid/missing key, logout, and account switch.
- Define an explicit recoverable state when encrypted Hive exists but its secure key is unavailable. Never discard the old file automatically.
- Validate backup behavior with Android Auto Backup and device-transfer test builds.
- Verify SDK-managed auth token storage with platform instrumentation; source review alone is not device evidence.
