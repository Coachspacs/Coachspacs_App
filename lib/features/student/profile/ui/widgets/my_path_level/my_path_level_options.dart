import 'package:flutter/material.dart';

import '../../../data/models/my_path_models.dart';
import 'my_path_level_card.dart';

class MyPathLevelOptions extends StatelessWidget {
  const MyPathLevelOptions({
    super.key,
    required this.selectedId,
    required this.onSelected,
  });

  final int? selectedId;
  final ValueChanged<MyPathOption> onSelected;

  @override
  Widget build(BuildContext context) {
    final options = MyPathLevelOptionsData.all;
    return Column(
      children: [
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          MyPathLevelCard(
            icon: options[i].icon,
            title: options[i].title,
            description: options[i].description,
            recommended: options[i].recommended,
            skipText: options[i].skipText,
            savesText: options[i].savesText,
            selected: selectedId == options[i].id,
            onTap: () => onSelected(options[i]),
          ),
        ],
      ],
    );
  }
}
