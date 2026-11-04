# Supabase Edge Function deployment plan

Audit target: dashboard checkout `H:\flutter projects\Sintir Educational Apps\sintir_dashboard`, current working-tree diff under `supabase/`. This is a deployment plan only. No function, migration, secret, or project configuration was deployed or changed for this review.

## Deploy these five functions

| Function | Why it needs redeployment | Dependency path |
|---|---|---|
| `create-video-upload` | Its bundled handler imports the modified video module. | `create-video-upload/index.ts` → `../_shared/video.ts` → `./firebase.ts`, `./http.ts`, and `npm:jose@5.10.0`; `firebase.ts` also imports `npm:jose@5.10.0`. |
| `resume-video-upload` | Its bundled handler imports the modified video module. | `resume-video-upload/index.ts` → `../_shared/video.ts` → `./firebase.ts`, `./http.ts`, and `npm:jose@5.10.0`; `firebase.ts` also imports `npm:jose@5.10.0`. |
| `cancel-video-upload` | Its bundled handler imports the modified video module. | `cancel-video-upload/index.ts` → `../_shared/video.ts` → `./firebase.ts`, `./http.ts`, and `npm:jose@5.10.0`; `firebase.ts` also imports `npm:jose@5.10.0`. |
| `get-video-playback-token` | Its bundled handler imports the modified video module, including the playback authorization change. | `get-video-playback-token/index.ts` → `../_shared/video.ts` → `./firebase.ts`, `./http.ts`, and `npm:jose@5.10.0`; `firebase.ts` also imports `npm:jose@5.10.0`. |
| `teacher-withdrawal` | Its `index.ts` was directly modified and it bundles the modified Paymob module. The handler now rejects payout creation with HTTP 503 before reserving funds if payout configuration is incomplete. | `teacher-withdrawal/index.ts` → `../_shared/paymob.ts` → `./firebase.ts` → `npm:jose@5.10.0`. The entrypoint also imports `firebase.ts`, `http.ts`, and `withdrawal_logic.ts`; `withdrawal_logic.ts` has no further imports. |

The modified `_shared/video.ts` has four deployable direct importers. The modified `_shared/paymob.ts` has one deployable direct importer, `teacher-withdrawal`. Repository search found no barrel export or other transitive re-export that adds another deployable function to either dependency set.

## Diff inventory and exclusions

Current Supabase working-tree changes:

- Modified deployable entrypoint: `supabase/functions/teacher-withdrawal/index.ts`.
- Modified shared runtime modules: `supabase/functions/_shared/video.ts`, `supabase/functions/_shared/paymob.ts`.
- Modified test: `supabase/functions/_shared/withdrawal_logic_test.ts`.
- New untracked test: `supabase/functions/_shared/video_access_test.ts`.

The two test files are excluded from deployment. `video_access_test.ts` imports `video.ts`, and `withdrawal_logic_test.ts` imports `paymob.ts` for tests; those test imports do not make the tests Edge Function entrypoints. Shared modules are bundled into their callers and are not deployed as standalone functions.

No other deployable function needs redeployment solely because of this diff. In particular, course-payment functions import `paymob_inquiry.ts`, which is separate from `paymob.ts`; no checkout, payment-status, subscription, webhook, Mux webhook, or reconciliation entrypoint imports or re-exports either changed runtime module. The `paymob-payout-webhook` directory has no `index.ts` and has no per-function config entry, so it is not a deployable function in this checkout.

## Function configuration and JWT verification

`supabase/config.toml` has per-function configuration for 12 deployable entrypoints. Every configured function has `verify_jwt = false`:

| Function | `verify_jwt` | Handler-level authentication documented in config/source |
|---|---:|---|
| `teacher-withdrawal` | `false` | Verifies Firebase ID tokens itself; scheduled reconciliation also requires a separate secret header. |
| `create-video-upload` | `false` | Firebase ID token verified by the shared video handler. |
| `resume-video-upload` | `false` | Firebase ID token verified by the shared video handler. |
| `cancel-video-upload` | `false` | Firebase ID token verified by the shared video handler. |
| `get-video-playback-token` | `false` | Firebase ID token verified by the shared video handler. |
| `mux-webhook` | `false` | Validates Mux webhook signature itself. |
| `course-checkout-quote` | `false` | Firebase ID token verified in the handler. |
| `create-course-payment` | `false` | Firebase ID token verified in the handler. |
| `get-course-payment-status` | `false` | Firebase ID token verified in the handler. |
| `check-course-subscription` | `false` | Firebase ID token verified in the handler. |
| `paymob-webhook` | `false` | Validates Paymob callback transaction HMAC itself. |
| `reconcile-course-payments` | `false` | Requires a dedicated secret header; scheduled invocation also uses the project API key. |

Keep these settings intact for the five redeployments. `verify_jwt = false` disables Supabase gateway JWT validation; it does not replace the handler-level Firebase, webhook-signature, or secret-header checks described above.

## Database, project configuration, and payout environment

- No tracked change exists in `supabase/config.toml` or `supabase/migrations/`.
- The two existing cron schedule migrations are unchanged. No database migration or schema deployment is required by this function diff.
- No separate `config.toml` deployment is required by this diff; preserve the existing per-function JWT settings when deploying.
- The code introduces a required function environment value, `PAYMOB_PAYOUT_BASE_URL`, read by `_shared/paymob.ts`. Configure it separately in the target Supabase project before enabling withdrawals. The URL itself is not secret. The code accepts only the HTTPS Egypt payout origins `https://payouts.paymobsolutions.com` and `https://stagingpayouts.paymobsolutions.com`; the intended production value is `https://payouts.paymobsolutions.com`. Existing payout client ID, client secret, username, and password must also be present. This project-level environment configuration is a prerequisite, not a database migration. Do not expose credential values in deployment logs or this report.

## Type-check evidence

`deno check` was run on all 12 existing `supabase/functions/*/index.ts` entrypoints in this checkout and exited successfully. All five functions in the redeployment list are included in that pass. The `_shared` test files are not deployable entrypoints and were not counted among the 12.

## Planned deployment commands

After approving the target project, configuring the payout environment for `teacher-withdrawal`, and completing the normal release review, deploy only these functions:

```text
supabase functions deploy create-video-upload --project-ref <approved-project-ref>
supabase functions deploy resume-video-upload --project-ref <approved-project-ref>
supabase functions deploy cancel-video-upload --project-ref <approved-project-ref>
supabase functions deploy get-video-playback-token --project-ref <approved-project-ref>
supabase functions deploy teacher-withdrawal --project-ref <approved-project-ref>
```

No command above was run. This report does not authorize deployment.
