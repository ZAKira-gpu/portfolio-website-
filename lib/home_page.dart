import 'package:flutter/material.dart';
import 'package:website_portfolio/theme/gradient_theme.dart';
import 'package:website_portfolio/widgets/certifcates section_page.dart';
import 'package:website_portfolio/widgets/footer.dart';
import 'package:website_portfolio/widgets/navbar.dart';
import 'package:website_portfolio/widgets/hero_section.dart';
import 'package:website_portfolio/widgets/projects_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey certificatesKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  void scrollToSection(String section) {
    final sectionMap = {
      "Home": homeKey,
      "Certificates": certificatesKey, // ✅ matches "Certificates"
      "Projects": projectsKey,
      "Contact": contactKey,
    };


    final targetContext = sectionMap[section]?.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradient = Theme.of(context).extension<GradientTheme>()?.background;

    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _buildDrawerItem("Home"),
            _buildDrawerItem("Certificate"),
            _buildDrawerItem("Projects"),
            _buildDrawerItem("Contact"),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              NavBar(onItemTap: scrollToSection),

              Container(
                key: homeKey,
                child: HeroSection(
                  onViewMyWorkTap: scrollToSection,
                ),
              ),

              const SectionDivider(title: "Certificates", icon: Icons.school),

              Container(
                key: certificatesKey,
                child: CertificateSection(),
              ),


              const SectionDivider(title: "Projects", icon: Icons.code),

              Container(
                key: projectsKey,
                child: const ProjectsSection(),
              ),


               CustomFooter(key: contactKey,),


            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildDrawerItem(String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop();
        scrollToSection(title);
      },
    );
  }
}

// Section Divider Widget
class SectionDivider extends StatefulWidget {
  final String title;
  final IconData icon;

  const SectionDivider({
    Key? key,
    required this.title,
    this.icon = Icons.star,
  }) : super(key: key);

  @override
  State<SectionDivider> createState() => _SectionDividerState();
}

class _SectionDividerState extends State<SectionDivider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // continuous shimmer

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(_fade);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildShimmerLine() {
    return Expanded(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final shimmerWidth = 0.3;
          final shimmerOffset = (_controller.value * (1 + shimmerWidth)) - shimmerWidth;

          return ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: const [
                  Color(0xFF1f3f3a),
                  Color(0xFF5ea092),
                  Color(0xFF1f3f3a),
                ],
                stops: const [0.0, 0.5, 1.0],
                begin: Alignment(-1.0 + shimmerOffset, 0),
                end: Alignment(1.0 + shimmerOffset, 0),
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Container(
              height: 2,
              decoration: const BoxDecoration(
                color: Color(0xFF5ea092),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildShimmerLine(),
              const SizedBox(width: 12),
              Icon(widget.icon, size: 20, color: const Color(0xFF5ea092)),
              const SizedBox(width: 8),
              Text(
                widget.title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                  color: Color(0xFF5ea092),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(width: 8),
              _buildShimmerLine(),
            ],
          ),
        ),
      ),
    );
  }
}