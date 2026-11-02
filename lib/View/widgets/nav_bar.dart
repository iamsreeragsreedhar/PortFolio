import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfoloio_1/core/theme.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Map<String, dynamic>> navItems;
  final VoidCallback onDownloadCV;

  const NavBar({
    super.key,
    required this.navItems,
    required this.onDownloadCV,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 960;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 24,
          vertical: 10,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.12),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.05),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo with live radar dot
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '<',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accent,
                              ),
                            ),
                            TextSpan(
                              text: 'Sreerag',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextSpan(
                              text: ' />',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (_, __) => Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.accentGreen,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accentGreen.withValues(
                                  alpha: 0.4 + (_pulseController.value * 0.5),
                                ),
                                blurRadius: 6 + (_pulseController.value * 6),
                                spreadRadius: _pulseController.value * 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Desktop Navigation Links
                  if (!isMobile)
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: widget.navItems.map(
                                  (item) => _NavPillItem(
                                    label: item['title'] as String,
                                    onTap: item['onTap'] as VoidCallback,
                                  ),
                                ).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _ShimmerResumeButton(onTap: widget.onDownloadCV),
                        ],
                      ),
                    )
                  else
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _ShimmerResumeButton(
                          onTap: widget.onDownloadCV,
                          isCompact: true,
                        ),
                        const SizedBox(width: 6),
                        _MobileMenuToggle(
                          navItems: widget.navItems,
                          onDownloadCV: widget.onDownloadCV,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavPillItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavPillItem({required this.label, required this.onTap});

  @override
  State<_NavPillItem> createState() => _NavPillItemState();
}

class _NavPillItemState extends State<_NavPillItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withValues(alpha: 0.3)
                  : Colors.transparent,
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: _hovered ? FontWeight.w600 : FontWeight.w500,
              color: _hovered ? AppColors.accent : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _ShimmerResumeButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isCompact;

  const _ShimmerResumeButton({
    required this.onTap,
    this.isCompact = false,
  });

  @override
  State<_ShimmerResumeButton> createState() => _ShimmerResumeButtonState();
}

class _ShimmerResumeButtonState extends State<_ShimmerResumeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: AnimatedBuilder(
            animation: _shimmerController,
            builder: (context, child) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.isCompact ? 11 : 15,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accent,
                      Color.lerp(
                        AppColors.accent,
                        AppColors.accentBlue,
                        _shimmerController.value,
                      )!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(
                        alpha: _hovered ? 0.45 : 0.25,
                      ),
                      blurRadius: _hovered ? 18 : 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.description_outlined,
                      size: 14,
                      color: AppColors.bg,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Resume',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.bg,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MobileMenuToggle extends StatelessWidget {
  final List<Map<String, dynamic>> navItems;
  final VoidCallback onDownloadCV;

  const _MobileMenuToggle({
    required this.navItems,
    required this.onDownloadCV,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) => Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 40,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.borderLight,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...navItems.map(
                        (item) => ListTile(
                          title: Text(
                            item['title'] as String,
                            style: GoogleFonts.spaceGrotesk(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: AppColors.accent,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            (item['onTap'] as VoidCallback)();
                          },
                        ),
                      ),
                      const Divider(color: AppColors.border),
                      ListTile(
                        leading: const Icon(
                          Icons.download_rounded,
                          color: AppColors.accent,
                        ),
                        title: Text(
                          'Download Resume',
                          style: GoogleFonts.inter(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          onDownloadCV();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
