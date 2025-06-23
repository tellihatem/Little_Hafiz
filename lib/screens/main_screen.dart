import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          const Positioned.fill(
            child: Image(
              image: AssetImage('assets/images/background/background.png'),
              fit: BoxFit.cover,
            ),
          ),

          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title with shadow
                      const Text(
                        'الحافظ الصغير',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoKufiArabic',
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 10,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Buttons
                      _buildMainButton(
                        icon: Icons.menu_book,
                        text: 'احفظ السورة',
                        color: const Color(0xFF4CAF50), // Green
                        onPressed: () {},
                      ),
                      const SizedBox(height: 20),
                      _buildMainButton(
                        icon: Icons.headphones,
                        text: 'استمع وسجل',
                        color: const Color(0xFF2196F3), // Blue
                        onPressed: () {},
                      ),
                      const SizedBox(height: 20),
                      _buildMainButton(
                        icon: Icons.games,
                        text: 'العاب',
                        color: const Color(0xFFFF9800), // Orange
                        onPressed: () {},
                      ),
                      const SizedBox(height: 20),
                      _buildMainButton(
                        icon: Icons.lock,
                        text: 'وضع الوالدين',
                        color: const Color(0xFF607D8B), // Blue Grey
                        onPressed: () {},
                      ),
                      const SizedBox(height: 20),
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

  Widget _buildMainButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 300,
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            Color.lerp(color, Colors.black, 0.2) ?? color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoKufiArabic',
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 15),
            Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
