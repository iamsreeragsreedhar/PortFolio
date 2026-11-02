import 'dart:math' as math;
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfoloio_1/core/constants.dart';
import 'package:portfoloio_1/core/theme.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onDownloadCV;
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.onDownloadCV,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 860;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 80,
      ),
      decoration: const BoxDecoration(color: AppColors.bg),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ambient drifting neon aurora orbs
          Positioned(
            top: -120,
            left: -100,
            child: _glowOrb(AppColors.accent.withValues(alpha: 0.16), 460),
          ),
          Positioned(
            bottom: 40,
            right: -100,
            child:
                _glowOrb(AppColors.accentPurple.withValues(alpha: 0.16), 420),
          ),
          Positioned(
            top: 250,
            right: w * 0.35,
            child: _glowOrb(AppColors.accentBlue.withValues(alpha: 0.09), 320),
          ),

          // Cybernetic grid overlay
          Positioned.fill(child: _CyberGrid()),

          // Main Hero Content
          Column(
            children: [
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 60,
                    vertical: isMobile ? 50 : 70,
                  ),
                  child: isMobile
                      ? _mobileLayout(context)
                      : _desktopLayout(context),
                ),
              ),

              // Infinite Tech Marquee Ticker
              const SizedBox(height: 20),
              const _TechTickerMarquee(),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 3, child: _textContent(context, isMobile: false)),
        const SizedBox(width: 50),
        const Expanded(flex: 2, child: _InteractiveHeroAvatar()),
      ],
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Column(
      children: [
        const _InteractiveHeroAvatar(),
        const SizedBox(height: 36),
        _textContent(context, isMobile: true),
      ],
    );
  }

  Widget _textContent(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Cyber Neon Badge
        _cyberAvailabilityBadge(isMobile),
        const SizedBox(height: 24),

        // Name Header with Cyber Glow
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Hi, I'm ",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: isMobile ? 32 : 44,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: AppData.name,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: isMobile ? 42 : 58,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -1,
                  shadows: [
                    Shadow(
                      color: AppColors.accent.withValues(alpha: 0.25),
                      blurRadius: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.25),

        const SizedBox(height: 14),

        // Animated typewriter role tag
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'A passionate ',
              style: GoogleFonts.spaceGrotesk(
                fontSize: isMobile ? 19 : 26,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
            AnimatedTextKit(
              repeatForever: true,
              animatedTexts: AppData.animatedRoles
                  .map((role) => TypewriterAnimatedText(
                        role,
                        textStyle: GoogleFonts.spaceGrotesk(
                          fontSize: isMobile ? 19 : 26,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent,
                          shadows: [
                            Shadow(
                              color: AppColors.accent.withValues(alpha: 0.4),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        speed: const Duration(milliseconds: 70),
                      ))
                  .toList(),
            ),
          ],
        ).animate().fadeIn(delay: 350.ms),

        const SizedBox(height: 20),

        // Hero Subtitle
        Text(
          AppData.heroSubtitle,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 14 : 16,
            color: AppColors.textSecondary,
            height: 1.7,
            letterSpacing: 0.1,
          ),
        ).animate().fadeIn(delay: 450.ms).slideY(begin: 0.15),

        const SizedBox(height: 38),

        // Shimmer CTA Action Buttons
        Wrap(
          spacing: 16,
          runSpacing: 14,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _glowCTAButton(
              label: 'Download CV',
              icon: Icons.download_rounded,
              onTap: onDownloadCV,
              isPrimary: true,
            ),
            _glowCTAButton(
              label: 'Get In Touch',
              icon: Icons.arrow_forward_rounded,
              onTap: onContactTap,
              isPrimary: false,
            ),
          ],
        ).animate().fadeIn(delay: 550.ms).slideY(begin: 0.2),
      ],
    );
  }

  Widget _cyberAvailabilityBadge(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.12),
            blurRadius: 15,
            spreadRadius: 1,
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
          const SizedBox(width: 8),
          Text(
            '✦ AVAILABLE FOR OPPORTUNITIES',
            style: GoogleFonts.inter(
              fontSize: 11,
              letterSpacing: 1.2,
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.2);
  }

  Widget _glowCTAButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return _HoverButton(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
        decoration: BoxDecoration(
          gradient: isPrimary
              ? const LinearGradient(
                  colors: [AppColors.accent, Color(0xFF00C79A)],
                )
              : null,
          color: isPrimary ? null : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: isPrimary
              ? null
              : Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1.4,
                ),
          boxShadow: [
            if (isPrimary)
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.35),
                blurRadius: 25,
                offset: const Offset(0, 6),
              )
            else
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 15,
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 17,
              color: isPrimary ? AppColors.bg : AppColors.textPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isPrimary ? AppColors.bg : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glowOrb(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _CyberGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _CyberGridPainter());
  }
}

class _CyberGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.25)
      ..strokeWidth = 0.5;
    const spacing = 55.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const _HoverButton({required this.child, required this.onTap});

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutBack,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Dynamic Infinite Tech Ticker running below the Hero Section
class _TechTickerMarquee extends StatefulWidget {
  const _TechTickerMarquee();

  @override
  State<_TechTickerMarquee> createState() => _TechTickerMarqueeState();
}

