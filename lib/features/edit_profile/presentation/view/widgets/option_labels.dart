import 'package:flowery/config/l10n/translations/app_localizations.dart';

String goalLabel(AppLocalizations l10n, String value) {
  switch (value) {
    case 'Gain Weight':
      return l10n.goal_gain_weight;
    case 'Lose Weight':
      return l10n.goal_lose_weight;
    case 'Get Fitter':
      return l10n.goal_get_fitter;
    case 'Gain More Flexible':
      return l10n.goal_gain_more_flexible;
    case 'Learn The Basic':
      return l10n.goal_learn_basic;
    default:
      return value;
  }
}

String activityLevelLabel(AppLocalizations l10n, String value) {
  switch (value) {
    case 'level1':
      return l10n.activity_rookie;
    case 'level2':
      return l10n.activity_beginner;
    case 'level3':
      return l10n.activity_intermediate;
    case 'level4':
      return l10n.activity_advance;
    case 'level5':
      return l10n.activity_true_beast;
    default:
      return value;
  }
}
