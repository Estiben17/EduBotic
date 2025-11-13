import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Importaciones ABSOLUTAS
import 'package:ava_platform/presentation/viewmodels/home_viewmodel.dart';
import 'package:ava_platform/presentation/viewmodels/auth_viewmodel.dart';
import 'package:ava_platform/utils/constants.dart';
import 'package:ava_platform/presentation/views/auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.darkBackground,
      body: SafeArea(
        child: Row(
          children: [
            // SIDEBAR IZQUIERDO - ACCIONES (COLOR MÁS OSCURO)
            _buildSidebar(context),
            
            // CONTENIDO PRINCIPAL
            Expanded(
              child: Container(
                color: const Color(0xFF1E1E1E), // Fondo gris oscuro del contenido
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header con logo EDUBOTICS
                      _buildHeader(context),
                      
                      const SizedBox(height: 30),
                      
                      // Sección RECURSOS
                      _buildResourcesSection(),
                      
                      const SizedBox(height: 30),
                      
                      // Sección PERFIL
                      _buildProfileSection(context),
                      
                      const SizedBox(height: 30),
                      
                      // Sección NOMBRE DE USUARIO
                      _buildUserStatsSection(context),
                      
                      const SizedBox(height: 30),
                      
                      // Sección BADGES
                      _buildBadgesSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D), // Gris más oscuro para el sidebar
        border: Border(
          right: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título ACCIONES
          const Text(
            'ACCIONES',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Botones del sidebar - COLOR NARANJA COMO EN LA IMAGEN
          _buildSidebarButton('EDITAR PERFIL', Icons.edit),
          const SizedBox(height: 15),
          _buildSidebarButton('PERFIL PÚBLICO', Icons.public),
          const SizedBox(height: 15),
          _buildSidebarButton('INVITAR A UN AMIGO', Icons.person_add),
          const SizedBox(height: 15),
          _buildSidebarButton('PREFERENCIAS', Icons.settings),
          
          const Spacer(),
          
          // Botón de cerrar sesión - COLOR ROJO
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildSidebarButton(String text, IconData icon) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF2196F3).withOpacity(0.9), // color
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2196F3)),
      ),
      child: TextButton(
        onPressed: () {
          print('Botón presionado: $text');
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          alignment: Alignment.centerLeft,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFD32F2F).withOpacity(0.9), // ROJO
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD32F2F)),
      ),
      child: TextButton(
        onPressed: () => _signOut(context),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 18),
            SizedBox(width: 8),
            Text(
              'CERRAR SESIÓN',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final user = Provider.of<HomeViewModel>(context).currentUser;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D), // Gris oscuro
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo EDUBOTICS
          const Text(
            'EDUBOTICS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          
          // Nombre de usuario
          Text(
            'Bienvenido, ${user?.name ?? 'Usuario'}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _signOut(BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    
    await authViewModel.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  Widget _buildResourcesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título RECURSOS
        const Text(
          'RECURSOS',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
        
        const SizedBox(height: 15),
        
        // Tarjetas de recursos - COLOR AZUL como en la imagen
        Row(
          children: [
            _buildResourceCard('SIMULADOR', Icons.science, const Color(0xFF2196F3)),
            const SizedBox(width: 10),
            _buildResourceCard('SIMULADOR', Icons.architecture, const Color(0xFF2196F3)),
            const SizedBox(width: 10),
            _buildResourceCard('CLASIFICACIÓN', Icons.leaderboard, const Color(0xFF2196F3)),
          ],
        ),
      ],
    );
  }

  Widget _buildResourceCard(String title, IconData icon, Color color) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.7),
              color.withOpacity(0.4),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D), // Gris oscuro
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado PERFIL
          const Row(
            children: [
              Icon(Icons.person_outline, color: Color(0xFF2196F3), size: 20),
              SizedBox(width: 8),
              Text(
                'PERFIL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              // Badge de progreso - NARANJA
              _ProgressBadge(),
            ],
          ),
          
          const SizedBox(height: 15),
          
          // Título Introducción
          const Text(
            'Introducción',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 10),
          
          // Línea divisoria - Azul
          Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2196F3).withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 15),
          
          // Contenido de introducción
          const Text(
            'INTRODUCCIÓN',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStatsSection(BuildContext context) {
    final user = Provider.of<HomeViewModel>(context).currentUser;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D), // Gris oscuro
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título NOMBRE DE USUARIO
          Text(
            '${user?.name?.toUpperCase() ?? "USUARIO"}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 15),
          
          // Estadísticas - COLOR VERDE como en la imagen
          Row(
            children: [
              _buildStatCard('RACHA', '7 días', Icons.local_fire_department, const Color(0xFF4CAF50)),
              const SizedBox(width: 15),
              _buildStatCard('XP TOTAL', '1,250', Icons.bolt, const Color(0xFF4CAF50)),
              const SizedBox(width: 15),
              _buildStatCard('LIGA ACTUAL', 'Bronce', Icons.emoji_events, const Color(0xFF4CAF50)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgesSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D), // Gris oscuro
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título BADGES
          const Text(
            'BADGES',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          ),
          
          const SizedBox(height: 15),
          
          // Línea divisoria - MORADO
          Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2196F3).withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 15),
          
          // Mensaje de badges
          const Text(
            'Tus insignias aparecerán aquí a medida que avances en el curso.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para el badge de progreso
class _ProgressBadge extends StatelessWidget {
  const _ProgressBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B35).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFF6B35)),
      ),
      child: const Text(
        'Section1, Capítulo 1',
        style: TextStyle(
          color: Color(0xFFFF6B35),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}