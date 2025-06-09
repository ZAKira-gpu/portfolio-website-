import 'package:flutter/material.dart';
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
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero)
            .animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7bc2b9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: IconButton(
                      icon: Icon(
                          Icons.close, size: 28, color: Colors.teal[800]),
                      tooltip: "Close",
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                    color: Colors.teal[800],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 130),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.imageUrl,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.6, // 60% of screen width
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 56),
              Padding(
                padding: const EdgeInsets.only(left: 150),
                child: Wrap(
                  spacing: 42,
                  runSpacing: 44,
                  children: [
                    _buildInfoSection(
                        Icons.memory, 'Technologies', widget.tools),
                    _buildInfoSection(
                        Icons.devices, 'Platforms', widget.platforms),
                    _buildInfoSection(Icons.tag, 'Tags',
                        widget.tags.map((t) => '#$t').toList()),
                    _buildInfoSection(
                        Icons.link, 'Links', widget.links, isLink: true),
                    _buildInfoSection(
                        Icons.person, 'Developer', ['@${widget.developer}']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(IconData icon,
      String title,
      List<String> items, {
        bool isLink = false,
      }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 240, maxWidth: 300),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) =>
            Opacity(
              opacity: _fadeAnimation.value,
              child: SlideTransition(
                position: _slideAnimation,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                          )
                        ],
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Icon(icon, size: 22, color: Colors.teal[800]),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              color: Colors.teal[800],
                              shadows: [
                                Shadow(
                                  color: Colors.teal.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(1, 1),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...items.map(
                                (item) =>
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 4, left: 32),
                                  child: isLink
                                      ? GestureDetector(
                                    onTap: () async {
                                      final Uri url = Uri.parse(item);
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text(
                                              'Could not launch $item')),
                                        );
                                      }
                                    },
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Montserrat',
                                        color: Colors.teal[800],
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  )
                                      : Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                          )
                        ],
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
