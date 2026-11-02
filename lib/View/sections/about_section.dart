import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfoloio_1/core/constants.dart';
import 'package:portfoloio_1/core/theme.dart';
import 'package:portfoloio_1/View/widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 800;

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      child: Column(
        children: [
          const SectionHeader(title: 'About Me', subtitle: 'Who I am'),
          const SizedBox(height: 60),
          isMobile ? _mobileLayout(context) : _desktopLayout(context),
        ],
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _imageBlock(context)),
        const SizedBox(width: 60),
        Expanded(flex: 3, child: _textBlock(context)),
      ],
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Column(
      children: [
        _imageBlock(context),
        const SizedBox(height: 40),
        _textBlock(context),
      ],
    );
  }

  Widget _imageBlock(BuildContext context) {
    return Column(
      children: [
        const _AboutPhotoCard(),
        const SizedBox(height: 28),
        _statsRow(),
      ],
    );
  }

  Widget _statsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _statItem('2+', 'Years Exp.'),
        _statItem('15+', 'Apps & Modules'),
        _statItem('4+', 'Target Platforms'),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
            )),
        const SizedBox(height: 4),
        Text(label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textSecondary,
            )),
      ],
    );
  }

  Widget _textBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Engineering scalable apps with\nClean Architecture & precision.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.3,
          ),
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),
        const SizedBox(height: 20),
        Text(
          AppData.aboutText,
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppColors.textSecondary,
            height: 1.8,
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
        const SizedBox(height: 32),
        _interestChips().animate().fadeIn(delay: 500.ms),
      ],
    );
  }

  Widget _interestChips() {
    final interests = [
      '📱 Cross-Platform (Mobile, Web, Windows)',
      '🏛️ Clean Architecture & MVVM',
      '⚡ BLoC / Cubit State Management',
      '🌐 Node.js & Oracle DB APIs',
      '📦 Offline-First & Local Sync',
      '📊 Data Visualization (fl_chart)',
      '📈 Financial Analysis & Trading',
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: interests
          .map((i) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(i,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    )),
              ))
          .toList(),
    );
  }
}

class _AboutPhotoCard extends StatefulWidget {
  const _AboutPhotoCard();

  @override
  State<_AboutPhotoCard> createState() => _AboutPhotoCardState();
}

class _AboutPhotoCardState extends State<_AboutPhotoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final double cardWidth = screenW < 420
        ? (screenW - 64).clamp(220.0, 280.0)
        : (screenW < 800 ? 280.0 : 320.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: cardWidth,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withValues(alpha: 0.6)
                  : AppColors.border,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.accent.withValues(alpha: 0.18)
                    : Colors.black.withValues(alpha: 0.3),
                blurRadius: _hovered ? 35 : 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Avatar circle with double glowing ring
              Container(
                width: cardWidth - 50,
                height: cardWidth - 50,
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accent,
                      AppColors.accentPurple,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.bg,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/profile.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/ph1.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.surface,
                          child: const Icon(
                            Icons.person,
                            size: 70,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Name and title badge
              Text(
                AppData.name,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Exaware Solutions',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                      ),
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
        .fadeIn(delay: 200.ms)
        .slideX(begin: -0.15, curve: Curves.easeOutCubic);
  }
}
