import 'package:ava_platform/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './comenzar1.2_screen.dart';

class Comenzar11Screen extends StatefulWidget {
  const Comenzar11Screen({super.key});

  @override
  State<Comenzar11Screen> createState() => _Comenzar11ScreenState();
}

class _Comenzar11ScreenState extends State<Comenzar11Screen> {
  String? _selectedLevel; // Variable para almacenar la opción seleccionada

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
                    // SECCIÓN IMAGEN + MENSAJE INTEGRADOS
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IMAGEN - ahora a la izquierda del mensaje
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
                        
                        // MENSAJE - ahora a la derecha de la imagen
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
                              '¡Excelente! Para personalizar tu experiencia, por favor selecciona tu nivel de conocimiento en robótica educativa:',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 30 : 40),
                    
                    // Opciones de nivel (se mantienen igual)
                    Center(
                      child: SizedBox(
                        width: isMobile ? screenWidth * 0.9 : 470,
                        child: Column(
                          children: [
                            _buildExperienceOption(
                              title: 'PRINCIPIANTE COMPLETO',
                              description: 'Estoy empezando desde cero en robótica educativa',
                              level: 'Principiante Completo',
                              isSelected: _selectedLevel == 'Principiante Completo',
                              onTap: () => _selectLevel('Principiante Completo'),
                            ),
                            SizedBox(height: isMobile ? 20 : 25),
                            
                            _buildExperienceOption(
                              title: 'ALGO DE EXPERIENCIA, PERO NECESITO REPASAR',
                              description: 'He trabajado con robótica antes, pero quiero reforzar mis conocimientos básicos.',
                              level: 'Algo de Experiencia',
                              isSelected: _selectedLevel == 'Algo de Experiencia',
                              onTap: () => _selectLevel('Algo de Experiencia'),
                            ),
                            SizedBox(height: isMobile ? 20 : 25),
                            
                            _buildExperienceOption(
                              title: 'CONFIADO EN MIS HABILIDADES EN ROBOTICA EDUCATIVA',
                              description: 'Tengo buena base y quiero profundizar en conceptos más avanzados.',
                              level: 'Confiado',
                              isSelected: _selectedLevel == 'Confiado',
                              onTap: () => _selectLevel('Confiado'),
                            ),
                            SizedBox(height: isMobile ? 20 : 25),
                            
                            _buildExperienceOption(
                              title: 'EXPERTO EN ROBOTICA EDUCATIVA',
                              description: 'Tengo amplia experiencia y busco contenido especializado y avanzado.',
                              level: 'Experto',
                              isSelected: _selectedLevel == 'Experto',
                              onTap: () => _selectLevel('Experto'),
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
                      onPressed: _selectedLevel != null 
                          ? () => _navigateToDefaultScreen(context)
                          : null, // Deshabilitar si no hay selección
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedLevel != null 
                            ? AppConstants.welcomePrimary 
                            : AppConstants.welcomePrimary.withOpacity(0.5),
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

  // Método para seleccionar un nivel
  void _selectLevel(String level) {
    setState(() {
      _selectedLevel = level;
    });
    // Solo actualiza la selección, sin mostrar SnackBar
    print('Nivel seleccionado: $level');
  }

  // Widget para las opciones de experiencia - MODIFICADO
  Widget _buildExperienceOption({
    required String title,
    required String description,
    required String level,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 90,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected 
                ? AppConstants.welcomePrimary.withOpacity(0.3) // Color cuando está seleccionado
                : AppConstants.darkContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected 
                  ? AppConstants.welcomePrimary // Borde más destacado cuando está seleccionado
                  : AppConstants.welcomePrimary.withOpacity(0.5),
              width: isSelected ? 3 : 2, // Borde más grueso cuando está seleccionado
            ),
            boxShadow: isSelected 
                ? [
                    BoxShadow(
                      color: AppConstants.welcomePrimary.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Círculo de selección - MODIFICADO
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppConstants.welcomePrimary : Colors.transparent,
                  border: Border.all(
                    color: AppConstants.welcomePrimary,
                    width: 2,
                  ),
                ),
                child: isSelected 
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      )
                    : null,
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
                      style: TextStyle(
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
                        color: isSelected ? Colors.white : Colors.white70,
                        fontSize: 12,
                        height: 1.2,
                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
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

  void _navigateToDefaultScreen(BuildContext context) {
    print('Continuando con nivel: $_selectedLevel');

    // Navegar a Comenzar1_2Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Comenzar12Screen(),
      ),
    );
    
    // Aquí puedes agregar la navegación real a la siguiente pantalla
    // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
  }
}