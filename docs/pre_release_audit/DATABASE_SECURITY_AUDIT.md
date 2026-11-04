# Database and authorization audit

## Database inventory

The business database used by both Flutter apps and Supabase functions is Firebase Firestore. Reviewed collections include `Users`, nested `Courses`, `Sections`, `Items`, `Subscribers`, `Transactions`, `CoursePaymentAttempts`, `CourseCheckoutLocks`, `MuxVideoIndex`, and `MuxWebhookEvents`. Supabase is used for Edge Functions, Storage, Cron and `pg_net`; no application SQL schema or RLS migrations were present. The two SQL migrations only schedule course-payment and teacher-withdrawal reconciliation through Vault secrets.

## Firestore rules

`firebase.json` in both repositories does not configure Firestore or Storage rules. The mobile repository includes `firestore.rules.proposed`, which is not included in Firebase CLI deploy configuration. The dashboard repository does not contain a complete active ruleset. Direct mobile/dashboard Firestore reads and writes depend on the deployed project rules, which are not available from local source.

**P1 release blocker:** cannot verify user ownership, role/status authority, course read scope, wallet/transaction write denial, subscription writes, Mux metadata ownership, or dashboard admin actions. Do not treat `firestore.rules.proposed` or front-end guards as active security.

## Supabase policies and migrations

Only two migrations exist, both invoking Edge Functions every five minutes with server credentials in Supabase Vault. There are no SQL tables, RLS policies, database triggers, constraints, or pgTAP tests for app data because the app data is in Firestore. Migrations were not applied or tested: Docker/Podman are absent and the CLI `status` reports no local container runtime. No remote `db push` or deployment was performed.

## Required next steps

1. Export the actual deployed Firestore and Storage rules through the project owner; review change history and service-account IAM.
2. Configure Firebase Emulator with the complete ruleset; test unauthenticated, cross-user, student, teacher, admin, blocked, and suspended roles for every referenced collection.
3. Test wallet/payment writes and Mux-managed fields as direct clients; require server-only writes for balances, payment attempts, webhook events, and Mux index fields.
4. Apply the two scheduling migrations only in a disposable local/approved staging database first; verify Vault secret names, job schedule, responses, retries, and least-privilege access.
5. Confirm deployed Edge Function versions/secrets and webhook callback targets separately. No live project state was read in this audit.
