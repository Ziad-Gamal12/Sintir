# Supabase Edge Functions audit

## Available source

The dashboard repository contains all 12 configured function entry points and shared helpers. Supabase gateway `verify_jwt` is disabled because handlers accept Firebase JWTs or provider callbacks; each authenticated handler performs its own Firebase ID-token check. Webhooks use provider signatures; scheduled reconciliation uses a dedicated secret header. The local CLI is 2.117.0, but no local stack can start because Docker/Podman are absent. The local CLI metadata is linked to a Supabase project; no remote status/deploy/database command was run.

## Function review

| Function | Boundary and source-review result |
|---|---|
| `course-checkout-quote` | Authenticates Firebase UID; derives price/coupon from Firestore and uses cents. |
| `create-course-payment` | Server quote and Firebase UID; idempotent attempt/lock reservation; persists ambiguity before Paymob intention and does not trust redirect success. |
| `get-course-payment-status` | Caller-scoped attempt; rate-limited Paymob inquiry; status only, no new intention. |
| `check-course-subscription` | Caller-scoped Firestore enrollment lookup. |
| `paymob-webhook` | Validates ordered Paymob HMAC, attempt/reference/order, cents, EGP, integration, and terminal state before fulfillment. |
| `reconcile-course-payments` | Requires dedicated reconciliation secret; pages unresolved attempts; only verified matching provider evidence fulfills; uncertain states retain reservation. |
| `create-video-upload` | Firebase user must be active Teacher and own course; metadata bounded; signed Mux Direct Upload; writes course item and `MuxVideoIndex`. |
| `resume-video-upload` | Active course owner and original uploader; checks Mux waiting state; does not mint a new signed URL. |
| `cancel-video-upload` | Active course owner and original uploader; cancels upload/deletes asset then records status. Not invoked in this audit. |
| `get-video-playback-token` | Fixed: student request now reaches enrollment policy; active enrolled student on published course or active owning Teacher only; signs expiring RS256 Mux JWT. |
| `mux-webhook` | Raw-body HMAC and five-minute timestamp check; event idempotency and atomic item/event commit. |
| `teacher-withdrawal` | Firebase auth, server role/status/wallet check, cent-exact reservation, idempotency, provider correlation, terminal settlement, unresolved reconciliation, and Admin manual resolution. Fixed to require an explicit safe payout origin before reserving. |

## Shared helper and error handling

`_shared/firebase.ts` verifies Firebase JWT signature/issuer/audience via Google Secure Token JWKS and uses service-account Firestore REST. `_shared/course_checkout.ts` contains quote, lock, coupon reservation, fulfillment, and webhook HMAC logic. `_shared/paymob.ts` handles payouts; `_shared/paymob_inquiry.ts` handles checkout inquiry; `_shared/video.ts` handles upload/playback authorization and token signing. Errors exposed to clients are generally generic; provider response text and secrets are not returned by the checkout path. Logging still includes some document identifiers for reconciliation/withdrawal operations and should be access-controlled and retention-limited.

## Verification

- Deno helper tests: 32 passed (checkout, withdrawal, video playback policy).
- Deno `check`: all 12 entry points passed.
- No function was served against a local Firestore emulator or Supabase stack; no webhook HTTP request, Paymob call, Mux call, or production call was made.
- No test verifies the actual `Deno.serve` request path with a mocked Firestore/provider across every function. Add handler-level integration tests before release.

## Remaining blockers

Production Edge Function secret presence/values, runtime versions, deployed function versions, gateway configuration, service-account IAM, and callback URLs are inaccessible. Ops docs state `PAYMOB_API_KEY` was missing in a prior runtime check; current secret state must be verified in Supabase without sharing values. Local migration/function integration requires Docker/Podman. Never deploy from this audit workspace.
