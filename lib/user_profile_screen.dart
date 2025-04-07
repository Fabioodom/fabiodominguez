import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

/// Aplicación principal.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interactive 3D Profile',
      home: const UserProfileScreen(),
    );
  }
}

/// Pantalla de perfil de usuario con fondo interactivo y animado.
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
      // Usamos un Stack para colocar el fondo interactivo detrás del contenido.
      body: Stack(
        children: [
          const InteractiveBackground(),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Imagen de perfil con animación de escala y efecto 3D.
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.8, end: 1),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.elasticOut,
                  builder: (context, scale, child) {
                    return RotatingAvatar(
                      child: Transform.scale(
                        scale: scale as double,
                        child: const CircleAvatar(
                          radius: 200,
                          backgroundImage: AssetImage('assets/profile.png'),
                        ),
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
                      url:
                          'https://www.instagram.com/fabiodom_?igsh=MWllM3Y4eTUxb3dlYg==',
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
                      url:
                          'https://www.linkedin.com/in/fabio-dominguez-collado-909099209',
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
                  'Mobile App Developer and Coding\nenthusiastic',
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
                //const SizedBox(height: 20),
                //const Divider(),
                //const ProfileOption(icon: Icons.privacy_tip, title: 'Privacy'),
                //const ProfileOption(
                    //icon: Icons.history, title: 'Purchase History'),
                //const ProfileOption(
                    //icon: Icons.help_outline, title: 'Help & Support'),
                //const ProfileOption(icon: Icons.settings, title: 'Settings'),
                //const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Fondo interactivo con burbujas que se mueven.
class InteractiveBackground extends StatelessWidget {
  const InteractiveBackground({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: const [
          // Burbujas posicionadas en distintos puntos del fondo.
          Positioned(
            top: 50,
            left: 20,
            child: InteractiveBubble(
              size: 120,
              color: Color.fromARGB(50, 33, 150, 243),
              amplitude: 15,
              duration: Duration(seconds: 4),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 30,
            child: InteractiveBubble(
              size: 140,
              color: Color.fromARGB(50, 233, 30, 99),
              amplitude: 20,
              duration: Duration(seconds: 5),
            ),
          ),
          Positioned(
            top: 200,
            right: 50,
            child: InteractiveBubble(
              size: 160,
              color: Color.fromARGB(50, 76, 175, 80),
              amplitude: 10,
              duration: Duration(seconds: 3),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 50,
            child: InteractiveBubble(
              size: 180,
              color: Color.fromARGB(50, 255, 193, 7),
              amplitude: 18,
              duration: Duration(seconds: 6),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget para cada burbuja interactiva que se mueve y reacciona al hover.
class InteractiveBubble extends StatefulWidget {
  final double size;
  final Color color;
  final double amplitude;
  final Duration duration;

  const InteractiveBubble({
    super.key,
    required this.size,
    required this.color,
    this.amplitude = 10,
    this.duration = const Duration(seconds: 3),
  });

  @override
  _InteractiveBubbleState createState() => _InteractiveBubbleState();
}

class _InteractiveBubbleState extends State<InteractiveBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event) {
    setState(() {
      _scale = 1.2;
    });
  }

  void _onExit(PointerEvent event) {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // Movimiento circular basado en la animación.
          final double angle = _controller.value * 2 * pi;
          final double offsetX = widget.amplitude * sin(angle);
          final double offsetY = widget.amplitude * cos(angle);
          return Transform.translate(
            offset: Offset(offsetX, offsetY),
            child: Transform.scale(
              scale: _scale,
              child: child,
            ),
          );
        },
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}

/// Widget que aplica un efecto 3D basado en el movimiento del mouse sobre la imagen de perfil.
class RotatingAvatar extends StatefulWidget {
  final Widget child;
  const RotatingAvatar({super.key, required this.child});
  @override
  _RotatingAvatarState createState() => _RotatingAvatarState();
}

class _RotatingAvatarState extends State<RotatingAvatar> {
  double _xRotation = 0;
  double _yRotation = 0;
  void _onHover(PointerEvent event) {
    final size = context.size ?? const Size(200, 200);
    setState(() {
      _yRotation = (event.localPosition.dx - size.width / 2) / 100;
      _xRotation = -(event.localPosition.dy - size.height / 2) / 100;
    });
  }
  void _onExit(PointerEvent event) {
    setState(() {
      _xRotation = 0;
      _yRotation = 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // Agrega perspectiva.
          ..rotateX(_xRotation)
          ..rotateY(_yRotation),
        alignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}

/// Widget para cada icono social interactivo.
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

/// Widget para cada opción del perfil.
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

/// Tarjeta interactiva para cada proyecto.
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
