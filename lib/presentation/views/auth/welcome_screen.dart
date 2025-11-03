import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/constants.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: AppConstants.darkBackground,
      body: SafeArea(
        child: isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
      ),
    );
  }

  // ===========================================================================
  // LAYOUTS PRINCIPALES
  // ===========================================================================
  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildImageContainer(),
          const SizedBox(height: 40),
          _buildContentContainer(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildImageContainer()),
        Expanded(child: _buildContentContainer(context)),
      ],
    );
  }

  // ===========================================================================
  // COMPONENTES REUTILIZABLES
  // ===========================================================================
  Widget _buildImageContainer() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Container(
          width: 600,
          height: 600,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SvgPicture.asset(
              "assets/images/edubotic.svg",
              fit: BoxFit.contain,
              errorBuilder: _buildErrorWidget,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, Object error, StackTrace? stackTrace) {
    return Container(
      color: AppConstants.darkContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.orange),
          const SizedBox(height: 10),
          const Text('Imagen no encontrada', style: TextStyle(color: Colors.white)),
          Text(
            'Ruta: assets/images/edubotic.svg', 
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildContentContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 40),
          _buildDescription(),
          const SizedBox(height: 60),
          _buildButtons(context),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      '¡LA MANERA GRATUITA, DIVERTIDA Y EFECTIVA DE APRENDER SOBRE LA ROBÓTICA EDUCATIVA!',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w900,
        color: Colors.white,
        height: 1.2,
      ),
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Descubre el fascinante mundo de la robótica a través de nuestra plataforma interactiva diseñada para todos los niveles.',
      style: TextStyle(
        fontSize: 16,
        color: Colors.white70,
        height: 1.5,
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        _buildRegisterButton(context),
        const SizedBox(height: 20),
        _buildLoginButton(context),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () => _navigateToRegister(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.welcomePrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
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

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: OutlinedButton(
        onPressed: () => _navigateToLogin(context),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
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

  // ===========================================================================
  // MÉTODOS DE NAVEGACIÓN
  // ===========================================================================
  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(initialShowRegister: true),
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(initialShowRegister: false),
      ),
    );
  }
}