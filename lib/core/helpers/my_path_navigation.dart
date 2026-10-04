import 'package:flutter/material.dart';

import '../routing/routes.dart';

/// Extension used across the My Path flow for "replacement" navigation.
///
/// Instead of pushing another screen onto the stack, each visit replaces the
/// current one:
///  - Wizard "Continue" buttons swap the current step for the next one, so
///    the stack never grows past: [previous screen, .., current step].
///  - The final step replaces itself with the My Path hub via
///    [Navigator.pushReplacementNamed], recycling the route instead of
///    stacking a second hub on top.
///
/// Back (system back or the app-bar arrow) therefore pops to the screen the
/// flow was entered from — the stack stays lean and predictable.
extension MyPathReplacement on BuildContext {
  /// Replaces the route below the current My Path step with [routeName],
  /// keeping the hub at a single depth.
  ///
  /// If the current route is the hub itself (studentMyPath), the hub uses
  /// [Navigator.pushReplacementNamed] so the wizard step animates in even
  /// though it replaces the hub.
  void replaceMyPath(String routeName) {
    final current = ModalRoute.of(this);
    final currentName = current?.settings.name;
    if (currentName == AppRoutes.studentMyPath) {
      Navigator.pushReplacementNamed(this, routeName);
      return;
    }
    // Safety net: if the routing table ever re-orders, fall back to a push
    // so the flow can never dead-end.
    if (currentName == null) {
      Navigator.pushNamed(this, routeName);
      return;
    }
    Navigator.pushReplacementNamed(this, routeName);
  }
}
