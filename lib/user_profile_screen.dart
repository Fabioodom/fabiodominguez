import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
//Prueba de commit

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.menu),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.8, end: 1),
              duration: const Duration(milliseconds: 700),
              curve: Curves.elasticOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/profile.jpeg'),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(
                  icon: FontAwesomeIcons.instagram,
                  url: 'https://www.instagram.com/fabiodom_?igsh=MWllM3Y4eTUxb3dlYg==',
                ),
                SocialIcon(
                  icon: FontAwesomeIcons.google,
                  url: 'mailto:fabiodominguez2003@gmail.com',
                ),
                SocialIcon(
                  icon: FontAwesomeIcons.whatsapp,
                  url: 'https://wa.me/34603041377',
                ),
                SocialIcon(
                  icon: FontAwesomeIcons.linkedinIn,
                  url: 'https://www.linkedin.com/in/fabio-dominguez-collado-909099209',
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Fabio Dominguez Collado',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              '@fabiodom_',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Mobile App Developer and Open\nsource enthusiastic',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Projects',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const ProjectCard(
              title: 'App Fichar Empresa (Flutter)',
              url: 'https://app-fichar.vercel.app/',
            ),
            const ProjectCard(
              title: 'App Comisiones (Flutter)',
              url: 'https://app-comisiones.vercel.app/',
            ),
            const ProjectCard(
              title: 'Web Servicios (Autónomo)',
              url: 'https://www.elysianluxuryconcierge.com/',
            ),
            const ProjectCard(
              title: 'Perfil GitHub',
              url: 'https://github.com/Fabioodom',
            ),
            const SizedBox(height: 20),
            const Divider(),
            const ProfileOption(icon: Icons.privacy_tip, title: 'Privacy'),
            const ProfileOption(icon: Icons.history, title: 'Purchase History'),
            const ProfileOption(icon: Icons.help_outline, title: 'Help & Support'),
            const ProfileOption(icon: Icons.settings, title: 'Settings'),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;

  const SocialIcon({super.key, required this.icon, required this.url});

  @override
  State<SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<SocialIcon>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _onPressed(true),
      onExit: (_) => _onPressed(false),
      child: GestureDetector(
        onTapDown: (_) => _onPressed(true),
        onTapUp: (_) => _onPressed(false),
        onTapCancel: () => _onPressed(false),
        onTap: () => _launchURL(widget.url),
        child: AnimatedScale(
          scale: _isPressed ? 0.9 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(widget.icon, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed(bool value) {
    setState(() {
      _isPressed = value;
    });
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileOption({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String url;

  const ProjectCard({super.key, required this.title, required this.url});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _onPressed(true),
      onExit: (_) => _onPressed(false),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: GestureDetector(
            onTapDown: (_) => _onPressed(true),
            onTapUp: (_) => _onPressed(false),
            onTapCancel: () => _onPressed(false),
            onTap: () => _launchURL(widget.url),
            child: AnimatedScale(
              scale: _isPressed ? 0.95 : 1.0,
              duration: const Duration(milliseconds: 100),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.link, color: Colors.brown),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Icon(Icons.open_in_new, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed(bool value) {
    setState(() {
      _isPressed = value;
    });
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
