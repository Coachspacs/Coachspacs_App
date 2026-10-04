import 'package:flutter/material.dart';

import '../../../data/models/my_path_models.dart';
import 'my_path_goal_card.dart';

class MyPathGoalOptions extends StatelessWidget {
  const MyPathGoalOptions({
    super.key,
    required this.selectedId,
    required this.onSelected,
  });

  final int? selectedId;
  final ValueChanged<MyPathOption> onSelected;

  @override
  Widget build(BuildContext context) {
    final options = MyPathGoalOptionsData.all;
    return Column(
      children: [
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(height: 14),
          MyPathGoalCard(
            icon: options[i].icon,
            title: options[i].title,
            description: options[i].description,
            badge: options[i].badge,
            recommendedText: options[i].recommendedText,
            activeText: options[i].activeText,
            selected: selectedId == options[i].id,
            onTap: () => onSelected(options[i]),
          ),
        ],
      ],
    );
  }
}
