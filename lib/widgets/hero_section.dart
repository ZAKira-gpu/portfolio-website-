import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onViewMyWorkTap});

  final void Function(String) onViewMyWorkTap;




  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFfafcfb), Color(0xFF45a99d)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                isMobile
                    ? _buildMobileContent(width)
                    : _buildDesktopContent(width),
                const SizedBox(height: 24),
                Align(
                  alignment: isMobile ? Alignment.center : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 135),
                    child: Row(
  mainAxisSize: MainAxisSize.min,
  children: const [
  HoverIcon(icon: FontAwesomeIcons.instagram, url: 'https://www.instagram.com/zakichaibdraa/'),
  SizedBox(width: 30),
  HoverIcon(icon: FontAwesomeIcons.linkedin, url: 'www.linkedin.com/in/mohammed-chaib-draa-855535285'),
  SizedBox(width: 30),
  HoverIcon(icon: FontAwesomeIcons.github, url: 'https://github.com/ZAKira-gpu'),
  SizedBox(width: 30),
  HoverIcon(icon: FontAwesomeIcons.xTwitter, url: 'https://twitter.com/your-handle'),
  ],
  ),

  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileContent(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "HI , I’M ZAKI",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Mobile App Developer | AI Enthusiast |",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF5ea092),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Computer Vision Specialist | Metrology Engineer",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF5ea092),
          ),
        ),
        const SizedBox(height: 32),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => onViewMyWorkTap("Projects"),
          child: Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4DB6AC), Color(0xFF00796B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.3),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: AnimatedSlideButton(
              label: "VIEW MY WORK",
              onTap: () => onViewMyWorkTap("Projects"),
            ),





          ),
        ),
        const SizedBox(height: 24),
        Image.asset(
          'assets/im.png',
          width: width * 0.6,
        ),
      ],
    );
  }

  Widget _buildDesktopContent(double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HI , I’M ZAKI",
                  style: GoogleFonts.montserrat(
                    fontSize: 72,
                    fontWeight: FontWeight.w700,
                    color: Colors.teal[800],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Mobile App Developer | AI Enthusiast |",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF5ea092),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Computer Vision Specialist | Metrology Engineer",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF5ea092),
                  ),
                ),
                const SizedBox(height: 40),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => onViewMyWorkTap("Projects"),
                  child: Container(
                    height: 60,
                    width: 280,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4DB6AC), Color(0xFF00796B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.3),
                          offset: const Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: AnimatedSlideButton(
                      label: "VIEW MY WORK",
                      onTap: () => onViewMyWorkTap("Projects"),
                    ),






                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Image.asset(
              'assets/im.png',
              width: width * 0.25,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}

// ✅ Animated sliding icon button component
class AnimatedSlideButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const AnimatedSlideButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  State<AnimatedSlideButton> createState() => _AnimatedSlideButtonState();
}

class _AnimatedSlideButtonState extends State<AnimatedSlideButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: -6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    final isMobile = _isMobile(context);

    return MouseRegion(
      onEnter: (_) {
        if (!isMobile) setState(() => _hovering = true);
      },
      onExit: (_) {
        if (!isMobile) setState(() => _hovering = false);
      },
      child: AnimatedBuilder(
        animation: _floatAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatAnimation.value),
            child: AnimatedScale(
              scale: _hovering ? 1.05 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: child,
            ),
          );
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 14,
              vertical: isMobile ? 12 : 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                colors: [Color(0xFF5ea092), Color(0xFF00796B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00796B).withOpacity(0.25),
                  offset: const Offset(0, 6),
                  blurRadius: 18,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSlide(
                  offset: _hovering ? Offset(0, 0) : const Offset(-0.3, 0),
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.work_outline,
                    color: Colors.white,
                    size: isMobile ? 20 : 26,
                  ),
                ),
                SizedBox(width: isMobile ? 8 : 12),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class HoverIcon extends StatefulWidget {
  final IconData icon;
  final String url;

  const HoverIcon({
    super.key,
    required this.icon,
    required this.url,
  });

  @override
  State<HoverIcon> createState() => _HoverIconState();
}

class _HoverIconState extends State<HoverIcon> {
  bool _hovering = false;

  Future<void> _launchURL() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch ${widget.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: _launchURL,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: _hovering ? 1.2 : 1.0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _hovering ? 0.9 : 1.0,
            child: FaIcon(
              widget.icon,
              color: const Color(0xFF5ea092),
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}