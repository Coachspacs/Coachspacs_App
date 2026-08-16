import 'package:flutter/material.dart';

import 'package:coach_space/l10n/app_localizations.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
