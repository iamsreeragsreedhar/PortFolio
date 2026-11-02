import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfoloio_1/core/constants.dart';
import 'package:portfoloio_1/core/theme.dart';
import 'package:portfoloio_1/View/widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              const SectionHeader(
                title: 'Professional Journey',
                subtitle: 'Proven enterprise experience',
              ),
              const SizedBox(height: 60),

              ...AppData.experience.asMap().entries.map(
                    (e) => _CyberTimelineItem(
                      data: e.value,
                      isLast: e.key == AppData.experience.length - 1,
                      delay: e.key * 200,
                      isCurrent: e.key == 0,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CyberTimelineItem extends StatefulWidget {
  final Map<String, String> data;
  final bool isLast;
  final int delay;
  final bool isCurrent;

  const _CyberTimelineItem({
    required this.data,
    required this.isLast,
    required this.delay,
    required this.isCurrent,
  });

  @override
  State<_CyberTimelineItem> createState() => _CyberTimelineItemState();
}

class _CyberTimelineItemState extends State<_CyberTimelineItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 860;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vertical Timeline Column with Beacon Node
          SizedBox(
            width: 44,
            child: Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.isCurrent
                        ? AppColors.accent
                        : AppColors.accentPurple,
                    boxShadow: [
                      BoxShadow(
                        color: (widget.isCurrent
                                ? AppColors.accent
                                : AppColors.accentPurple)
                            .withValues(alpha: widget.isCurrent ? 0.6 : 0.35),
                        blurRadius: 14,
                        spreadRadius: widget.isCurrent ? 3 : 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.bg,
                      ),
                    ),
                  ),
                ),
                if (!widget.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.accent.withValues(alpha: 0.6),
                            AppColors.accentPurple.withValues(alpha: 0.2),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Content Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: widget.isLast ? 0 : 44),
              child: MouseRegion(
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) => setState(() => _hovered = false),
                child: AnimatedScale(
                  scale: _hovered ? 1.02 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    padding: const EdgeInsets.all(26),
                    decoration: BoxDecoration(
                      color: _hovered ? AppColors.cardHover : AppColors.card,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _hovered
                            ? (widget.isCurrent
                                ? AppColors.accent.withValues(alpha: 0.6)
                                : AppColors.accentPurple.withValues(alpha: 0.6))
                            : AppColors.border,
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _hovered
                              ? (widget.isCurrent
                                      ? AppColors.accent
                                      : AppColors.accentPurple)
                                  .withValues(alpha: 0.14)
                              : Colors.black.withValues(alpha: 0.25),
                          blurRadius: _hovered ? 30 : 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row with period and status badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: (widget.isCurrent
                                        ? AppColors.accent
                                        : AppColors.accentPurple)
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: (widget.isCurrent
                                          ? AppColors.accent
                                          : AppColors.accentPurple)
                                      .withValues(alpha: 0.35),
                                ),
                              ),
                              child: Text(
                                widget.data['period']!,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: widget.isCurrent
                                      ? AppColors.accent
                                      : AppColors.accentPurple,
                                ),
                              ),
                            ),
                            if (widget.isCurrent)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.accentGreen
                                      .withValues(alpha: 0.14),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppColors.accentGreen
                                        .withValues(alpha: 0.35),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.accentGreen,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Active Role',
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.accentGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // Role
                        Text(
                          widget.data['role']!,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: isMobile ? 18 : 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Company
                        Row(
                          children: [
                            const Icon(
                              Icons.business_rounded,
                              size: 15,
                              color: AppColors.accentPurple,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.data['company']!,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppColors.accentPurple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // Description
                        Text(
                          widget.data['description']!,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Tech tags for that position
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (widget.isCurrent
                                  ? [
                                      'Flutter',
                                      'Dart',
                                      'Clean Arch',
                                      'BLoC',
                                      'GoRouter',
                                      'Node.js',
                                      'Oracle DB',
                                      'Hive'
                                    ]
                                  : [
                                      'Flutter',
                                      'Provider',
                                      'Firebase',
                                      'REST APIs',
                                      'Git'
                                    ])
                              .map((t) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.surface,
                                      borderRadius: BorderRadius.circular(6),
                                      border:
                                          Border.all(color: AppColors.border),
                                    ),
                                    child: Text(
                                      t,
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        color: AppColors.textMuted,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: widget.delay))
        .slideX(begin: -0.1, curve: Curves.easeOutCubic);
  }
}
