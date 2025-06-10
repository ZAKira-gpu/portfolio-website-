import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final List<String> tools;
  final List<String> platforms;
  final List<String> tags;
  final List<String> links;
  final String developer;

  const ProjectDetailsPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.tools,
    required this.platforms,
    required this.tags,
    required this.links,
    required this.developer,
  });

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // IMAGE HEADER
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFe0f2f1), Color(0xFFb2dfdb)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.network(
                      widget.imageUrl,
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.5, // fills most of upper half
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // DESCRIPTION + INFO
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFFe0f2f1), Color(0xFFb2dfdb)],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: ClipPath(
                        clipper: TopCurveClipper(progress: _controller.value),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF5ea092), Color(0xFF2c5952)],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth < 800) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildLeftDescription(),
                                        const SizedBox(height: 24),
                                        _buildRightInfo(),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(flex: 3, child: _buildLeftDescription()),
                                      Expanded(flex: 2, child: _buildRightInfo()),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftDescription() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 80),
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _isExpanded
                    ? Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    color: Color(0xFFCCE8DA),
                  ),
                )
                    : Text(
                  widget.description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    color: Color(0xFFCCE8DA),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: Text(
                  _isExpanded ? 'Show less' : 'Read more',
                  style: const TextStyle(
                    fontSize:18,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRightInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 20,
          children: [
            infoColumn(FontAwesomeIcons.gear, 'Technologies', widget.tools),
            const SizedBox(width: 10),
            infoColumn(FontAwesomeIcons.laptopCode, 'Platforms', widget.platforms),
            const SizedBox(width: 10),
            infoColumn(FontAwesomeIcons.hashtag, 'Tags', widget.tags.map((t) => '#$t').toList()),
            const SizedBox(width: 10),
            infoColumn(FontAwesomeIcons.link, 'Links', widget.links, isLink: true),
            const SizedBox(width: 10),
            infoColumn(FontAwesomeIcons.user, 'Developer', ['@${widget.developer}']),
          ],
        ),
      ),
    );
  }

  Widget infoColumn(IconData icon, String title, List<String> items,
      {bool isLink = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            children: [
              Icon(icon, color: const Color(0xFFCCE8DA), size: 14),
              const SizedBox(width: 4),
              Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCCE8DA),

                ),
              ),
            ],
          ),

        const SizedBox(height: 8),
        ...items.map(
              (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: isLink
                ? GestureDetector(
              onTap: () => launchUrl(Uri.parse(item),
                  mode: LaunchMode.externalApplication),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Montserrat',
                  color: Color(0xFFCCE8DA),
                  decoration: TextDecoration.underline,
                ),
              ),
            )
                : Text(
              item,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Montserrat',
                color: Color(0xFFCCE8DA),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  final double progress;
  TopCurveClipper({required this.progress});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 30);
    path.quadraticBezierTo(
      size.width / 4,
      -80 * progress,
      size.width / 2,
      60 + 30 * progress,
    );
    path.quadraticBezierTo(
      size.width * 3 / 4,
      120 - 60 * progress,
      size.width,
      30,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant TopCurveClipper oldClipper) => true;
}
