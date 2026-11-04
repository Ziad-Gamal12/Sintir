# Screen capture and educational content protection

## Current implementation

- `SensitivePageWrapper` wraps the Mux video screen, course test, file preview, teacher wallet details, and exam consequences. Other routes do not use it.
- It creates `SecureContentScope(enabled: true, protectInAppSwitcher: true)` with integrity checks and a generic risk watermark (`Sintir - Sensitive Content`). The watermark does not include verified per-user identity.
- The locked `secure_content` 3.0.0 Android plugin dynamically adds/removes `FLAG_SECURE` for enabled scopes and tests nested window protection in its package. The app’s `MainActivity` no longer globally sets this flag, so ordinary screens are unaffected.
- `PrivacyWrapper` overlays the whole Flutter app with black whenever lifecycle state is anything other than `resumed`; this is intended to mask the app-switcher snapshot. No lifecycle device test was run.
- iOS plugin source observes `UIScreen.isCaptured`/scene capture state and adds overlays; it observes screenshot notifications after a screenshot has been taken. iOS does not prevent screenshots. The wrapper cannot guarantee that a screenshot is never saved.
- Search found no app-level biometric authentication flow. The secure-content package supports related features, but the app does not invoke its biometric API.

## Lifecycle and limits

Android’s secure window flag is scope-managed by the plugin. iOS recording/mirroring detection masks content while capture is active; a notification cannot undo a screenshot already captured. App-switcher masking is a Flutter overlay and is not validated for every rapid background/foreground transition. Rooted/jailbroken devices, external cameras, and filming another display remain outside platform prevention.

The generic watermark avoids displaying another account’s identity, but offers limited attribution. Add a user-specific watermark only from the authenticated server profile and clear it at logout; avoid trusting stale cached identity.

## Verification status

Source/plugin review only. No Android emulator, iOS device, screen-capture test, screen recording, external display, app-switcher, lock/resume, or route-stack test was available. iOS archive/device validation is blocked by the Windows host. No screenshot evidence was captured in this audit.

## Remaining work

Run capture tests on supported Android/iOS versions for each protected route, navigation overlap, dialogs, route pop, home/app switch, lock, interruption, rapid resume, logout, and external display. Verify playback pauses or is masked during recording. Capture screenshots only with synthetic test data. Review whether protected financial/profile views need the same wrapper.
