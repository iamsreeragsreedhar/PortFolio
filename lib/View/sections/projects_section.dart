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
                        color: isSelected ? AppColors.accent : AppColors.card,
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
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _openUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (_) {}
  }

  void _showScreensLightbox(BuildContext context, int initialIndex) {
    final images = (widget.data['images'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    if (images.isEmpty) return;

    final screenOptions = (widget.data['screenOptions'] as List<dynamic>?)
        ?.cast<Map<String, dynamic>>();
    final featureOptions = (widget.data['featureOptions'] as List<dynamic>?)
        ?.cast<String>();

    showDialog(
      context: context,
      builder: (ctx) => _ProjectScreensLightboxDialog(
        title: widget.data['title'] as String,
        images: images,
        screenOptions: screenOptions,
        featureOptions: featureOptions,
        initialIndex: initialIndex,
        accentColor: Color(widget.data['accentColor'] as int? ?? 0xFF00FFD1),
      ),
    );
  }

  void _showProjectDetails(BuildContext context) {
    final tags = (widget.data['tags'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    final highlights =
        (widget.data['highlights'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    final images = (widget.data['images'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    final screenOptions = (widget.data['screenOptions'] as List<dynamic>?)
        ?.cast<Map<String, dynamic>>();
    final featureOptions = (widget.data['featureOptions'] as List<dynamic>?)
        ?.cast<String>();
    final accentInt = widget.data['accentColor'] as int? ?? 0xFF00FFD1;
    final accentColor = Color(accentInt);

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
          width: 580,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Badge
                if (widget.data['badge'] != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      widget.data['badge'] as String,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: accentColor,
                      ),
                    ),
                  ),

                // Feature Options from image header
                if (featureOptions != null && featureOptions.isNotEmpty) ...[
                  Text(
                    'Included System Capabilities',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: featureOptions.map((opt) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: accentColor.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_rounded,
                                size: 13, color: accentColor),
                            const SizedBox(width: 5),
                            Text(
                              opt,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],

                // Image Preview Card & Lightbox Launcher
                if (images.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.asset(
                            images[_currentImage.clamp(0, images.length - 1)],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.surface.withValues(alpha: 0.9),
                              foregroundColor: accentColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: accentColor.withValues(alpha: 0.5)),
                              ),
                            ),
                            icon: const Icon(Icons.fullscreen, size: 18),
                            label: Text(
                              'View All 9 Screens',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(ctx);
                              _showScreensLightbox(context, _currentImage);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Screen Options Tabs
                if (screenOptions != null && screenOptions.isNotEmpty) ...[
                  Text(
                    'Production Screen Breakdown (9 Screens)',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: screenOptions.asMap().entries.map((entry) {
                      final isSelected = _currentImage == entry.key;
                      return InkWell(
                        onTap: () {
                          Navigator.pop(ctx);
                          _showScreensLightbox(context, entry.key);
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? accentColor.withValues(alpha: 0.2)
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? accentColor
                                  : AppColors.border,
                            ),
                          ),
                          child: Text(
                            entry.value['name'] as String,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? accentColor
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],

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
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...highlights.map((h) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: accentColor,
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
          if (images.isNotEmpty)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: AppColors.bg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.photo_library_rounded, size: 15),
              label: Text(
                'View All 9 Screens',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                _showScreensLightbox(context, _currentImage);
              },
            ),
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
                backgroundColor: AppColors.cardHover,
                foregroundColor: AppColors.textPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: AppColors.border),
                ),
              ),
              icon: const FaIcon(FontAwesomeIcons.github, size: 14),
              label: Text(
                'GitHub',
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

  Widget _buildCardHeader(
      List<String> images, Color accentColor, List<Map<String, dynamic>>? screenOptions) {
    final isResumo = (widget.data['title'] as String).contains('Resumo');
    final isStockFlow = (widget.data['title'] as String).contains('StockFlow');
    final isOutSplitIn = (widget.data['title'] as String).contains('OutSplitIn');

    if (images.isNotEmpty) {
      final activeScreenTitle = screenOptions != null && _currentImage < screenOptions.length
          ? screenOptions[_currentImage]['name'] as String
          : 'Screen ${_currentImage + 1}';

      return Stack(
        children: [
          GestureDetector(
            onTap: () => _showScreensLightbox(context, _currentImage),
            child: SizedBox(
              height: 220,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                onPageChanged: (i) => setState(() => _currentImage = i),
                itemBuilder: (_, i) => Image.asset(
                  images[i],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.bg,
                    child: const Icon(Icons.image,
                        size: 60, color: AppColors.border),
                  ),
                ),
              ),
            ),
          ),

          // Top Left Screen Badge
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: accentColor.withValues(alpha: 0.5),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    activeScreenTitle,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top Right Fullscreen/Expand Button
          Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              onTap: () => _showScreensLightbox(context, _currentImage),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.6),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withValues(alpha: 0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.zoom_in_rounded, size: 14, color: accentColor),
                    const SizedBox(width: 4),
                    Text(
                      screenOptions != null ? '9 Screens' : 'Expand',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Slide Indicators
          if (images.length > 1)
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    width: _currentImage == i ? 16 : 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: _currentImage == i
                          ? accentColor
                          : Colors.white.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    }

    // Styled Hero Banner for Flagship Projects without explicit screenshots
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
                          isResumo
                              ? 'ATS Matcher • PDF Engine • Web/Desktop'
                              : (isStockFlow
                                  ? 'Offline-First • 26 Routes • SaaS'
                                  : 'BLoC • Firestore • fl_chart'),
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
    final highlights =
        (widget.data['highlights'] as List<dynamic>?)?.cast<String>() ?? <String>[];
    final screenOptions = (widget.data['screenOptions'] as List<dynamic>?)
        ?.cast<Map<String, dynamic>>();
    final featureOptions = (widget.data['featureOptions'] as List<dynamic>?)
        ?.cast<String>();
    final github = widget.data['github'] as String? ?? '';
    final accentInt = widget.data['accentColor'] as int? ?? 0xFF00FFD1;
    final accentColor = Color(accentInt);

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
                  ? accentColor.withValues(alpha: 0.5)
                  : AppColors.border,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? accentColor.withValues(alpha: 0.14)
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
                child: _buildCardHeader(images, accentColor, screenOptions),
              ),

              // Interactive Screen Options Selector Row (from image)
              if (screenOptions != null && screenOptions.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  color: AppColors.bg.withValues(alpha: 0.4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: screenOptions.asMap().entries.map((entry) {
                        final isSelected = _currentImage == entry.key;
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: InkWell(
                            onTap: () {
                              setState(() => _currentImage = entry.key);
                              _pageController.animateToPage(
                                entry.key,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? accentColor.withValues(alpha: 0.25)
                                    : AppColors.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? accentColor
                                      : AppColors.border,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                entry.value['name'] as String,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? accentColor
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],

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

                    // Feature Options Pills from Image Header
                    if (featureOptions != null && featureOptions.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: featureOptions.map((opt) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: accentColor.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Text(
                              opt,
                              style: GoogleFonts.inter(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: accentColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],

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
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 14,
                                  color: accentColor,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    h,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: AppColors.textPrimary
                                          .withValues(alpha: 0.85),
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
                                      color: AppColors.borderLight
                                          .withValues(alpha: 0.6)),
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
                        Row(
                          children: [
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: accentColor,
                                side: BorderSide(
                                    color: accentColor.withValues(alpha: 0.4)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 9),
                              ),
                              icon: const Icon(Icons.info_outline, size: 14),
                              label: Text(
                                'Specs',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () => _showProjectDetails(context),
                            ),
                            if (images.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      accentColor.withValues(alpha: 0.16),
                                  foregroundColor: accentColor,
                                  elevation: 0,
                                  side: BorderSide(
                                    color: accentColor.withValues(alpha: 0.35),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 9),
                                ),
                                icon: const Icon(Icons.photo_library_outlined,
                                    size: 14),
                                label: Text(
                                  screenOptions != null ? 'UI Screens (9)' : 'Photos',
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onPressed: () =>
                                    _showScreensLightbox(context, _currentImage),
                              ),
                            ],
                          ],
                        ),
                        if (github.isNotEmpty)
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.textSecondary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 9),
                            ),
                            icon: const FaIcon(FontAwesomeIcons.github,
                                size: 14),
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

/// Fullscreen Interactive Lightbox for Project UI Reference and Screens
class _ProjectScreensLightboxDialog extends StatefulWidget {
  final String title;
  final List<String> images;
  final List<Map<String, dynamic>>? screenOptions;
  final List<String>? featureOptions;
  final int initialIndex;
  final Color accentColor;

  const _ProjectScreensLightboxDialog({
    required this.title,
    required this.images,
    required this.screenOptions,
    required this.featureOptions,
    required this.initialIndex,
    required this.accentColor,
  });

  @override
  State<_ProjectScreensLightboxDialog> createState() =>
      _ProjectScreensLightboxDialogState();
}

class _ProjectScreensLightboxDialogState
    extends State<_ProjectScreensLightboxDialog> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.images.length - 1);
  }

  void _next() {
    if (_currentIndex < widget.images.length - 1) {
      setState(() => _currentIndex++);
    } else {
      setState(() => _currentIndex = 0);
    }
  }

  void _prev() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    } else {
      setState(() => _currentIndex = widget.images.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final isMobile = w < 760;

    final currentOption =
        widget.screenOptions != null && _currentIndex < widget.screenOptions!.length
            ? widget.screenOptions![_currentIndex]
            : null;
    final currentName = currentOption?['name'] as String? ?? 'Screen ${_currentIndex + 1}';
    final currentDesc = currentOption?['desc'] as String? ?? '';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 36,
        vertical: isMobile ? 16 : 28,
      ),
      child: Container(
        width: 1100,
        height: h * 0.9,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: widget.accentColor.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.8),
              blurRadius: 40,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: widget.accentColor.withValues(alpha: 0.15),
              blurRadius: 30,
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                color: AppColors.card,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.accentColor.withValues(alpha: 0.15),
                    ),
                    child: Icon(Icons.devices_rounded,
                        size: 18, color: widget.accentColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: isMobile ? 15 : 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (widget.featureOptions != null &&
                            widget.featureOptions!.isNotEmpty &&
                            !isMobile)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Wrap(
                              spacing: 6,
                              children: widget.featureOptions!.map((opt) {
                                return Text(
                                  '• $opt',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: widget.accentColor,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: AppColors.textSecondary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Horizontal Option Chips Bar
            if (widget.screenOptions != null &&
                widget.screenOptions!.isNotEmpty)
              Container(
                width: double.infinity,
                color: AppColors.bg.withValues(alpha: 0.7),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: widget.screenOptions!.asMap().entries.map((e) {
                      final isSelected = _currentIndex == e.key;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () => setState(() => _currentIndex = e.key),
                          borderRadius: BorderRadius.circular(16),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? widget.accentColor.withValues(alpha: 0.25)
                                  : AppColors.card,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? widget.accentColor
                                    : AppColors.border,
                                width: 1.2,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isSelected) ...[
                                  Icon(Icons.check_circle_rounded,
                                      size: 13, color: widget.accentColor),
                                  const SizedBox(width: 5),
                                ],
                                Text(
                                  e.value['name'] as String,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? widget.accentColor
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

            // Main Interactive Zoom Viewport
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color(0xFF07090F),
                    child: Center(
                      child: InteractiveViewer(
                        panEnabled: true,
                        minScale: 0.8,
                        maxScale: 4.0,
                        child: Image.asset(
                          widget.images[_currentIndex],
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Center(
                            child: Icon(Icons.broken_image,
                                size: 50, color: AppColors.border),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Previous Button
                  Positioned(
                    left: 14,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              AppColors.surface.withValues(alpha: 0.85),
                          foregroundColor: widget.accentColor,
                          padding: const EdgeInsets.all(12),
                          side: BorderSide(
                            color: widget.accentColor.withValues(alpha: 0.4),
                          ),
                        ),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 18),
                        onPressed: _prev,
                      ),
                    ),
                  ),

                  // Next Button
                  Positioned(
                    right: 14,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              AppColors.surface.withValues(alpha: 0.85),
                          foregroundColor: widget.accentColor,
                          padding: const EdgeInsets.all(12),
                          side: BorderSide(
                            color: widget.accentColor.withValues(alpha: 0.4),
                          ),
                        ),
                        icon: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 18),
                        onPressed: _next,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Description & Meta Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                color: AppColors.card,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(24)),
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentName,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: widget.accentColor,
                          ),
                        ),
                        if (currentDesc.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              currentDesc,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      '${_currentIndex + 1} / ${widget.images.length}',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: widget.accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
