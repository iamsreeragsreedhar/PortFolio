import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfoloio_1/Controller/links.dart';
import 'package:portfoloio_1/core/theme.dart';
import 'package:portfoloio_1/View/widgets/section_header.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _openEmail(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: emailAddress));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: AppColors.accent, width: 1.2),
          ),
          content: Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.accent,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Email copied to clipboard: $emailAddress',
                  style: GoogleFonts.inter(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }

    final uri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': 'Flutter Developer Role / Collaboration',
        'body': 'Hi Sreerag,\n\nI came across your portfolio and would love to connect with you regarding...',
      },
    );
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (_) {}
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 860;

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 80,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              const SectionHeader(
                title: "Let's Build Something Exceptional",
                subtitle: 'Get in touch & collaborate',
              ),
              const SizedBox(height: 20),

              Text(
                'Looking for an experienced Flutter engineer to craft clean, high-performance apps?\nMy inbox is open for new opportunities, freelance contracts, and technical discussions.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.7,
                ),
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 24),

              // Live Status Terminal Pill
              _liveStatusBadge().animate().fadeIn(delay: 300.ms),

              const SizedBox(height: 50),

              // Contact Cards
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _ContactHubCard(
                    icon: FontAwesomeIcons.envelope,
                    label: 'Direct Email',
                    value: emailAddress,
                    actionText: 'Copy & Send Mail',
                    accentColor: AppColors.accent,
                    onTap: () => _openEmail(context),
                    delay: 100,
                  ),
                  _ContactHubCard(
                    icon: FontAwesomeIcons.linkedin,
                    label: 'LinkedIn Profile',
                    value: 'sreerag-sreedhar',
                    actionText: 'Connect on LinkedIn',
                    accentColor: AppColors.accentBlue,
                    onTap: () => _openUrl(linkedInUrl),
                    delay: 200,
                  ),
                  _ContactHubCard(
                    icon: FontAwesomeIcons.github,
                    label: 'GitHub Repositories',
                    value: 'iamsreeragsreedhar',
                    actionText: 'View Open Source',
                    accentColor: AppColors.accentPurple,
                    onTap: () => _openUrl(githubUrl),
                    delay: 300,
                  ),
                ],
              ),

              const SizedBox(height: 70),

              // Modern Footer
              _footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _liveStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.accentGreen.withValues(alpha: 0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGreen.withValues(alpha: 0.12),
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentGreen,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentGreen,
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'STATUS: AVAILABLE FOR FULL-TIME ROLES & CONSULTING',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppColors.accentGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return Column(
      children: [
        Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.white.withValues(alpha: 0.12),
                Colors.transparent,
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Designed & Engineered with ',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const Icon(
              Icons.favorite_rounded,
              color: AppColors.accentPink,
              size: 14,
            ),
            Text(
              ' in Flutter',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '© 2026 Sreerag PS · All Rights Reserved',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 500.ms);
  }
}

class _ContactHubCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final String actionText;
  final Color accentColor;
  final VoidCallback onTap;
  final int delay;

  const _ContactHubCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.actionText,
    required this.accentColor,
    required this.onTap,
    required this.delay,
  });

  @override
  State<_ContactHubCard> createState() => _ContactHubCardState();
}

class _ContactHubCardState extends State<_ContactHubCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: 280,
            padding: const EdgeInsets.all(26),
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
                      ? widget.accentColor.withValues(alpha: 0.18)
                      : Colors.black.withValues(alpha: 0.3),
                  blurRadius: _hovered ? 30 : 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: widget.accentColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: widget.accentColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Center(
                    child: FaIcon(
                      widget.icon,
                      color: widget.accentColor,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  widget.label,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.value,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.actionText,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: widget.accentColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_outward_rounded,
                      size: 13,
                      color: widget.accentColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: widget.delay))
        .slideY(begin: 0.2, curve: Curves.easeOutCubic);
  }
}
