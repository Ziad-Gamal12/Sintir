# Mux and media metadata audit

## Storage model

Mux metadata is stored in Firestore, not a Supabase SQL database. New app collections are created by the Edge Function write paths:

| Collection | Purpose / fields | Relationships / controls |
|---|---|---|
| `MuxVideoIndex/{videoId}` | `courseId`, `sectionId`, `videoId` lookup from Mux passthrough | Created atomically with the course item during upload creation; webhook reads it to resolve the authoritative course path. |
| `MuxWebhookEvents/{eventId}` | event type, video ID, receive time | Created in the same Firestore transaction as the course item update; create precondition prevents repeated event application. |
| `Courses/{course}/Sections/{section}/Items/{video}` | video provider, Mux upload/asset/playback IDs, status, size, MIME, duration, dimensions, available qualities, creator and timestamps | Upload function creates initial record; webhook updates server-owned Mux fields. |

There is no SQL table, migration, RLS policy, or Firestore rule file configuring these collections in the active Firebase CLI config. The proposed rules file is not wired to `firebase.json`.

## Lifecycle and authorization

1. An active owning Teacher requests a Mux Direct Upload. The server creates a signed-policy Mux upload and Firestore metadata/index records.
2. Client streams 5 MiB chunks directly to the returned upload URL. The URL remains in memory and can be retried during the active session; app termination loses it.
3. Mux posts a signed event. The webhook checks HMAC over the raw body and a five-minute timestamp window, resolves the video index and parent item, then atomically updates status and records the event ID.
4. Playback issues a server-signed RS256 token only for a ready video after active teacher ownership or student enrollment checks. The audit fixed a preceding teacher-only guard that blocked students.

## Findings and remaining work

- Event IDs provide duplicate delivery protection. Unknown video IDs are acknowledged as ignored and are not recorded; no security boundary relies on the passthrough string alone.
- `MuxWebhookEvents` has no retention/TTL policy in this repository. Indefinite records increase storage and are a retention/cost question; agree a safe idempotency window before pruning.
- `MuxVideoIndex` cleanup for cancelled/deleted videos is not defined; no data was deleted.
- Actual Firestore authorization preventing client writes to Mux-managed fields and these top-level collections is unverified.
- No Mux API, webhook, upload, playback, or real asset was exercised. Deno tests cover only authorization predicate and helper behavior; all Edge Function entry points type-check.
- Signed playback URL is returned to the client and held in memory with a token lifetime between one and 24 hours based on video duration. Logout cannot revoke a token already issued; device-level disposal/expiry test remains.
