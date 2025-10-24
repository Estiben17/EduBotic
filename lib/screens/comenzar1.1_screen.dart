import 'package:ava_platform/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Comenzar11Screen extends StatelessWidget {
  const Comenzar11Screen({super.key});

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
                  percent: 0.20,
                  center: const Text(
                    "25% Completado",
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
                    // Conversación con el robot
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagen del robot
                        Container(
                          width: 60,
                          height: 60,
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
                              'assets/images/robot_avatar.png',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Mensaje del robot
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: screenWidth * 0.7,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppConstants.welcomePrimary.withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(20),
                            ),
                            border: Border.all(
                              color: AppConstants.welcomePrimary,
                              width: 1.5,
                            ),
                          ),
                          child: const Text(
                            '¡Excelente! Para personalizar tu experiencia, por favor selecciona tu nivel de conocimiento en robótica educativa:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 30 : 40),
                    
                    // Opciones de nivel
                    Center(
                      child: SizedBox(
                        width: isMobile ? screenWidth * 0.9 : 470,
                        child: Column(
                          children: [
                            _buildExperienceOption(
                              title: 'PRINCIPIANTE COMPLETO',
                              description: 'Estoy empezando desde cero en robótica educativa',
                              onTap: () => _navigateToNextScreen(context, 'Principiante Completo'),
                            ),
                            SizedBox(height: isMobile ? 20 : 25),
                            
                            _buildExperienceOption(
                              title: 'ALGO DE EXPERIENCIA, PERO NECESITO REPASAR',
                              description: 'He trabajado con robótica antes, pero quiero reforzar mis conocimientos básicos.',
                              onTap: () => _navigateToNextScreen(context, 'Algo de Experiencia'),
                            ),
                            SizedBox(height: isMobile ? 20 : 25),
                            
                            _buildExperienceOption(
                              title: 'CONFIADO EN MIS HABILIDADES EN ROBOTICA EDUCATIVA',
                              description: 'Tengo buena base y quiero profundizar en conceptos más avanzados.',
                              onTap: () => _navigateToNextScreen(context, 'Confiado'),
                            ),
                            SizedBox(height: isMobile ? 20 : 25),
                            
                            _buildExperienceOption(
                              title: 'EXPERTO EN ROBOTICA EDUCATIVA',
                              description: 'Tengo amplia experiencia y busco contenido especializado y avanzado.',
                              onTap: () => _navigateToNextScreen(context, 'Experto'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Divisor blanco (no es Container, es solo un Divider)
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
                      onPressed: () => _navigateToDefaultScreen(context),
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

  // Widget para las opciones de experiencia
  Widget _buildExperienceOption({
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
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
              // Círculo de selección
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppConstants.welcomePrimary,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.circle,
                  color: AppConstants.welcomePrimary,
                  size: 10,
                ),
              ),
              const SizedBox(width: 12),
              
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
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
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context, String nivel) {
    print('Nivel seleccionado: $nivel');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nivel seleccionado: $nivel'),
        backgroundColor: AppConstants.welcomePrimary,
      ),
    );
  }

  void _navigateToDefaultScreen(BuildContext context) {
    print('Navegación por defecto');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Continuando con navegación por defecto'),
        backgroundColor: AppConstants.welcomePrimary,
      ),
    );
  }
}