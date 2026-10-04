import 'package:flutter/material.dart';

import '../../../data/models/my_path_models.dart';
import 'skill_card.dart';

class SkillOptions extends StatelessWidget {
  const SkillOptions({
    super.key,
    required this.options,
    required this.selectedId,
    required this.onSelected,
  });

  final List<MyPathSkillOption> options;
  final int? selectedId;
  final ValueChanged<MyPathSkillOption> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < options.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: SkillCard(
              title: options[i].title,
              description: options[i].description,
              tags: options[i].tags,
              icon: options[i].icon,
              popular: options[i].popular,
              isSelected: selectedId == options[i].id,
              onTap: () => onSelected(options[i]),
            ),
          ),
      ],
    );
  }
}
