import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfoloio_1/core/constants.dart';
import 'package:portfoloio_1/core/theme.dart';
import 'package:portfoloio_1/View/widgets/section_header.dart';
class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});
  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}
class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Productivity & Utilities',
    'Enterprise & Logistics',
    'Fintech & Utilities',
    'Fintech & Real Estate',
  ];
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 860;
    final filteredProjects = _selectedCategory == 'All'
        ? AppData.projects
        : AppData.projects
            .where((p) => p['category'] == _selectedCategory)
            .toList();
    return Container(
      width: double.infinity,
      color: AppColors.surface,
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
                title: 'Featured Projects',
                subtitle: 'Real-world architectures & apps',
              ),
              const SizedBox(height: 36),
              // Category filter tabs
              Wrap(
                spacing: 12,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return InkWell(
                    onTap: () => setState(() => _selectedCategory = category),
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.accent
                            : AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.accent
                              : AppColors.border,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.3),
                              blurRadius: 15,
                            ),
                        ],
                      ),
                      child: Text(
                        category,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w400,
                          color: isSelected
                              ? AppColors.bg
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 50),
              // Project cards grid
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: filteredProjects
                    .asMap()
                    .entries
                    .map((e) => _ProjectCard(
                          key: ValueKey(e.value['title']),
                          data: e.value,
                          delay: e.key * 100,
                          isMobile: isMobile,
                          maxWidth: isMobile ? w - 40 : 380,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int delay;
  final bool isMobile;
  final double maxWidth;
  const _ProjectCard({
    super.key,
    required this.data,
    required this.delay,
    required this.isMobile,
    required this.maxWidth,
  });
  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}
class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;
  int _currentImage = 0;
  Future<void> _openUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (_) {}
  }
  void _showProjectDetails(BuildContext context) {
    final tags = widget.data['tags'] as List<String>;
    final highlights =
        widget.data['highlights'] as List<String>? ?? <String>[];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.border),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.data['title'] as String,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textSecondary),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.data['badge'] != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(widget.data['accentColor'] as int? ?? 0xFF00FFD1)
                          .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Color(widget.data['accentColor'] as int? ?? 0xFF00FFD1)
                            .withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      widget.data['badge'] as String,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(widget.data['accentColor'] as int? ?? 0xFF00FFD1),
                      ),
                    ),
                  ),
                Text(
                  widget.data['description'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.7,
                  ),
                ),
                if (highlights.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Key Capabilities',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...highlights.map((h) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: AppColors.accent,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                h,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
                const SizedBox(height: 20),
                Text(
                  'Tech Stack & Libraries',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentPurple,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags
                      .map((t) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              t,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Close',
              style: GoogleFonts.inter(color: AppColors.textSecondary),
            ),
          ),
          if ((widget.data['github'] as String? ?? '').isNotEmpty)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.bg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const FaIcon(FontAwesomeIcons.github, size: 14),
              label: Text(
                'Open GitHub',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                _openUrl(widget.data['github'] as String);
              },
            ),
        ],
      ),
    );
  }
  Widget _buildCardHeader(List<String> images) {
    final accentInt = widget.data['accentColor'] as int? ?? 0xFF00FFD1;
    final accentColor = Color(accentInt);
    final isResumo = (widget.data['title'] as String).contains('Resumo');
    final isStockFlow = (widget.data['title'] as String).contains('StockFlow');
    final isOutSplitIn = (widget.data['title'] as String).contains('OutSplitIn');
    if (images.isNotEmpty) {
      return Stack(
        children: [
          SizedBox(
            height: 220,
            width: double.infinity,
            child: PageView.builder(
              itemCount: images.length,
              onPageChanged: (i) => setState(() => _currentImage = i),
              itemBuilder: (_, i) => Image.asset(
                images[i],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.bg,
                  child: const Icon(Icons.image, size: 60, color: AppColors.border),
                ),
              ),
            ),
          ),
          if (images.length > 1)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _currentImage == i ? 16 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _currentImage == i
                          ? AppColors.accent
                          : Colors.white.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    }
    // Styled Hero Banner for Flagship Projects
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accentColor.withValues(alpha: 0.25),
            AppColors.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              isResumo
                  ? Icons.description_outlined
                  : (isStockFlow
                      ? Icons.inventory_2_outlined
                      : (isOutSplitIn
                          ? Icons.account_balance_wallet_outlined
                          : Icons.layers_outlined)),
              size: 150,
              color: accentColor.withValues(alpha: 0.08),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: accentColor.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        widget.data['badge'] as String? ?? 'Featured',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: accentColor,
                        ),
                      ),
                    ),
                    Icon(
                      isResumo
                          ? Icons.rule_rounded
                          : (isStockFlow
                              ? Icons.qr_code_scanner_rounded
                              : (isOutSplitIn
                                  ? Icons.insights_rounded
                                  : Icons.star_rounded)),
                      color: accentColor,
                      size: 24,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accentColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isResumo ? 'ATS Matcher • PDF Engine • Web/Desktop' : (isStockFlow ? 'Offline-First • 26 Routes • SaaS' : 'BLoC • Firestore • fl_chart'),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.data['category'] as String? ?? '',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final images = (widget.data['images'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    final tags = (widget.data['tags'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    final highlights = (widget.data['highlights'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    final github = widget.data['github'] as String? ?? '';
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: widget.maxWidth,
          decoration: BoxDecoration(
            color: _hovered ? AppColors.cardHover : AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withValues(alpha: 0.5)
                  : AppColors.border,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.accent.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.3),
                blurRadius: _hovered ? 35 : 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image / Banner Header
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: _buildCardHeader(images),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data['title'] as String,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.data['description'] as String,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                    // Highlights preview
                    if (highlights.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      ...highlights.take(2).map((h) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 14,
                                  color: AppColors.accent,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    h,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: AppColors.textPrimary.withValues(alpha: 0.85),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                    const SizedBox(height: 16),
                    // Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: tags
                          .take(4)
                          .map((t) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: AppColors.borderLight.withValues(alpha: 0.6)),
                                ),
                                child: Text(t,
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: AppColors.accentPurple,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 22),
                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.accent,
                            side: BorderSide(
                                color: AppColors.accent.withValues(alpha: 0.4)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 9),
                          ),
                          icon: const Icon(Icons.info_outline, size: 15),
                          label: Text(
                            'Specs',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () => _showProjectDetails(context),
                        ),
                        if (github.isNotEmpty)
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.textSecondary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 9),
                            ),
                            icon: const FaIcon(FontAwesomeIcons.github, size: 14),
                            label: Text(
                              'Code',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () => _openUrl(github),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: widget.delay))
        .slideY(begin: 0.2);
  }
}
