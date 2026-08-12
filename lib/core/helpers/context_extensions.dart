import 'package:flutter/widgets.dart';

import 'package:coach_space/l10n/app_localizations.dart';

/// Convenience accessor for localized strings.
extension ContextL10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
