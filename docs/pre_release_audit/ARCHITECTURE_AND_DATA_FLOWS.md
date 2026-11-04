# Architecture map and sensitive data flows

This map reflects source in both local repositories. Firebase/Supabase deployed configuration and live policies were not available, so the diagrams show source-level flows rather than production proof.

## Architecture map

```mermaid
flowchart LR
  subgraph Mobile[Flutter mobile app: sintir]
    UI[Feature routes and widgets]
    State[BLoC/Cubit]
    Repo[Repositories and services]
    Local[Hive encrypted profile\nSharedPreferences and HydratedBloc]
    UI --> State --> Repo
    Repo <--> Local
  end
  subgraph Dashboard[Flutter admin dashboard: sintir_dashboard]
    DUI[Admin/manager views]
    DCubit[UserCubit and feature cubits]
    DRepos[Firestore repositories and Dio]
    DUI --> DCubit --> DRepos
  end
  Auth[Firebase Authentication]
  DB[(Firestore collections)]
  Functions[Supabase Edge Functions\nFirebase JWT verification]
  Storage[Supabase Storage]
  Paymob[Paymob checkout and payouts]
  Mux[Mux upload, webhook, signed playback]
  Mobile --> Auth
  Mobile --> DB
  Mobile --> Functions
  Mobile --> Storage
  Dashboard --> Auth
  Dashboard --> DB
  Dashboard --> Functions
  Functions --> DB
  Functions --> Paymob
  Functions --> Mux
  Mux -->|signed events| Functions
  Paymob -->|HMAC webhook / inquiry| Functions
```

Mobile startup initializes Firebase, Supabase Storage, SharedPreferences, Hive, HydratedBloc, dependency injection, global cubits, and GoRouter. The app has 18 feature modules and 1,144 Dart files (prior inventory). Dashboard is a separate Flutter web/mobile-capable repo with management views and direct Firestore repositories; analytics calls Supabase functions. Payment, Mux, and withdrawal Edge Function source is present in `sintir_dashboard/supabase/functions/`.

## Authentication, session, profile, logout

```mermaid
sequenceDiagram
  actor User
  participant App as Flutter client
  participant Firebase as Firebase Auth
  participant Store as Firestore
  participant Hive as Encrypted Hive
  User->>App: email or social sign-in
  App->>Firebase: authenticate
  Firebase-->>App: Firebase user/session
  App->>App: read device identifier
  App->>Store: fetch profile / update deviceId
  Store-->>App: role, status, profile
  App->>Hive: persist UserData map
  User->>App: logout
  App->>Firebase: sign out
  App->>Hive: delete UserData key in finally
  Note over App,Hive: Global theme/locale and encryption key remain
```

`AuthRepoImpl` fetches an active profile and stores it locally. One-device handling persists a device ID field; actual concurrent-session enforcement depends on backend rules/flows and was not verified as an independent server policy. Route guards and cached role are not authorization. The previous audit fix makes empty local profile data return `UserEntity.empty()`.

## Course access, video upload, playback, subscription

```mermaid
sequenceDiagram
  actor Teacher
  actor Student
  participant App as Flutter client
  participant EF as Supabase video functions
  participant DB as Firestore
  participant Mux
  Teacher->>App: select course/video
  App->>EF: create-video-upload + Firebase ID token
  EF->>DB: verify active Teacher and course owner
  EF->>Mux: create signed direct upload
  EF->>DB: create item + MuxVideoIndex
  EF-->>App: temporary upload URL
  App->>Mux: upload 5 MiB chunks
  Mux->>EF: signed lifecycle webhook
  EF->>DB: update item + create MuxWebhookEvents record
  Student->>App: open subscribed course video
  App->>EF: get-video-playback-token + Firebase ID token
  EF->>DB: verify active role, course, ready item, both enrollment records
  EF->>Mux: sign short-lived playback JWT locally
  EF-->>App: HLS URL/token held in memory
```

Course subscription and playback are separate concepts: subscription/payment functions create the Firestore enrollment records; playback requires both `Users/{uid}/Courses/{courseId}` and `Courses/{courseId}/Subscribers/{uid}`. A source guard that prevented students reaching this check was fixed and has helper regression tests.

## Course checkout and payment confirmation

```mermaid
sequenceDiagram
  actor Student
  participant App as Flutter client
  participant EF as Checkout Edge Functions
  participant DB as Firestore
  participant Paymob
  Student->>App: choose course/coupon
  App->>EF: quote + Firebase ID token
  EF->>DB: load authoritative course/coupon/entitlement data
  EF-->>App: amount in integer cents
  App->>EF: create payment + idempotency key
  EF->>DB: reserve attempt/lock/coupon before provider call
  EF->>Paymob: create hosted intention
  Paymob-->>App: hosted checkout URL
  Student->>Paymob: pay
  Paymob->>EF: transaction callback + HMAC
  EF->>DB: verify callback and atomically fulfill records
  App->>EF: poll status after return
  EF-->>App: backend-confirmed status
```

The trusted amount and fulfillment boundary is the Edge Function plus Firestore transaction; a return URL or client status is not payment authority. An ambiguous provider response retains reservation for inquiry/reconciliation.

## Wallet and teacher withdrawal

```mermaid
sequenceDiagram
  actor Teacher
  participant App as Flutter client
  participant EF as teacher-withdrawal
  participant DB as Firestore
  participant Paymob
  Teacher->>App: request amount and wallet destination
  App->>App: persist idempotency snapshot in SharedPreferences
  App->>EF: create request + Firebase ID token
  EF->>EF: verify payout origin/credentials and request constraints
  EF->>DB: atomically reserve available balance and create withdrawal
  EF->>Paymob: disburse via configured staging/production host
  Paymob-->>EF: provider result
  EF->>DB: correlate provider result and settle or retain reservation
  App->>EF: reconcile pending withdrawal
  EF->>Paymob: inquiry by transaction ID
  EF->>DB: settle once, or keep funds reserved for review
```

The client idempotency snapshot preserves ambiguous retries but contains personal payout information in plain SharedPreferences. This remains a P2 item. No actual payout was initiated.
