# Security audit

## Scope and trust boundaries

The workspace has two Git repositories: the Flutter app (`sintir`) and the dashboard/backend repository (`sintir_dashboard`). The app uses Firebase Auth/Firestore, Supabase Storage and Edge Functions, Paymob, Mux, Hive, SharedPreferences, Flutter Secure Storage, HydratedBloc, GoRouter, and a WebView checkout. The dashboard uses Firebase Auth/Firestore directly and invokes Supabase functions for analytics. The accessible Supabase functions use a Firebase service account against Firestore REST; there is no application SQL schema or RLS migration in this checkout.

Trust boundaries:

- Firebase ID tokens authenticate app/dashboard users; server functions verify signature, Firebase issuer, and project audience in `_shared/firebase.ts`.
- Client-supplied amount, user ID, role, course ID, callback URL, enrollment, and wallet balance are untrusted. Checkout quote, withdrawal reservation, entitlement, and fulfillment are resolved against Firestore by server code.
- Paymob callback payloads are untrusted until transaction HMAC and attempt/reference/order/amount/currency/integration checks pass.
- Mux webhook payloads are untrusted until raw-body signature and timestamp checks pass. Mux passthrough is only a lookup key; server records determine ownership.
- Mobile route visibility and dashboard role gates are UX controls. Firestore rules must independently enforce every read/write.

## Findings

### P1 — Deployed Firestore authorization is unverified

**Evidence:** `firebase.json` configures hosting and FlutterFire metadata but no Firestore or Storage rules. `firestore.rules.proposed` is not active configuration. Both clients perform direct Firestore reads/writes, and the dashboard’s role check is client-side. **Impact:** actual cross-user reads, user-controlled role/status updates, wallet changes, or management writes cannot be ruled out. **Fix:** merge and deploy an authoritative ruleset through the owner’s reviewed release process, then test with Firebase Emulator. **Status:** unresolved; no live rules were read or changed. This is a release blocker.

### P1 — Android release has no authorized signing identity

**Evidence:** previous build configuration selected the debug signing config. The remediation removes that fallback and enables an explicit environment-backed release config. No signing environment values were available. **Impact:** no store-ready/update-compatible artifact. **Status:** debug signing removed by source change; production signature not verified and AAB build blocked.

### P1 — Student Mux playback was unreachable (fixed)

**Location:** `sintir_dashboard/supabase/functions/_shared/video.ts`, `handleVideoRequest`. **Root cause:** the common path required teacher ownership and `createdBy == uid` before calling `playback`, even though `playback` contained an enrolled-student entitlement check. **Impact/reproduction:** an active enrolled student requests `get-video-playback-token` for a ready Mux video; the request returned forbidden/not-found before entitlement evaluation. **Fix:** teacher ownership checks now apply only to upload resume/cancel. Playback independently checks active account, allowed role, published course, and both enrollment records; teachers must own the course. **Verification:** 3 new authorization tests; 32 Edge Function helper tests pass; all 12 functions type-check. **Remaining risk:** no Firestore emulator or deployed policy/device test.

### P1 — Payout endpoint was hardcoded to staging (fixed with explicit configuration)

**Location:** `sintir_dashboard/supabase/functions/_shared/paymob.ts`. **Root cause:** every payout and inquiry used `stagingpayouts.paymobsolutions.com`, including production deployments. **Impact/reproduction:** production credentials would call the staging payout environment. **Fix:** `PAYMOB_PAYOUT_BASE_URL` is now required and restricted to the exact HTTPS Egypt production or staging origins; payout credentials are checked before funds are reserved. **Verification:** tests accept the two official origins and reject HTTP, lookalike, userinfo, and path variants. **Remaining risk:** the owner must configure the production origin and production credentials in Supabase secrets and verify a sandbox callback/payout before production. No payment was initiated.

### P2 — Dashboard logs contained whole request/response bodies (fixed)

**Location:** `sintir_dashboard/lib/Core/Services/DioService.dart`. The Dio `LogInterceptor` is now registered only in debug builds; release web builds do not log response bodies. Dashboard release bundle scan found no known server-secret markers and no source maps. No real user data was present in tests.

### P2 — Cached profile survived logout (fixed)

**Location:** `sintir/lib/Core/services/FireBase/FirebaseAuth_Service.dart`, `HiveService.dart`. Firebase sign-out now deletes only the `UserData` Hive entry in a `finally` block. Global preferences and the Hive master key remain. Existing 77 mobile tests pass; there is no dedicated plugin-level sign-out/storage test, so native behavior still needs device verification.

### P2 — Checkout WebView has no verified redirect allowlist

The checkout WebView loads the backend-returned hosted checkout and handles redirect-like URLs by refreshing server payment status; client redirect alone does not fulfill a payment. JavaScript is enabled. Paymob/issuer 3-D Secure host contract and runtime flow were not exercised. Add HTTPS and provider-origin restrictions after the merchant confirms all required 3-D Secure origins.

### P2 — Direct Firebase/dashboard access depends on unavailable live rules

Dashboard user roles are filtered in `UserCubit`; this is not authorization for its direct Firestore queries. App `GoRouter` restrictions and hidden actions likewise are not authorization. The proposed rules file is evidence of an intended policy only, not the active project policy.

### P2 — Sensitive diagnostics and temporary state need production review

The Flutter app’s checkout/storage code and Edge Functions contain diagnostic logging. Reviewed checkout server logs avoid provider secrets and checkout URLs; the dashboard logger fix removes release request/response bodies. SharedPreferences persists a pending teacher withdrawal snapshot keyed by Firebase UID to preserve idempotency; it includes amount, issuer, and phone number and is not encrypted. Migrate it to secure storage with an interrupted-migration test before treating financial local data as fully protected.

## Positive controls observed

- Hive uses `HiveAesCipher` with a secure random Hive key stored using `flutter_secure_storage` (version 10.3.1); no Hive adapters/type IDs or hardcoded key were found.
- Checkout quote and fulfillment are server-side; the Paymob webhook verifies HMAC and correlates amount/currency/integration/order/reference.
- Withdrawal logic reserves balance before provider I/O, uses idempotency, and retains ambiguous funds for reconciliation/manual review.
- Mux playback uses signed playback IDs and server-signed expiring JWTs; upload requires active teacher ownership.
- Cleartext transport exceptions were removed in the checkpoint commit.
- No tracked service-role, Mux signing, Paymob secret, or Firebase private-key marker was found in the dashboard release bundle. Local ignored `.env` and `constant.dart` values were not printed or added to Git.

## Threat model

| Actor / event | Main controls | Residual concern |
|---|---|---|
| Unauthenticated attacker | Firebase token verification; webhook signatures | Deployed Firestore rules and production gateway settings unknown |
| Malicious student | Server-side course enrollment check; playback JWT | Emulator test and live policy verification absent |
| Malicious teacher | Course ownership and balance reservation checks | Firestore rules and operational payout configuration unverified |
| Compromised device / modified local storage | Hive AES encryption; platform secure storage; screenshot scope | Plain SharedPreferences withdrawal snapshot; rooted-device extraction cannot be prevented |
| Manipulated/replayed payment request | Server quote, idempotency, HMAC, transaction correlation, reconciliation | Paymob callbacks/secrets/integration configuration not production-verified |
| Unauthorized dashboard user | Active role checks in frontend | Frontend checks do not replace Firestore rules |
| Leaked API credential | Server secrets separated from app bundle | Runtime secret inventory, access policy, and rotation state inaccessible |
| Leaked Mux playback token | Signed JWT with expiration | Token lifetime is at least one hour and cannot be revoked per logout |

