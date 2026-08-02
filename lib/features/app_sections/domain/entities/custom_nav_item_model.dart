
import 'package:flowery/config/l10n/translations/app_localizations.dart';

class CustomNavItemModel {
  final String Function(AppLocalizations) getLabel;
  final String icon;

  const CustomNavItemModel({
    required this.getLabel,
    required this.icon,
  });
}