class _TechTickerMarqueeState extends State<_TechTickerMarquee>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animController;

  final List<String> _tickerItems = [
    'FLUTTER 3.x',
    'DART',
    'BLOC & CUBIT',
    'CLEAN ARCHITECTURE',
    'GOROUTER',
    'FIREBASE',
    'OFFLINE-FIRST',
    'NODE.JS',
    'ORACLE DB',
    'HIVE PERSISTENCE',
    'FL_CHART ANALYTICS',
    'RESTFUL APIS',
    'RESPONSIVE UI',
    'CI/CD & FVM',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 28),
    )..addListener(() {
        if (_scrollController.hasClients) {
          final max = _scrollController.position.maxScrollExtent;
          if (max > 0) {
            _scrollController.jumpTo(_animController.value * max);
          }
        }
      });
    _animController.repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Quadruple items for seamless wrap
    final items = [
      ..._tickerItems,
      ..._tickerItems,
      ..._tickerItems,
      ..._tickerItems,
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
      ),
      child: IgnorePointer(
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            children: items.map((t) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      t,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

/// Interactive Hero Avatar with Spinning Gradient Halo,
/// Float Parallax, and Glassmorphic Floating Badges.
class _InteractiveHeroAvatar extends StatefulWidget {
  const _InteractiveHeroAvatar();

  @override
  State<_InteractiveHeroAvatar> createState() => _InteractiveHeroAvatarState();
}

class _InteractiveHeroAvatarState extends State<_InteractiveHeroAvatar>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _rotateController;
  late Animation<double> _floatAnim;
  late Animation<double> _pulseAnim;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    // Smooth 3.2s breathing cycle
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOutSine,
      ),
    );

    _pulseAnim = Tween<double>(begin: 0.90, end: 1.08).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOutSine,
      ),
    );

    // Continuous 8s halo rotation
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    // Responsive avatar sizing
    final double avatarSize = screenW < 420
        ? 210.0
        : (screenW < 800
            ? (screenW * 0.52).clamp(220.0, 270.0)
            : (screenW < 1200 ? 280.0 : 320.0));

    final double glowRadius = avatarSize + 70;

    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnim.value),
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: SizedBox(
              width: glowRadius + 40,
              height: glowRadius + 40,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Outer Pulsing Ambient Halo
                  Transform.scale(
                    scale: _pulseAnim.value,
                    child: Container(
                      width: glowRadius,
                      height: glowRadius,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.accent.withValues(
                              alpha: _isHovered ? 0.35 : 0.18,
                            ),
                            AppColors.accentPurple.withValues(
                              alpha: _isHovered ? 0.22 : 0.08,
                            ),
                            Colors.transparent,
                          ],
                          stops: const [0.3, 0.65, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // Spinning Conic Gradient Halo
                  AnimatedBuilder(
                    animation: _rotateController,
                    builder: (_, __) {
                      return Transform.rotate(
                        angle: _rotateController.value * 2 * math.pi,
                        child: Container(
                          width: avatarSize + 12,
                          height: avatarSize + 12,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: SweepGradient(
                              colors: [
                                AppColors.accent,
                                AppColors.accentPurple,
                                AppColors.accentBlue,
                                AppColors.accentPink,
                                AppColors.accent,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Avatar Image Container with Glow
                  AnimatedScale(
                    scale: _isHovered ? 1.03 : 1.0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    child: Container(
                      width: avatarSize,
                      height: avatarSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.bg,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withValues(
                              alpha: _isHovered ? 0.45 : 0.22,
                            ),
                            blurRadius: _isHovered ? 45 : 30,
                            spreadRadius: _isHovered ? 6 : 2,
                          ),
                          BoxShadow(
                            color: AppColors.accentPurple.withValues(
                              alpha: _isHovered ? 0.35 : 0.15,
                            ),
                            blurRadius: 35,
                            offset: const Offset(4, 10),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(3.0),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/profile.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Image.asset(
                            'assets/ph1.png',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppColors.card,
                              child: const Icon(
                                Icons.person,
                                size: 80,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Floating Badge 1: Experience (Bottom Right)
                  Positioned(
                    bottom: screenW < 420 ? 8 : 16,
                    right: screenW < 420 ? -4 : 8,
                    child: Transform.translate(
                      offset: Offset(0, -_floatAnim.value * 0.7),
                      child: _floatingBadge(
                        icon: Icons.workspace_premium_rounded,
                        value: '2+ Years',
                        label: 'Flutter Experience',
                        accentColor: AppColors.accent,
                        isCompact: screenW < 420,
                      ),
                    ),
                  ),

                  // Floating Badge 2: Clean Arch (Top Left)
                  Positioned(
                    top: screenW < 420 ? 12 : 20,
                    left: screenW < 420 ? -6 : 10,
                    child: Transform.translate(
                      offset: Offset(0, _floatAnim.value * 0.6),
                      child: _floatingBadge(
                        icon: Icons.layers_rounded,
                        value: 'Clean Arch',
                        label: 'BLoC & GoRouter',
                        accentColor: AppColors.accentPurple,
                        isCompact: screenW < 420,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    )
        .animate()
        .fadeIn(duration: 800.ms, curve: Curves.easeOutCubic)
        .scale(begin: const Offset(0.9, 0.9));
  }

  Widget _floatingBadge({
    required IconData icon,
    required String value,
    required String label,
    required Color accentColor,
    required bool isCompact,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 10 : 14,
            vertical: isCompact ? 8 : 10,
          ),
          decoration: BoxDecoration(
            color: AppColors.card.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.45),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child:
                    Icon(icon, color: accentColor, size: isCompact ? 14 : 16),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: isCompact ? 13 : 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: isCompact ? 9 : 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
