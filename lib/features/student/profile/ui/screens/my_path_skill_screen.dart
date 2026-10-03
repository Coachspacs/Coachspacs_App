import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/my_path_skill/continue_button.dart';
import '../widgets/my_path_skill/roadmap_banner.dart';
import '../widgets/my_path_skill/skill_card.dart';
import '../widgets/my_path_skill/skill_search_bar.dart';

class MyPathSkillScreen extends StatefulWidget {
  const MyPathSkillScreen({super.key});

  @override
  State<MyPathSkillScreen> createState() => _MyPathSkillScreenState();
}

class _MyPathSkillScreenState extends State<MyPathSkillScreen> {
  static const Color backgroundColor = Color(0xFFF7FAF9);
  static const Color primaryColor = Color(0xFF075E4D);
  static const Color textColor = Color(0xFF172B2A);

  String selectedSkill = 'Frontend Web Development';
  String searchQuery = '';

  final List<Map<String, dynamic>> skills = [
    {
      'title': 'Frontend Web Development',
      'description':
          'Build interactive, high-performance user interfaces and responsive web apps.',
      'tags': ['React', 'Next.js', 'TypeScript'],
      'icon': Icons.code,
      'popular': true,
    },
    {
      'title': 'UI/UX & Product Design',
      'description':
          'Design user-centric digital products, design systems, and rapid interactive prototypes.',
      'tags': ['Figma', 'Design Systems', 'User Research'],
      'icon': Icons.edit_outlined,
      'popular': false,
    },
    {
      'title': 'Backend & Cloud Architecture',
      'description':
          'Scalable APIs, distributed microservices, and modern database management.',
      'tags': ['Node.js', 'Python', 'AWS'],
      'icon': Icons.storage_outlined,
      'popular': false,
    },
    {
      'title': 'AI & Data Science',
      'description':
          'Harness LLMs, machine learning pipelines, and predictive data insights.',
      'tags': ['Python', 'TensorFlow', 'Pandas'],
      'icon': Icons.bolt_outlined,
      'popular': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredSkills = skills.where((skill) {
      final title = skill['title'].toString().toLowerCase();
      final query = searchQuery.toLowerCase();

      return title.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 23,
            color: textColor,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        leadingWidth: 52,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          'My Path',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'What skill do you want to learn?',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF172033),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              const RoadmapBanner(),

              const SizedBox(height: 34),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text(
                  'Select your primary focus skill or domain so our AI '
                  'companion can curate tailored modules, practical '
                  'capstones, and personalized learning milestones.',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    height: 1.7,
                    color: const Color(0xFF687894),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SkillSearchBar(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              ...filteredSkills.map(
                (skill) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: SkillCard(
                    title: skill['title'],
                    description: skill['description'],
                    tags: List<String>.from(skill['tags']),
                    icon: skill['icon'],
                    popular: skill['popular'],
                    isSelected: selectedSkill == skill['title'],
                    onTap: () {
                      setState(() {
                        selectedSkill = skill['title'];
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 18),

              ContinueButton(
                onPressed: () {
                  debugPrint(
                    'Selected skill: $selectedSkill',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
