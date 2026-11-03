import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfoloio_1/View/sections/about_section.dart';
import 'package:portfoloio_1/View/sections/contact_section.dart';
import 'package:portfoloio_1/View/sections/experience_section.dart';
import 'package:portfoloio_1/View/sections/hero_section.dart';
import 'package:portfoloio_1/View/sections/projects_section.dart';
import 'package:portfoloio_1/View/sections/skills_section.dart';
import 'package:portfoloio_1/View/widgets/nav_bar.dart';
import 'package:portfoloio_1/core/theme.dart';

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
    // 1. Try Uri.base resolved URL (absolute URL on current domain e.g. https://domain/SREERAGCV.pdf)
    final webUri = Uri.base.resolve('SREERAGCV.pdf');
    try {
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
        return;
      }
    } catch (_) {}

    // 2. Direct launch without canLaunchUrl check
    try {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
      return;
    } catch (_) {}

    // 3. Fallback: assets path
    final assetUri = Uri.base.resolve('assets/SREERAGCV.pdf');
    try {
      await launchUrl(assetUri, mode: LaunchMode.externalApplication);
      return;
    } catch (_) {}

    // 4. Fallback relative URL
    try {
      await launchUrl(Uri.parse('SREERAGCV.pdf'), mode: LaunchMode.externalApplication);
    } catch (_) {}
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
      floatingActionButton: _FloatingResumePill(onTap: _downloadCV),
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
              child: AboutSection(onDownloadCV: _downloadCV),
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
              child: ExperienceSection(onDownloadCV: _downloadCV),
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

class _FloatingResumePill extends StatefulWidget {
  final VoidCallback onTap;

  const _FloatingResumePill({required this.onTap});

  @override
  State<_FloatingResumePill> createState() => _FloatingResumePillState();
}

class _FloatingResumePillState extends State<_FloatingResumePill>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.06 : 1.0,
        duration: const Duration(milliseconds: 180),
        child: AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            final glowValue = _glowController.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 12, right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(
                      alpha: _hovered ? 0.6 : 0.25 + (glowValue * 0.2),
                    ),
                    blurRadius: _hovered ? 24 : 14 + (glowValue * 8),
                    spreadRadius: _hovered ? 2 : 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: widget.onTap,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.surface.withValues(alpha: 0.92),
                              AppColors.card.withValues(alpha: 0.92),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Color.lerp(
                              AppColors.accent,
                              AppColors.accentBlue,
                              glowValue,
                            )!.withValues(alpha: _hovered ? 0.9 : 0.6),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.accent.withValues(alpha: 0.2),
                              ),
                              child: const Icon(
                                Icons.description_rounded,
                                size: 16,
                                color: AppColors.accent,
                              ),
                            ),
                            const SizedBox(width: 9),
                            Text(
                              'Resume',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'PDF',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
