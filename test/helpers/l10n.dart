import 'package:flowery/config/l10n/translations/app_localizations_en.dart';

/// A singleton English [AppLocalizationsEn] instance that can be used in
/// tests as a source of truth for localised strings instead of hard-coding
/// raw string literals.
///
/// Usage:
/// ```dart
/// import '../helpers/l10n.dart';
///
/// expect(find.text(l10n.next), findsOneWidget);
/// ```
final AppLocalizationsEn l10n = AppLocalizationsEn();
