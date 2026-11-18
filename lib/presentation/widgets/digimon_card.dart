import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/digimon_entity.dart';

class DigimonCard extends StatelessWidget {
  final DigimonEntity digimon;
  final VoidCallback? onTap;
  final int? cardNumber;
  final bool compact; // for 3-column binder mode

  const DigimonCard({
    Key? key,
    required this.digimon,
    this.onTap,
    this.cardNumber,
    this.compact = false,
  }) : super(key: key);

  int get _dpValue {
    switch (digimon.level.toLowerCase()) {
      case 'fresh':
        return 10;
      case 'in-training':
        return 20;
      case 'rookie':
        return 30;
      case 'champion':
        return 45;
      case 'ultimate':
        return 65;
      case 'mega':
        return 90;
      default:
        return 25;
    }
  }

  // Card theme colors matching the retro Digimon Trading Card series
  _CardTheme get _theme {
    final idx = (cardNumber ?? digimon.name.hashCode.abs()) % 7;
    switch (idx) {
      case 0: // Tai - Gold / Amber
        return _CardTheme(
          borderColor: const Color(0xFFB68C48),
          innerBorder: const Color(0xFF4A3416),
          bgTop: const Color(0xFFFFEB3B),
          bgBottom: const Color(0xFFFFB300),
          gridColor: const Color(0xFFE6A000).withOpacity(0.35),
          crestColor: const Color(0xFFE65100).withOpacity(0.25),
        );
      case 1: // Matt - Khaki / Cyan
        return _CardTheme(
          borderColor: const Color(0xFFA69062),
          innerBorder: const Color(0xFF323B33),
          bgTop: const Color(0xFF81D4FA),
          bgBottom: const Color(0xFF29B6F6),
          gridColor: const Color(0xFF0288D1).withOpacity(0.35),
          crestColor: const Color(0xFF01579B).withOpacity(0.25),
        );
      case 2: // Sora - Purple-Brown / Yellow
        return _CardTheme(
          borderColor: const Color(0xFF987E98),
          innerBorder: const Color(0xFF382638),
          bgTop: const Color(0xFFFFF59D),
          bgBottom: const Color(0xFFFFD54F),
          gridColor: const Color(0xFFFFB300).withOpacity(0.35),
          crestColor: const Color(0xFFC2185B).withOpacity(0.25),
        );
      case 3: // Izzy - Violet / Orange
        return _CardTheme(
          borderColor: const Color(0xFF7E6686),
          innerBorder: const Color(0xFF2F2035),
          bgTop: const Color(0xFFFFCC80),
          bgBottom: const Color(0xFFFFA726),
          gridColor: const Color(0xFFF57C00).withOpacity(0.35),
          crestColor: const Color(0xFF8E24AA).withOpacity(0.25),
        );
      case 4: // Mimi - Tan-Olive / Lime
        return _CardTheme(
          borderColor: const Color(0xFF8C8D5E),
          innerBorder: const Color(0xFF32341D),
          bgTop: const Color(0xFFE6EE9C),
          bgBottom: const Color(0xFFD4E157),
          gridColor: const Color(0xFFAFB42B).withOpacity(0.35),
          crestColor: const Color(0xFF689F38).withOpacity(0.25),
        );
      case 5: // Joe - Slate-Blue / Yellow-Gold
        return _CardTheme(
          borderColor: const Color(0xFF73827F),
          innerBorder: const Color(0xFF263238),
          bgTop: const Color(0xFFFFF9C4),
          bgBottom: const Color(0xFFFFE082),
          gridColor: const Color(0xFFFFB300).withOpacity(0.35),
          crestColor: const Color(0xFF00838F).withOpacity(0.25),
        );
      default: // T.K. - Warm Ochre / Yellow
        return _CardTheme(
          borderColor: const Color(0xFFC79E3C),
          innerBorder: const Color(0xFF4A3416),
          bgTop: const Color(0xFFFFF176),
          bgBottom: const Color(0xFFFDD835),
          gridColor: const Color(0xFFFBC02D).withOpacity(0.35),
          crestColor: const Color(0xFFF57F17).withOpacity(0.25),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = _theme;
    final cardNo = cardNumber ?? 1;

    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 0.68, // Classic trading card ratio (2.5 : 3.5)
        child: Container(
          decoration: BoxDecoration(
            color: theme.borderColor,
            borderRadius: BorderRadius.circular(compact ? 6 : 8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: compact ? 3 : 6,
                offset: const Offset(1, 3),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 0.8,
            ),
          ),
          padding: EdgeInsets.all(compact ? 3.5 : 5.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(compact ? 3 : 5),
              border: Border.all(
                color: theme.innerBorder,
                width: compact ? 1.0 : 1.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(compact ? 2 : 4),
              child: Stack(
                children: [
                  // 1. Background with Grid and Crest watermark
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [theme.bgTop, theme.bgBottom],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _CardBackgroundPainter(
                        gridColor: theme.gridColor,
                        crestColor: theme.crestColor,
                      ),
                    ),
                  ),

                  // 2. Main Character Artwork (Digimon Image)
                  Positioned(
                    top: compact ? 18 : 26,
                    bottom: compact ? 34 : 46,
                    left: compact ? 4 : 8,
                    right: compact ? 4 : 8,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: digimon.img,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            width: compact ? 18 : 26,
                            height: compact ? 18 : 26,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: theme.innerBorder,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.broken_image,
                          size: compact ? 24 : 36,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),

                  // 3. Top Header: Silver Jewel Badge (Left) + DIGIMON Logo (Right)
                  Positioned(
                    top: compact ? 2 : 4,
                    left: compact ? 2 : 4,
                    right: compact ? 2 : 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Holographic / Prismatic Silver Badge
                        _buildSilverPrismBadge(compact),

                        // Classic DIGIMON Pill Logo Badge
                        _buildDigimonLogo(compact),
                      ],
                    ),
                  ),

                  // 4. Bottom Nameplate & Info Bar
                  Positioned(
                    bottom: compact ? 2 : 3,
                    left: compact ? 2 : 3,
                    right: compact ? 2 : 3,
                    child: _buildBottomBar(context, theme, cardNo, compact),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Silver / Prismatic Diamond Badge (Top-Left)
  Widget _buildSilverPrismBadge(bool isCompact) {
    final size = isCompact ? 13.0 : 18.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.black87, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 1,
            offset: const Offset(0.5, 0.5),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFE0E0E0),
            Color(0xFF9E9E9E),
            Color(0xFF424242),
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: size * 0.45,
          height: size * 0.45,
          color: Colors.white.withOpacity(0.7),
        ),
      ),
    );
  }

  // Classic Yellow "DIGIMON" Pill Logo (Top-Right)
  Widget _buildDigimonLogo(bool isCompact) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 3.0 : 5.0,
        vertical: isCompact ? 0.8 : 1.5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD500),
        borderRadius: BorderRadius.circular(isCompact ? 4 : 6),
        border: Border.all(color: const Color(0xFF1E2856), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 1,
            offset: const Offset(0.5, 0.5),
          ),
        ],
      ),
      child: Text(
        'DIGIMON',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: isCompact ? 6.5 : 8.5,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          letterSpacing: 0.6,
          color: const Color(0xFF1B234B),
          shadows: const [
            Shadow(
              color: Colors.white,
              offset: Offset(0.5, 0.5),
              blurRadius: 0.5,
            ),
          ],
        ),
      ),
    );
  }

  // Bottom Name Box with DP badge & Series info
  Widget _buildBottomBar(
    BuildContext context,
    _CardTheme theme,
    int cardNo,
    bool isCompact,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Upper Name & DP Container
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 3.0 : 4.0,
            vertical: isCompact ? 1.0 : 2.0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF222854),
            border: Border.all(color: const Color(0xFF6773A6), width: 0.8),
          ),
          child: Row(
            children: [
              // Digimon Name
              Expanded(
                child: Text(
                  digimon.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: isCompact ? 7.5 : 9.5,
                    letterSpacing: 0.2,
                    shadows: const [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0.5, 0.5),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 2),
              // DP Badge (e.g. DP 30)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isCompact ? 2.5 : 3.5,
                  vertical: 0.5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black87, width: 0.8),
                ),
                child: Text(
                  'DP $_dpValue',
                  style: TextStyle(
                    color: const Color(0xFF1B234B),
                    fontWeight: FontWeight.w900,
                    fontSize: isCompact ? 6.5 : 8.0,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Lower Series / Subtitle Bar
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 3.0 : 4.0,
            vertical: 1.0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF111422),
            border: const Border(
              left: BorderSide(color: Colors.white38, width: 0.6),
              right: BorderSide(color: Colors.white38, width: 0.6),
              bottom: BorderSide(color: Colors.white38, width: 0.6),
            ),
          ),
          child: Row(
            children: [
              // Card number badge [ 1 ]
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0.2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD500),
                  borderRadius: BorderRadius.circular(1.5),
                ),
                child: Text(
                  '$cardNo',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: isCompact ? 5.5 : 7.0,
                  ),
                ),
              ),
              const SizedBox(width: 3),
              // Series subtitle
              Expanded(
                child: Text(
                  'Introductory Series • ${digimon.level}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: isCompact ? 5.5 : 7.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CardTheme {
  final Color borderColor;
  final Color innerBorder;
  final Color bgTop;
  final Color bgBottom;
  final Color gridColor;
  final Color crestColor;

  const _CardTheme({
    required this.borderColor,
    required this.innerBorder,
    required this.bgTop,
    required this.bgBottom,
    required this.gridColor,
    required this.crestColor,
  });
}

// Background painter: Draws the retro grid pattern, Crest glyph watermark, and cyber pixels
class _CardBackgroundPainter extends CustomPainter {
  final Color gridColor;
  final Color crestColor;

  _CardBackgroundPainter({
    required this.gridColor,
    required this.crestColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // 1. Draw subtle grid mesh
    const double step = 10.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 2. Draw Crest watermark in background
    final crestPaint = Paint()
      ..color = crestColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width * 0.35, size.height * 0.38);
    final radius = size.width * 0.22;

    // Outer sun/crest ring
    canvas.drawCircle(center, radius, crestPaint);
    canvas.drawCircle(center, radius * 0.6, crestPaint);

    // Radiating crest beams / rays
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * 3.14159 / 180;
      final start = Offset(
        center.dx + (radius * 0.6) * (i.isEven ? 1 : 0.8) * (angle > 1.5 ? -1 : 1),
        center.dy + (radius * 0.6) * (i > 3 ? -1 : 1),
      );
      final end = Offset(
        center.dx + radius * 1.25 * (angle > 1.5 ? -1 : 1),
        center.dy + radius * 1.25 * (i > 3 ? -1 : 1),
      );
      canvas.drawLine(start, end, crestPaint..strokeWidth = 1.0);
    }

    // 3. Digital pixel blocks at bottom-right (cyber digital monster motif)
    final pixelPaint = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..style = PaintingStyle.fill;

    final bx = size.width - 24;
    final by = size.height - 48;
    canvas.drawRect(Rect.fromLTWH(bx, by, 6, 6), pixelPaint);
    canvas.drawRect(Rect.fromLTWH(bx + 7, by - 6, 6, 6), pixelPaint);
    canvas.drawRect(Rect.fromLTWH(bx + 7, by + 6, 6, 6), pixelPaint);
    canvas.drawRect(Rect.fromLTWH(bx + 14, by, 6, 6), pixelPaint);
  }

  @override
  bool shouldRepaint(covariant _CardBackgroundPainter oldDelegate) {
    return oldDelegate.gridColor != gridColor || oldDelegate.crestColor != crestColor;
  }
}
