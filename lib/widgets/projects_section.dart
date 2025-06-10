import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:website_portfolio/widgets/project%20details_page.dart';

class ProjectCard extends StatefulWidget {
  final String imageUrl, title, description;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onTap,

  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(0.0, _hover ? -8 : 0),
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
        margin: const EdgeInsets.all(12),
        width: 420,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(widget.imageUrl, height: 260, width: double.infinity, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
                    const SizedBox(height: 6),
                    Text(widget.description, style: const TextStyle(fontSize: 14, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      ProjectCard(
        imageUrl: 'https://9to5mac.com/wp-content/uploads/sites/6/2023/04/Apple-Weather-app.jpg?quality=82&strip=all&w=1024/300x200',
        title: 'AI Attendance System',
        description: 'A face recognition-based attendance system with YOLOv8.',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>  ProjectDetailsPage(imageUrl: 'https://9to5mac.com/wp-content/uploads/sites/6/2023/04/Apple-Weather-app.jpg?quality=82&strip=all&w=1024', title: "weather app", description: "Experience the weather like never before with our innovative 3D Weather App, designed to deliver real-time weather updates in a visually immersive way. Whether it's a sunny day or a thunderstorm, our app brings the forecast to life with dynamic 3D cloud animations that reflect the current weather conditions — right on your screen.", tools: ["-dart" ,"-flutter"], platforms: ["-android","ios","desktop"], tags: ["mobile app","weather app","Api","3d modeling"], links: ["links"], developer: "Zaki"),
            ),
          );
        },
      ),




    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      decoration: const BoxDecoration(
    gradient: LinearGradient(
    colors: [
        Color(0xFFfafcfb),
    Color(0xFF45a99d),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    ),
    ),


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Centered Title
          Center(
            child: Text(
              "My Projects",
              style: GoogleFonts.montserrat(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 54),

          // Horizontally scrollable project cards aligned to the left
          SizedBox(
            height: 420, // Adjust height to your card height
            width: double.infinity, // Takes up the full width of the screen
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(scrollbars: true),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: projects
                        .map((project) => Padding(
                      padding: const EdgeInsets.only(right: 26),
                      child: project,
                    ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}