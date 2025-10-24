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
      appBar: AppBar(
        backgroundColor: AppConstants.darkBackground,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Selecciona tu nivel',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Contenedor del contenido principal - ocupa el espacio disponible
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                decoration: BoxDecoration(
                  color: AppConstants.darkBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.all(isMobile ? 12 : 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Percent Indicator en la parte superior - CORREGIDO
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: FractionallySizedBox(
                          widthFactor: 0.95, // Ocupa 95% del ancho disponible
                          child: LinearPercentIndicator(
                            animation: true,
                            lineHeight: 40.0,
                            animationDuration: 1000,
                            percent: 0.25,
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
                      
                      // Chat bubble - Mensaje de Lufiboti
                      _buildChatBubble(
                        '¡Excelente! Para personalizar tu experiencia, por favor selecciona tu nivel de conocimiento en robótica educativa:',
                        isBot: true,
                      ),
                      SizedBox(height: isMobile ? 30 : 40),
                      
                      // Contenedor centrado para las opciones
                      Center(
                        child: Container(
                          width: 470,
                          child: Column(
                            children: [
                              // Opciones de nivel de experiencia
                              _buildExperienceOption(
                                context,
                                title: 'ALGO DE EXPERIENCIA, PERO NECESITO REPASAR',
                                description: 'He trabajado con robótica antes, pero quiero reforzar mis conocimientos básicos.',
                                onTap: () {
                                  _navigateToNextScreen(context, 'Principiante con experiencia');
                                },
                              ),
                              SizedBox(height: isMobile ? 20 : 25),
                              
                              _buildExperienceOption(
                                context,
                                title: 'CONFIADO EN MIS HABILIDADES EN ROBOTICA EDUCATIVA',
                                description: 'Tengo buena base y quiero profundizar en conceptos más avanzados.',
                                onTap: () {
                                  _navigateToNextScreen(context, 'Intermedio');
                                },
                              ),
                              SizedBox(height: isMobile ? 20 : 25),
                              
                              _buildExperienceOption(
                                context,
                                title: 'EXPERTO EN ROBOTICA EDUCATIVA',
                                description: 'Tengo amplia experiencia y busco contenido especializado y avanzado.',
                                onTap: () {
                                  _navigateToNextScreen(context, 'Avanzado');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Divisor blanco
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.white,
            ),

            // Contenedor del botón
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
                vertical: isMobile ? 10 : 15,
              ),
              decoration: BoxDecoration(
                color: AppConstants.darkBackground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 300,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navegación a la siguiente pantalla
                        _navigateToDefaultScreen(context);
                      },
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

  // === MÉTODOS NECESARIOS ===

  Widget _buildExperienceOption(
    BuildContext context, {
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
          width: 470, // Ancho fijo según diseño
          height: 90,  // Alto fijo según diseño
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
    // Aquí puedes navegar a la siguiente pantalla según el nivel seleccionado
    print('Nivel seleccionado: $nivel');
    
    // Por ahora solo muestra un snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nivel seleccionado: $nivel'),
        backgroundColor: AppConstants.welcomePrimary,
      ),
    );
  }

  void _navigateToDefaultScreen(BuildContext context) {
    // Navegación por defecto cuando se presiona el botón CONTINUAR
    print('Navegación por defecto');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Continuando con navegación por defecto'),
        backgroundColor: AppConstants.welcomePrimary,
      ),
    );
  }

  // Widget para crear burbujas de chat
  Widget _buildChatBubble(String text, {required bool isBot}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isBot
            ? AppConstants.welcomePrimary.withOpacity(0.3)
            : AppConstants.welcomePrimary,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(isBot ? 5 : 20),
          bottomRight: Radius.circular(isBot ? 20 : 5),
        ),
        border: Border.all(
          color: AppConstants.welcomePrimary,
          width: 1.5,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
          height: 1.5,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}