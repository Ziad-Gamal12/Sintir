# SINTIR Localization Audit

Audit date: 2026-11-03.

## Catalog checks

- assets/l10n/en.json, ar.json, and fr.json each have 915 keys, matching key sets, and zero blank string values.
- 38 values in each of lib/l10n/intl_en.arb and intl_ar.arb have no missing Arabic keys.
- Value comparison flags 38 French strings and 3 Arabic strings identical to English. Some are provider names, currencies, units, or technical labels; fluent review is needed before classifying them as missing translations.
- Checkout localization tests cover en/ar/fr and passed. UI tests emitted Localingo “No context available” warnings when translation context was absent in the test harness; tests did not fail.

## RTL and formatting

LocaleCubit supports en/ar/fr and MaterialApp receives the chosen locale with Flutter localization delegates. This does not verify every custom Directionality, icon order, text alignment, keyboard, or responsive layout.
Some payment/transaction formatting uses intl and the active locale. A feature-by-feature date/currency review was not completed.

No catalog or RTL fixes were made. Translation quality, plurals/context, and device RTL rendering still need fluent and visual review.
