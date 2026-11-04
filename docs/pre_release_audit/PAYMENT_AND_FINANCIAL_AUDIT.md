# Payment and financial audit

## Checkout flow and trust

`CourseCheckoutRepoImpl` sends Firebase ID tokens to `course-checkout-quote`, `create-course-payment`, `get-course-payment-status`, and `check-course-subscription`. The function source derives price, coupon, and amount from Firestore in integer cents; it stores attempt/idempotency and checkout-lock state before requesting Paymob. The client does not supply an authoritative payable amount. Redirect/success-looking URLs resume server status checks and do not grant enrollment.

`paymob-webhook` checks the ordered callback HMAC, transaction/order/reference, exact cents, EGP, allowed integration ID, and attempt state before shared fulfillment. Fulfillment updates enrollment/subscriber/course count, teacher wallet, transaction records, coupon usage, and attempt state transactionally. Duplicate terminal callbacks do not repeat fulfillment. Reconciliation retains locks/reservations when evidence is missing, ambiguous, refunded, or mismatched.

## Withdrawal flow

`teacher-withdrawal` validates teacher role/status/wallet state, amount bounds/cents, issuer and phone prefix, then atomically reserves available balance and creates a withdrawal record before provider I/O. Idempotency requires the same UUID and identical request payload. Definitive provider failure restores once; success consumes the reservation; unknown/pending states remain reserved for reconciliation or Admin manual resolution. Provider identity is checked against transaction ID, amount, issuer, phone, and reference.

## Fixes and findings

- **Fixed P1:** the Paymob payout base host was fixed to Egypt staging. `PAYMOB_PAYOUT_BASE_URL` is now mandatory and allows only the exact HTTPS staging and production origins. Missing URL/credentials fail before funds are reserved. Deno tests validate production/staging acceptance and unsafe-origin rejection.
- **Release blocker:** production endpoint, Paymob payout credentials, Accept API key, integration IDs, HMAC, webhook callbacks, and runtime secret state cannot be verified here. Local ops documentation records that `PAYMOB_API_KEY` was missing in a prior runtime check; the current live state is unknown.
- The merchant must configure `https://payouts.paymobsolutions.com` for production and staging host only for isolated staging credentials. Paymob’s official [Payout API docs](https://developers.paymob.com/paymob-docs/developers/payouts-apis/auth/generate-auth-token) and [official Postman collections](https://github.com/PaymobAccept/API-Postman-Collections) list the Egypt staging and production origins.
- The payout reconciler intentionally leaves no-provider-ID records reserved for manual provider verification. This avoids duplicate payouts but may hold teacher funds indefinitely if Paymob cannot provide a transaction ID. Operational runbooks and support SLAs are needed.
- The mobile withdrawal idempotency snapshot in plain SharedPreferences contains phone and payment request metadata. Move it to Flutter Secure Storage with an upgrade migration that preserves pending requests.
- Dashboard displays and can query financial data; authorization remains dependent on unverified Firestore rules.

## Tests and limits

Checkout/withdrawal shared helper tests, HMAC tests, idempotency, coupon reservation and recovery tests are included in 32 passing Deno tests. Mobile checkout tests are included in 77 passing Flutter tests. No Paymob sandbox request, real or sandbox payment, payout, webhook HTTP delivery, live reconciliation, or balance mutation was performed. There is no local Firestore emulator.
