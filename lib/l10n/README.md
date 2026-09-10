# ZarVilla Localization Setup — Step by Step

Everything here mirrors your fintech app's structure, trimmed to English,
Pashto (ps), and Dari (fa) only.

## 1. Add dependencies to `pubspec.yaml`

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  flutter_secure_storage: ^9.2.2
  intl: any          # let flutter_localizations pin the compatible version

flutter:
  generate: true     # required — turns on `flutter gen-l10n` at build time
```

Then run:

```bash
flutter pub get
```

## 2. Add `l10n.yaml` to your project root

(next to `pubspec.yaml`, not inside `lib/`)

Copy `l10n.yaml` from this download into your project root as-is.

## 3. Create the ARB translation files

Create the folder `lib/l10n/arb/` and put these three files in it:
- `app_en.arb` — the template. Every key must exist here first.
- `app_ps.arb` — Pashto translations
- `app_fa.arb` — Dari translations

Copy the three `.arb` files from this download into that folder.
(⚠️ I translated a starter set of keys — have a native Pashto/Dari speaker
proofread before shipping; app-store review and real users will catch
anything off.)

## 4. Generate the localization classes

```bash
flutter gen-l10n
```

This reads `l10n.yaml` + the ARB files and generates
`lib/l10n/generated/app_localizations.dart` — the `AppLocalizations` class
with a typed getter per key (e.g. `AppLocalizations.of(context).appName`).
You don't hand-write this file; it regenerates every time you run/build
the app (because `generate: true` is set), so re-run `flutter gen-l10n`
any time you add a new key to the ARB files.

## 5. Add the folder structure

```
lib/
  app/
    localization/
      app_locales.dart
      language_flag_svgs.dart
      locale_preference.dart
      locale_store.dart
      locale_controller.dart
      fallback_localizations.dart
      localization.dart
  core/
    storage/
      secure_storage.dart
    logging/
      app_logger.dart
  l10n/
    arb/
      app_en.arb
      app_ps.arb
      app_fa.arb
    generated/            <- auto-created by flutter gen-l10n, don't edit
```

Copy each file from this download into the matching path. `secure_storage.dart`
and `app_logger.dart` are new — your fintech app already has these
under `core/`, but a fresh ZarVilla project doesn't yet, so I included
minimal working versions. Swap them for your real implementations later;
nothing else needs to change since they're accessed only through their
providers (`secureStorageProvider`, `appLoggerProvider`).

## 6. Wire it into `main.dart`

See `main_example.dart` in this download for a complete working example:
Riverpod's `ProviderScope`, a bootstrap step that calls
`localeController.restore()` before the app renders, `MaterialApp`
configured with `locale`, `supportedLocales`, `localizationsDelegates`,
and a `Directionality` wrapper so Pashto/Dari force RTL layout. It also
includes a bare-bones language-picker screen you can restyle to match
ZarVilla's black-and-gold branding.

Merge the relevant pieces into your actual `main.dart` and home screen —
don't just drop the file in wholesale if you already have app structure.

## 7. Using translated strings anywhere in the app

```dart
Text(context.l10n.welcomeTitle)
```

`context.l10n` comes from the `LocalizationX` extension in
`localization.dart` — no need to import `AppLocalizations` directly
everywhere.

## 8. Adding a new string later

1. Add the key to `lib/l10n/arb/app_en.arb` (and `app_ps.arb` /
   `app_fa.arb` — every key must exist in all three files or `gen-l10n`
   will fail on the missing ones by default).
2. Run `flutter gen-l10n` (or just hot-restart — it runs automatically
   on build since `generate: true` is set).
3. Use `context.l10n.yourNewKey`.

## What I deliberately left out for now

- **`error_message_mapper.dart`** — this maps your `AppException` subtypes
  (network/auth/validation/business errors) to translated strings. It
  depends on error-handling classes your fintech app already has under
  `core/errors/` that ZarVilla doesn't have yet. Once you build out
  ZarVilla's own error/exception types, this pattern drops in the same
  way: one `switch` mapping exception → `l10n.xxx`.
