/** Copyright © 2025 Neothan
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/blur_background_container.dart';
import '../../../widgets/glassmorphism_app_bar.dart';
import '../../../utils/asset_manager.dart';
import '../../../localization/app_localizations.dart';

class ScrollCardDetailScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final List<Color> gradient;
  final double trend;
  final List<double> trendData;

  const ScrollCardDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.gradient,
    required this.trend,
    required this.trendData,
  });

  @override
  State<ScrollCardDetailScreen> createState() => _ScrollCardDetailScreenState();
}

class _ScrollCardDetailScreenState extends State<ScrollCardDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _buildPageContent(),
          _buildGlassmorphismAppBar(),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    return GlassmorphismBackgroundContainer(
      backgroundName: AppBackgrounds.dashboardBackground,
      blurSigma: 1.5,
      glassOpacity: 0.2,
      overlayColor: Colors.black.withValues(alpha: 0.2),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight),
          Expanded(
            child: SafeArea(
              top: false,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildHeaderCard(),
                      const SizedBox(height: 24),
                      _buildDetailSection(),
                      const SizedBox(height: 24),
                      _buildChartSection(),
                      const SizedBox(height: 24),
                      _buildSuggestionSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.gradient,
        ),
        borderRadius: AppTheme.borderRadiusLg,
        boxShadow: AppTheme.shadowMd,
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTheme.h3.copyWith(
                        color: Colors.white.withOpacity(0.95),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: AppTheme.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  widget.value,
                  style: AppTheme.h1.copyWith(
                    color: Colors.white.withOpacity(0.95),
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  widget.unit,
                  style: AppTheme.h4.copyWith(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: AppTheme.borderRadiusLg,
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "1932da4d4dF5qHosuTEG".tr,
            style: AppTheme.h4.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailItem(
            "dcaee44404BtuAL9ynKD".tr,
            '${widget.value}${widget.unit}',
          ),
          _buildDetailItem("c827dc3403wLryZOUxiH".tr, '85%'),
          _buildDetailItem(
            "5294392faeRhwUhZDHzA".tr,
            '${widget.value}${widget.unit}',
          ),
          _buildDetailItem(
            "9b35181012i43B8obvy4".tr,
            '${widget.value}${widget.unit}',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          Text(
            value,
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: AppTheme.borderRadiusLg,
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "5ec89db9399F2aPUex8n".tr,
                style: AppTheme.h4.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(
                widget.trend > 0 ? Icons.trending_up : Icons.trending_down,
                color: widget.trend > 0 ? Colors.green : Colors.red,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                widget.trend > 0
                    ? "5d9d83afd4AWUpIClTNz".tr
                    : "2c5404ea58ue4NcsnJFT".tr,
                style: AppTheme.bodySmall.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            child: CustomPaint(
              size: const Size(double.infinity, 200),
              painter: DetailTrendChartPainter(
                data: widget.trendData,
                color: Colors.white.withOpacity(0.8),
                gradient: widget.gradient,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              widget.trendData.length,
              (index) => Column(
                children: [
                  Text(
                    '${widget.trendData[index].toStringAsFixed(1)}',
                    style: AppTheme.bodySmall.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "af50a0fe2azWCXDz2GZk".tr +
                        '${index + 1}' +
                        "49da61ceee5mQWdHLu6q".tr,
                    style: AppTheme.caption.copyWith(
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: AppTheme.borderRadiusLg,
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "993f81e464QRZJ34qBNR".tr,
            style: AppTheme.h4.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSuggestionItem(
            "e6f2d72cf6gRbsadq98y".tr,
            Icons.check_circle,
            Colors.green,
          ),
          _buildSuggestionItem(
            "bbd5470db3WbNS7Z0t6s".tr,
            Icons.trending_up,
            Colors.orange,
          ),
          _buildSuggestionItem(
            "b8b05570fe3gANo32i40".tr,
            Icons.bedtime,
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(String text, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTheme.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.85),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassmorphismAppBar() {
    return GlassmorphismAppBar(
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: widget.color,
      blurRadius: 20.0,
      opacity: 0.001,
    );
  }
}

class DetailTrendChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;
  final List<Color> gradient;

  DetailTrendChartPainter({
    required this.data,
    required this.color,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [gradient[0].withOpacity(0.3), gradient[1].withOpacity(0.1)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final maxValue = data.reduce((a, b) => a > b ? a : b).toDouble();
    final minValue = data.reduce((a, b) => a < b ? a : b).toDouble();
    final range = maxValue - minValue;

    final stepX = size.width / (data.length - 1);
    final padding = 20.0;

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final normalizedValue = range > 0 ? (data[i] - minValue) / range : 0.5;
      final y = padding + (1 - normalizedValue) * (size.height - 2 * padding);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height - padding);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      final pointPaint = Paint()
        ..color = gradient[0]
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), 4, pointPaint);

      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(Offset(x, y), 4, borderPaint);
    }

    fillPath.lineTo(size.width, size.height - padding);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = padding + (i * (size.height - 2 * padding) / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
