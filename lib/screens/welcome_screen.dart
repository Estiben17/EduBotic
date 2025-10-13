import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(37, 38, 39, 1),
      body: SafeArea(
        child: isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          children: [
            _buildImagenContainer(context),
            const SizedBox(height: 40),
            _buildRellenoContainer(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildImagenContainer(context),
        ),
        Expanded(
          child: _buildRellenoContainer(context),
        ),
      ],
    );
  }

  Widget _buildImagenContainer(BuildContext context) {
    return Container(
      key: const Key('imagenContainer'),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(37, 38, 39, 1),
      ),
      child: Center(
        child: Container(
          width: 350,
          height: 350,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(50, 51, 52, 1),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              "assets/images/edubotic.png",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Si hay error, mostrar el fallback
                return _buildImageFallback();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageFallback() {
    return Container(
      color: const Color.fromRGBO(50, 51, 52, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 60,
            color: Colors.orange,
          ),
          const SizedBox(height: 10),
          const Text(
            'Imagen no encontrada',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Ruta: assets/images/edubotic.png',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'Verifica pubspec.yaml y la ruta',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Botón para debug
              debugPrint('Intentando cargar: assets/images/edubotic.png');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text(
              'Debug Info',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRellenoContainer(BuildContext context) {
    return Container(
      key: const Key('rellenoContainer'),
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(37, 38, 39, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '¡LA MANERA GRATUITA, DIVERTIDA Y EFECTIVA DE APRENDER SOBRE LA ROBÓTICA EDUCATIVA!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.2,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 40),
          
          const Text(
            'Descubre el fascinante mundo de la robótica a través de nuestra plataforma interactiva diseñada para todos los niveles.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 60),
          
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(initialShowRegister: true),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text(
                'COMENZAR',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(37, 38, 39, 1),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          SizedBox(
            width: double.infinity,
            height: 60,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(initialShowRegister: false),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.transparent,
              ),
              child: const Text(
                'YA TENGO UNA CUENTA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}