import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfoloio_1/core/constants.dart';
import 'package:portfoloio_1/core/theme.dart';
import 'package:portfoloio_1/View/widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 860;

    return Container(
      width: double.infinity,
      color: AppColors.bg,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 80,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionHeader(
                title: 'Skills & Tech Stack',
                subtitle: 'Engineering capabilities & toolkit',
              ),
              const SizedBox(height: 50),

              // 4 Domain Architecture Cards Grid
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _domainCard(
                    context,
                    title: 'Mobile & Cross-Platform',
                    subtitle: 'Multi-Factor Responsive Applications',
                    icon: Icons.devices_rounded,
                    accentColor: AppColors.accent,
                    skills: [
                      {'name': 'Flutter Framework', 'level': 95},
                      {'name': 'Dart Language', 'level': 92},
                      {'name': 'Cross-Platform UI (Web/Win)', 'level': 92},
                      {'name': 'Material & Cupertino Polish', 'level': 90},
                    ],
                    maxWidth: isMobile ? w - 40 : 540,
                    delay: 100,
                  ),
                  _domainCard(
                    context,
                    title: 'Architecture & State',
                    subtitle: 'Scalable Enterprise Logic',
                    icon: Icons.account_tree_rounded,
                    accentColor: AppColors.accentPurple,
                    skills: [
                      {'name': 'BLoC & Cubit Patterns', 'level': 92},
                      {'name': 'Clean Architecture & MVVM', 'level': 90},
                      {'name': 'GoRouter & Deep Linking', 'level': 88},
                      {'name': 'Provider & GetX Refactoring', 'level': 85},
                    ],
                    maxWidth: isMobile ? w - 40 : 540,
                    delay: 200,
                  ),
                  _domainCard(
                    context,
                    title: 'Backend, APIs & Databases',
                    subtitle: 'Full-Stack Data Synchronization',
                    icon: Icons.cloud_sync_rounded,
                    accentColor: AppColors.accentBlue,
                    skills: [
                      {'name': 'RESTful API Engineering', 'level': 90},
                      {'name': 'Firebase Auth & Firestore', 'level': 85},
                      {'name': 'Node.js & Express Services', 'level': 78},
                      {'name': 'Oracle DB & SQL Persistence', 'level': 78},
                    ],
                    maxWidth: isMobile ? w - 40 : 540,
                    delay: 300,
                  ),
                  _domainCard(
                    context,
                    title: 'Offline-First & Analytics',
                    subtitle: 'Performance, Charts & Tooling',
                    icon: Icons.insights_rounded,
                    accentColor: AppColors.accentPink,
                    skills: [
                      {'name': 'fl_chart & Data Visualization', 'level': 88},
                      {'name': 'Hive & Local DB Persistence', 'level': 85},
                      {'name': 'Git, GitHub CI/CD & FVM', 'level': 85},
                      {'name': 'PDF Generation & Barcode Scans', 'level': 88},
                    ],
                    maxWidth: isMobile ? w - 40 : 540,
                    delay: 400,
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Individual Skill Tags Cloud with Neon Badges
              _skillChipsCloud(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _domainCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required List<Map<String, dynamic>> skills,
    required double maxWidth,
    required int delay,
  }) {
    return _DomainCardWidget(
      title: title,
      subtitle: subtitle,
      icon: icon,
      accentColor: accentColor,
      skills: skills,
      maxWidth: maxWidth,
      delay: delay,
    );
  }

  Widget _skillChipsCloud(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.terminal_rounded,
                color: AppColors.accent,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'COMPREHENSIVE TECH ECOSYSTEM',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 12,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: AppData.skills.map((skill) {
              final level = int.parse(skill['level']!);
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      skill['name']!,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '$level%',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1);
  }
}

class _DomainCardWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final List<Map<String, dynamic>> skills;
  final double maxWidth;
  final int delay;

  const _DomainCardWidget({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.skills,
    required this.maxWidth,
    required this.delay,
  });

  @override
  State<_DomainCardWidget> createState() => _DomainCardWidgetState();
}

class _DomainCardWidgetState extends State<_DomainCardWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: widget.maxWidth,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.cardHover : AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? widget.accentColor.withValues(alpha: 0.7)
                : AppColors.border,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? widget.accentColor.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.25),
              blurRadius: _hovered ? 30 : 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.accentColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: widget.accentColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.accentColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        widget.subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Skills progress items
            ...widget.skills.map((skill) {
              final String name = skill['name'] as String;
              final int level = skill['level'] as int;

              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '$level%',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: widget.accentColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Stack(
                        children: [
                          Container(
                            height: 6,
                            width: double.infinity,
                            color: AppColors.surface,
                          ),
                          AnimatedFractionallySizedBox(
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeOutCubic,
                            widthFactor: level / 100.0,
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    widget.accentColor.withValues(alpha: 0.6),
                                    widget.accentColor,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  if (_hovered)
                                    BoxShadow(
                                      color: widget.accentColor,
                                      blurRadius: 6,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: widget.delay))
        .slideY(begin: 0.15, curve: Curves.easeOutCubic);
  }
}
