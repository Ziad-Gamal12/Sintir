# SINTIR final pre-release engineering audit

Audit date: 2026-11-04. Scope: both checked-out Flutter repositories, local Supabase function source and migrations, and Android/iOS project configuration. No production service was called or changed.

## Release decision

**Not ready for release to real users.** Confirmed client/backend fixes were made and local tests pass, and an obfuscated unsigned Android AAB was produced. Store signing, Firestore authorization, production payment configuration, device-level security/UI checks, and iOS archive validation remain incomplete. The current bundle is unsigned and its application ID is the generic `com.example.sintir`.

## Work completed

- Created pre-audit checkpoint commits before remediation: mobile `6089602`; dashboard `87ec7e4`. No push was made. The mobile commit preserves the prior cleartext-transport and empty-cache fixes and four pre-existing native/generated changes named in the prior changelog.
- Removed the Firebase-cached user profile from encrypted Hive during Firebase sign-out while keeping the encryption key and global preferences.
- Added Android backup exclusions for the device-bound Flutter Secure Storage files and the Hive box that depends on them; Android backups remain enabled for other app data.
- Changed Android release signing to use only explicit environment-provided release credentials. Missing credentials now leave the release variant unsigned; the debug key is never selected.
- Restricted dashboard request/response body logging to debug builds.
- Fixed the Mux playback authorization path so active enrolled students can reach the server entitlement check. Added regression coverage.
- Removed the fixed staging Paymob payout host. The function now requires an explicit approved production or staging origin before it reserves funds.
- Removed the dashboard’s unmodified Flutter starter counter test, which tested UI the dashboard does not contain.
- Reviewed all 4 named asset candidates, 5 dependency candidates, and 25 Dart-file candidates. Kept runtime/generated/indirectly used assets and files, removed 19 confirmed-unused Dart files, removed the unused `expansion_widget`, and removed four unnecessary direct dependency declarations while retaining packages still required transitively.
- Added these audit documents.

## Validation

- Mobile Flutter tests: **77 passed**.
- Dashboard Flutter tests: **3 passed** after removing the stale starter test.
- Supabase Edge Function helper tests: **32 passed**.
- Deno type-check: **all 12 Edge Function entry points passed**.
- Whole-project Flutter analysis: mobile **755 findings** after cleanup; dashboard whole-project analysis earlier reported **640 findings**, mostly naming/style info findings. Targeted dashboard analysis for the changed Dart files passed.
- Dashboard production web build: passed; output at `sintir_dashboard/build/web`. A marker scan found no server-secret names or source maps in the bundle.
- Android manifest, backup XML, data-extraction XML, and iOS Info.plist parsed as XML.
- Android release AAB: built with Dart obfuscation as `build/app/outputs/bundle/release/app-release.aab` (92.5 MB); `jarsigner` confirms it is unsigned. Application ID/version and split Dart symbols were checked. No device install smoke test was available. Gradle reports native ELF DWARF debug info remains unobfuscated.
- Supabase local stack: unavailable because Docker and Podman are not installed. The local CLI metadata is linked to a project, but no remote command was run.

## Highest-priority remaining blockers

1. Obtain and verify the authorized store keystore and credentials, then rebuild and verify the signed bundle. The current artifact is unsigned and cannot be distributed.
2. Review and test the actual deployed Firestore rules. The repositories contain only `firestore.rules.proposed`; no rules are configured in `firebase.json`, and dashboard access uses direct Firebase clients.
3. Configure and verify production Paymob secrets, callbacks, and `PAYMOB_PAYOUT_BASE_URL=https://payouts.paymobsolutions.com`; the production secret state is inaccessible here.
4. Confirm the intended store application ID and version. Install the candidate bundle through an APK/device workflow and complete release-mode smoke testing; decide how to strip/retain native ELF debug symbols.
5. Verify playback/upload, payment sandbox, session/account switching, screenshots, recording, and all six locale/theme combinations on devices or emulators.
6. Android and iOS currently use the generic `com.example.sintir`; confirm the intended store identity before publication.

The full evidence, threat model, workflows, fixes, and unresolved items are in the reports linked from this directory. “Source reviewed” does not mean production configuration was verified.
