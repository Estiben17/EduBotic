import 'package:ava_platform/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ava_platform/screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.darkBackground,
      body: SafeArea(
        child: _buildResponsiveLayout(context),
      ),
    );
  }

  Widget _buildResponsiveLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return isMobile 
        ? _buildMobileLayout(context)
        : _buildDesktopLayout(context);
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          children: [
            _WelcomeImageSection(),
            const SizedBox(height: 40),
            _WelcomeContentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _WelcomeImageSection()),
        Expanded(child: _WelcomeContentSection()),
      ],
    );
  }
}

// =============================================================================
// SECCIÓN DE IMAGEN
// =============================================================================

class _WelcomeImageSection extends StatelessWidget {
  const _WelcomeImageSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('imagenContainer'),
      decoration: const BoxDecoration(
        color: AppConstants.darkBackground,
      ),
      child: Center(
        child: Container(
          width: 350,
          height: 350,
          decoration: _buildContainerDecoration(),
          child: _buildImageContent(),
        ),
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: AppConstants.darkContainer,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildImageContent() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SvgPicture.asset(
        "assets/images/edubotic.svg",
        fit: BoxFit.contain,
        placeholderBuilder: (context) => const _ImageFallbackWidget(),
      ),
    );
  }
}

// =============================================================================
// FALLBACK DE IMAGEN
// =============================================================================

class _ImageFallbackWidget extends StatelessWidget {
  const _ImageFallbackWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConstants.darkContainer,
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
            'Ruta: assets/images/edubotic.svg',
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
            onPressed: _debugImageInfo,
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

  void _debugImageInfo() {
    debugPrint('Intentando cargar: assets/images/edubotic.svg');
  }
}

// =============================================================================
// SECCIÓN DE CONTENIDO
// =============================================================================

class _WelcomeContentSection extends StatelessWidget {
  const _WelcomeContentSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('rellenoContainer'),
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
      decoration: const BoxDecoration(
        color: AppConstants.darkBackground,
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WelcomeTitle(),
          SizedBox(height: 40),
          _WelcomeDescription(),
          SizedBox(height: 60),
          _WelcomeButtonsSection(),
        ],
      ),
    );
  }
}

// =============================================================================
// COMPONENTES DE TEXTO
// =============================================================================

class _WelcomeTitle extends StatelessWidget {
  const _WelcomeTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '¡LA MANERA GRATUITA, DIVERTIDA Y EFECTIVA DE APRENDER SOBRE LA ROBÓTICA EDUCATIVA!',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w900,
        color: Colors.white,
        height: 1.2,
        letterSpacing: -0.5,
      ),
      textAlign: TextAlign.left,
    );
  }
}

class _WelcomeDescription extends StatelessWidget {
  const _WelcomeDescription();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Descubre el fascinante mundo de la robótica a través de nuestra plataforma interactiva diseñada para todos los niveles.',
      style: TextStyle(
        fontSize: 16,
        color: Colors.white70,
        height: 1.5,
      ),
    );
  }
}

// =============================================================================
// SECCIÓN DE BOTONES
// =============================================================================

class _WelcomeButtonsSection extends StatelessWidget {
  const _WelcomeButtonsSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _StartButton(),
        SizedBox(height: 20),
        _LoginButton(),
      ],
    );
  }
}

class _StartButton extends StatelessWidget {
  const _StartButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () => _navigateToRegister(context), // ✅ Cambiado el nombre
        style: _buildButtonStyle(),
        child: const Text(
          'REGISTRARSE',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppConstants.welcomeWhite,
          ),
        ),
      ),
    );
  }

  ButtonStyle _buildButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppConstants.welcomePrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
    );
  }

  void _navigateToRegister(BuildContext context) { // ✅ Método corregido
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(initialShowRegister: true), // ✅ Envía directamente al registro
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: OutlinedButton(
        onPressed: () => _navigateToLogin(context),
        style: _buildButtonStyle(),
        child: const Text(
          'YA TENGO UNA CUENTA',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppConstants.welcomePrimary,
          ),
        ),
      ),
    );
  }

  ButtonStyle _buildButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      side: const BorderSide(
        color: Colors.white,
        width: 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(initialShowRegister: false), // ✅ Envía directamente al login
      ),
    );
  }
}