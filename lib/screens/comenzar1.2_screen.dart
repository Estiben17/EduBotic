import 'package:ava_platform/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
            // BARRA DE PROGRESO
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

            // CONTENIDO PRINCIPAL
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TÍTULO
                    Text(
                      'Pantalla Comenzar 1.2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isMobile ? 30 : 40),

                    // CONTENIDO EJEMPLO
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppConstants.darkContainer,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppConstants.welcomePrimary,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.school,
                            color: AppConstants.welcomePrimary,
                            size: 60,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Esta es la siguiente pantalla después de seleccionar el nivel de experiencia.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // BOTÓN CONTINUAR
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
                      onPressed: () {
                        // Navegar a la siguiente pantalla cuando la necesites
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
}