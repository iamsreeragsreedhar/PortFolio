import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfoloio_1/View/sections/about_section.dart';
import 'package:portfoloio_1/View/sections/contact_section.dart';
import 'package:portfoloio_1/View/sections/experience_section.dart';
import 'package:portfoloio_1/View/sections/hero_section.dart';
import 'package:portfoloio_1/View/sections/projects_section.dart';
import 'package:portfoloio_1/View/sections/skills_section.dart';
import 'package:portfoloio_1/View/widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> _downloadCV() async {
    final uri = Uri.parse('assets/SREERAGCV.pdf');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (_) {
      // Graceful fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final navItems = [
      {'title': 'Home', 'onTap': () => _scrollTo(_heroKey)},
      {'title': 'About', 'onTap': () => _scrollTo(_aboutKey)},
      {'title': 'Skills', 'onTap': () => _scrollTo(_skillsKey)},
      {'title': 'Projects', 'onTap': () => _scrollTo(_projectsKey)},
      {'title': 'Experience', 'onTap': () => _scrollTo(_experienceKey)},
      {'title': 'Contact', 'onTap': () => _scrollTo(_contactKey)},
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NavBar(
        navItems: navItems,
        onDownloadCV: _downloadCV,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            KeyedSubtree(
              key: _heroKey,
              child: HeroSection(
                onDownloadCV: _downloadCV,
                onContactTap: () => _scrollTo(_contactKey),
              ),
            ),
            KeyedSubtree(
              key: _aboutKey,
              child: const AboutSection(),
            ),
            KeyedSubtree(
              key: _skillsKey,
              child: const SkillsSection(),
            ),
            KeyedSubtree(
              key: _projectsKey,
              child: const ProjectsSection(),
            ),
            KeyedSubtree(
              key: _experienceKey,
              child: const ExperienceSection(),
            ),
            KeyedSubtree(
              key: _contactKey,
              child: const ContactSection(),
            ),
          ],
        ),
      ),
    );
  }
}
