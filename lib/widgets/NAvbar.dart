import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final void Function(String) onItemTap;

  const NavBar({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: isMobile ? 0 : 150),
            child: Image.asset(
              'assets/logo.png',
              height: 50,
              width: 100,
            ),
          ),
          isMobile
              ? Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 28),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          )
              : Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Row(
              children: [
                NavItem(title: "Home", onTap: onItemTap),
                const SizedBox(width: 50),
                NavItem(title: "Projects", onTap: onItemTap),
                const SizedBox(width: 50),
                NavItem(title: "Certificates", onTap: onItemTap),
                const SizedBox(width: 50),
                NavItem(title: "Contact", onTap: onItemTap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatefulWidget {
  final String title;
  final void Function(String) onTap;

  const NavItem({super.key, required this.title, required this.onTap});

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> with SingleTickerProviderStateMixin {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.title),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 18,
                  color: _isHovering ? const Color(0xFF5ea092) : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                child: Text(widget.title),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2,
                width: _isHovering ? 20 : 0,
                color: const Color(0xFF5ea092),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
