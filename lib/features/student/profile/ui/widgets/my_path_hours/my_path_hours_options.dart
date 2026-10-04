import 'package:flutter/material.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';

import '../../../data/models/my_path_models.dart';
import 'my_path_hours_card.dart';

class MyPathHoursOptions extends StatelessWidget {
  const MyPathHoursOptions({
    super.key,
    required this.selectedId,
    required this.onSelected,
  });

  final int? selectedId;
  final ValueChanged<MyPathOption> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final options = [
      MyPathOption(
        id: 0,
        icon: Icons.coffee_outlined,
        title: l10n.myPathHoursOneTwoTitle,
        description: l10n.myPathHoursOneTwoDescription,
      ),
      MyPathOption(
        id: 1,
        icon: Icons.tune_rounded,
        title: l10n.myPathHoursThreeFiveTitle,
        description: l10n.myPathHoursThreeFiveDescription,
        badge: l10n.commonRecommended,
      ),
      MyPathOption(
        id: 2,
        icon: Icons.trending_up_rounded,
        title: l10n.myPathHoursSixTenTitle,
        description: l10n.myPathHoursSixTenDescription,
      ),
      MyPathOption(
        id: 3,
        icon: Icons.local_fire_department_outlined,
        title: l10n.myPathHoursMoreThanTenTitle,
        description: l10n.myPathHoursMoreThanTenDescription,
      ),
    ];

    return Column(
      children: [
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          MyPathHoursCard(
            icon: options[i].icon,
            title: options[i].title,
            description: options[i].description,
            badge: options[i].badge,
            selected: selectedId == options[i].id,
            onTap: () => onSelected(options[i]),
          ),
        ],
      ],
    );
  }
}
