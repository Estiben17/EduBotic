import 'package:ava_platform/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ava_platform/screens/login_screen.dart'; // Importar login_screen

class Comenzar12Screen extends StatefulWidget {
  const Comenzar12Screen({super.key});

  @override
  State<Comenzar12Screen> createState() => _Comenzar12ScreenState();
}

class _Comenzar12ScreenState extends State<Comenzar12Screen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: AppConstants.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // CONTENEDOR 1: BARRA DE PROGRESO
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 20,
                vertical: isMobile ? 4 : 4,
              ),
              child: FractionallySizedBox(
                widthFactor: 1.0,
                child: LinearPercentIndicator(
                  animation: true,
                  lineHeight: 27.0,
                  animationDuration: 1000,
                  percent: 0.40, // Aumentado a 40%
                  center: const Text(
                    "40% Completado",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  barRadius: const Radius.circular(12),
                  progressColor: AppConstants.welcomePrimary,
                  backgroundColor: AppConstants.darkContainer,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                ),
              ),
            ),

            // CONTENEDOR 2: CONTENIDO PRINCIPAL
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SECCIÓN IMAGEN + MENSAJE INTEGRADOS
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IMAGEN
                        Container(
                          width: isMobile ? 80 : 120,
                          height: isMobile ? 80 : 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConstants.welcomePrimary.withOpacity(0.3),
                            border: Border.all(
                              color: AppConstants.welcomePrimary,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/edubotic.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // MENSAJE
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppConstants.welcomePrimary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppConstants.welcomePrimary,
                                width: 1.5,
                              ),
                            ),
                            child: const Text(
                              'LISTO PARA UN RECORRIDO EMOCIONANTE',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 30 : 40),
                    
                    // LISTA DE BENEFICIOS
                    Center(
                      child: SizedBox(
                        width: isMobile ? screenWidth * 0.9 : 470,
                        child: Column(
                          children: [
                            _buildBenefitItem(
                              title: 'MEJORA TU CEREBRO',
                              description: 'Desarrolla habilidades cognitivas y de pensamiento lógico',
                              icon: Icons.psychology,
                            ),
                            SizedBox(height: isMobile ? 20 : 25),
                            
                            _buildBenefitItem(
                              title: 'APRENDE COSAS NUEVAS',
                              description: 'Descubre conceptos innovadores en robótica y tecnología',
                              icon: Icons.school,
                            ),
                            SizedBox(height: isMobile ? 20 : 25),
                            
                            _buildBenefitItem(
                              title: 'HAZ QUE EL TIEMPO PERDURE',
                              description: 'Crea experiencias de aprendizaje que perdurarán en el tiempo',
                              icon: Icons.access_time_filled,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Divisor blanco
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.white,
            ),

            // CONTENEDOR 3: BOTÓN CONTINUAR
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
                vertical: isMobile ? 10 : 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 300,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => _navigateToLoginScreen(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.welcomePrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'CONTINUAR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.welcomeWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para los ítems de beneficios
  Widget _buildBenefitItem({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppConstants.darkContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppConstants.welcomePrimary.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícono
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppConstants.welcomePrimary.withOpacity(0.2),
                border: Border.all(
                  color: AppConstants.welcomePrimary,
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                color: AppConstants.welcomePrimary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            
            // Contenido de texto
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Navegación a LoginScreen
  void _navigateToLoginScreen(BuildContext context) {
    print('Navegando a LoginScreen');
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}