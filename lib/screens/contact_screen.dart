import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
  late AnimationController _circleController;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _msgCtrl = TextEditingController();

  // ✅ Single icon color
  final Color iconColor = Colors.black87;

  final Map<String, Map<String, dynamic>> socialLinks = {
    'LinkedIn': {
      'url': 'https://linkedin.com/in/aditidubey',
      'icon': Icons.business,
    },
    'GitHub': {
      'url': 'https://github.com/aditidubey',
      'icon': Icons.code,
    },
    'Instagram': {
      'url': 'https://instagram.com/aditi.designs',
      'icon': Icons.camera_alt,
    },
    'Dribbble': {
      'url': 'https://dribbble.com/aditidubey',
      'icon': Icons.sports_basketball,
    },
  };

  @override
  void initState() {
    super.initState();
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
  }

  @override
  void dispose() {
    _circleController.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Offset _circularOffset(double angle, double radius) {
    return Offset(cos(angle) * radius, sin(angle) * radius);
  }

  Widget _floatingCircle({
    required Color color,
    required double baseTop,
    required double baseLeft,
    required double size,
    required double offsetAngle,
    required double offsetRadius,
  }) {
    return AnimatedBuilder(
      animation: _circleController,
      builder: (context, child) {
        final angle = _circleController.value * 2 * pi + offsetAngle;
        final offset = _circularOffset(angle, offsetRadius);
        return Positioned(
          top: baseTop + offset.dy,
          left: baseLeft + offset.dx,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  // ignore: deprecated_member_use
                  color.withOpacity(0.4),
                  // ignore: deprecated_member_use
                  color.withOpacity(0.0),
                ],
                stops: const [0.3, 1.0],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextInput({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black87),
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black87),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter $label';
        return null;
      },
    );
  }

  Widget _buildSocialIcons() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: socialLinks.entries.map((entry) {
        final info = entry.value;
        return InkWell(
          onTap: () async {
            final Uri url = Uri.parse(info['url']);
            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Could not launch ${info['url']}')),
              );
            }
          },
          borderRadius: BorderRadius.circular(50),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade200,
              child: Icon(
                info['icon'],
                color: iconColor,
                size: 28,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _floatingCircle(
            color: Colors.tealAccent,
            baseTop: 80,
            baseLeft: -60,
            size: 180,
            offsetAngle: 0,
            offsetRadius: 30,
          ),
          _floatingCircle(
            color: Colors.purpleAccent,
            baseTop: screen.height * 0.55,
            baseLeft: screen.width * 0.65,
            size: 160,
            offsetAngle: pi / 2,
            offsetRadius: 25,
          ),
          _floatingCircle(
            color: Colors.orangeAccent,
            baseTop: screen.height * 0.85,
            baseLeft: -40,
            size: 200,
            offsetAngle: pi,
            offsetRadius: 20,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let's Connect",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextInput(label: 'Name', controller: _nameCtrl),
                      const SizedBox(height: 12),
                      _buildTextInput(label: 'Email', controller: _emailCtrl),
                      const SizedBox(height: 12),
                      _buildTextInput(
                        label: 'Message',
                        controller: _msgCtrl,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.send, color: Colors.white),
                        label: const Text(
                          "Send Message",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Message Sent!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            _nameCtrl.clear();
                            _emailCtrl.clear();
                            _msgCtrl.clear();
                          }
                        },
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Follow Me",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSocialIcons(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
