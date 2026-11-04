# SINTIR Security Audit

Audit date: 2026-11-03. Baseline: OWASP MASVS control groups and MASTG guidance. References: [OWASP MASVS](https://mas.owasp.org/MASVS/), [WebView input validation](https://mas.owasp.org/MASTG/best-practices/MASTG-BEST-0034/), [iOS ATS cleartext test](https://mas.owasp.org/MASTG/TEST-0322/), [Android cleartext test](https://mas.owasp.org/MASTG/tests/android/MASVS-NETWORK/MASTG-TEST-0235/).

This was a source/configuration review. No live account, payment, production backend, or dynamic device security test was used.

## Prioritized findings

### S1 — P1 — Release build uses debug signing
- **Location:** android/app/build.gradle.kts, release build type.
- **Evidence:** release signingConfig resolves to the debug signing config.
- **Impact:** A release artifact built with this identity is not suitable as the managed store signing identity; release/update governance is at risk.
- **Mitigation:** Configure organization-managed signing in protected CI and verify package identity; do not commit keys.
- **Status:** Unfixed; no production key/config was available.
- **Verification/limits:** Source inspected. Android release build did not complete; no artifact is claimed.

### S2 — P1 — Backend authorization and payment security unavailable for review
- **Location:** Backend source/config absent. Client references: lib/Core/repos/CourseCheckoutRepoImpl.dart, lib/Core/services/VideoUploadService.dart, lib/Core/services/TeacherWithdrawalService.dart, lib/Core/services/SupabaseStorageServices.dart.
- **Evidence:** Client invokes Supabase functions for quotes, payment creation/status, subscription checks, video operations, and withdrawals. No function source, migrations/policies, storage policies, Firebase Storage rules, configured active Firestore rules, or dashboard source was found. firestore.rules.proposed is not configured in firebase.json.
- **Impact:** Server amount validation, ownership checks, webhook authenticity/idempotency, wallet integrity, video entitlement, and RLS cannot be established from client code.
- **Mitigation:** Review deployed rules/functions and test cross-user, role, amount, replay, and fulfillment cases using emulators/sandbox.
- **Status:** Blocked by missing source/access. No backend or production rules were changed.
- **Verification/limits:** Client request/response contracts and proposed rules were read. This is a verification gap, not a claim that live rules are vulnerable.

### S3 — P1 — Global cleartext exceptions (fixed)
- **Location:** android/app/src/main/AndroidManifest.xml; ios/Runner/Info.plist.
- **Evidence:** Android allowed cleartext globally; iOS set NSAllowsArbitraryLoads true.
- **Impact:** Platform transport protections were relaxed globally.
- **Mitigation:** Use platform HTTPS defaults and only narrowly scoped documented exceptions if required.
- **Status:** Fixed by removing both overrides.
- **Verification:** Both files parse as XML; source scan found no intentional HTTP service URL in lib; 77 Flutter tests passed after the changes.
- **Limits:** Backend-generated URLs were unavailable for runtime inspection. Verify staging checkout, media, upload, and file URLs are HTTPS.

### S4 — P2 — Checkout WebView has no explicit destination policy
- **Location:** lib/Core/widgets/WebViewer/WebViewBody.dart.
- **Evidence:** JavaScript is unrestricted; a server-returned checkout URL is loaded; navigation observes success-looking URLs but does not block other destinations. The UI then requests backend status before representing terminal success.
- **Impact:** A malformed/compromised response or unexpected redirect could show attacker-controlled content inside the payment surface. A success-looking URL alone does not appear to fulfill enrollment client-side.
- **Mitigation:** Validate HTTPS and allowlist Paymob plus documented issuer/3-D Secure origins. Keep fulfillment based on backend status. Disable JavaScript only if provider flow supports it.
- **Status:** Unfixed; full redirect-origin contract unavailable.
- **Limits:** No live provider flow run.

### S5 — P2 — Cached profile persists through logout
- **Location:** lib/Features/Auth/Data/repos/AuthRepoImpl.dart stores serialized user data in encrypted Hive; lib/Core/widgets/LogOutDialog.dart signs out without deleting the cache.
- **Impact:** Profile data may remain accessible to a later local session/device user. Hive encryption at rest does not implement lifecycle cleanup.
- **Mitigation:** Clear account-scoped cache and user-specific hydrated state on logout/account switch; test both flows.
- **Status:** Unfixed pending lifecycle regression coverage and key inventory.
- **Verification:** Logout and Hive storage calls traced.

### S6 — P2 — Client route access is not authorization
- **Location:** lib/Core/utils/App_router.dart.
- **Evidence:** 59 GoRoute definitions; no router redirect for session/role found. Local cached role controls some UI.
- **Impact:** Direct navigation can display role-specific screens. This is not by itself a backend bypass, but every sensitive backend operation must enforce authorization.
- **Mitigation:** Verify backend permission checks; add route redirects only as UX/session control after tests.
- **Status:** Unfixed; backend unavailable.
- **Limits:** No endpoint permission tests possible.

### S7 — P2 — Diagnostic logs may expose linked identifiers or backend details
- **Location:** lib/Core/repos/CourseCheckoutRepoImpl.dart logs payment-attempt ID/status metadata; lib/Core/services/SupabaseStorageServices.dart logs bucket and exception text; other features log exception messages.
- **Impact:** Identifiers/error details can be retained in device logs or diagnostic exports. Targeted scan did not find checkout bearer token or checkout URL logging.
- **Mitigation:** Minimize production logs, redact identifiers as appropriate, and inspect crash/analytics attachments.
- **Status:** Unchanged; production logging configuration unavailable.
- **Verification:** Static source search only.

### S8 — P3 — Android permissions/callbacks need mapping
- **Location:** android/app/src/main/AndroidManifest.xml.
- **Evidence:** INTERNET is declared twice; audio/Bluetooth permissions and an exported Facebook callback custom-scheme activity are present.
- **Impact:** Duplicate INTERNET is redundant; other permission/callback surface should match implemented features and validate inputs.
- **Mitigation:** Map to speech/audio/plugin use and validate callback ownership/input before removing permissions.
- **Status:** No permission removed because feature mapping was incomplete.

## Secrets and platform configuration

- .env is ignored and not tracked. lib/constant.dart is also ignored and references a Supabase publishable key. Client Firebase/Supabase configuration is not automatically secret; server authorization remains required.
- No secret values are included here. Targeted scans did not identify a confirmed service-role, Mux signing, or Paymob private key in tracked client source.
- No custom certificate-bypass callback was found in targeted source searches.
- Android release signing remains a blocker; iOS archive validation is unavailable on this Windows host.

## Positive client controls observed

Checkout sends a Firebase ID token to named Supabase functions, parses response shapes, and refreshes backend status before returning success. Legacy direct Paymob intention/payment methods fail closed. Hive encrypts its box using a Flutter Secure Storage key. Video clients send Firebase ID tokens and a Supabase publishable key. None of these observations proves server authorization is correct.

