import 'package:flutter/material.dart';

class ComenzarScreen extends StatelessWidget {
  const ComenzarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(37, 38, 39, 1),
      body: SafeArea(
        child: Column(
          children: [
            // Contenedor del diálogo - ocupa el espacio disponible
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(37, 38, 39, 1),
                  
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.all(isMobile ? 12 : 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Chat bubble - Saludo
                      _buildChatBubble(
                        '¡HOLA, SOY LUFIBOTI!',
                        isBot: true,
                      ),
                      SizedBox(height: isMobile ? 16 : 24),

                      // Imagen de Lufiboti
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: isMobile ? 500 : 500,
                          maxWidth: isMobile ? 500 : 500,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          'assets/images/edubotic.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Colors.white54,
                                size: 80,
                              ),
                            );
                          },
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
              decoration: const BoxDecoration(
                color: Color.fromRGBO(37, 38, 39, 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 300,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navegación a siguiente pantalla
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(27, 120, 160, 1),
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
                          color: Colors.white,
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

  // Widget para crear burbujas de chat
  Widget _buildChatBubble(String text, {required bool isBot}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isBot
            ? const Color.fromRGBO(27, 120, 160, 1).withOpacity(0.3)
            : const Color.fromRGBO(27, 120, 160, 1),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(isBot ? 5 : 20),
          bottomRight: Radius.circular(isBot ? 20 : 5),
        ),
        border: Border.all(
          color: const Color.fromRGBO(27, 120, 160, 1),
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