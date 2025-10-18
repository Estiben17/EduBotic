import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  final bool initialShowRegister;

  const LoginScreen({
    super.key,
    this.initialShowRegister = false,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  
  bool _isLoading = false;
  bool _showRegister = false;

  void _login() async {
    setState(() => _isLoading = true);  
    
    final user = await _authService.signInWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    
    setState(() => _isLoading = false);
    
    if (user != null) {
      print('✅ Login exitoso: ${user.email}');
    } else {
      print('❌ Error en login');
    }
  }

  void _register() async {
    setState(() => _isLoading = true);
    
    final user = await _authService.registerWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _nameController.text.trim(),
    );
    
    setState(() => _isLoading = false);
    
    if (user != null) {
      print('✅ Registro exitoso: ${user.name}');
    } else {
      print('❌ Error en registro');
    }
  }

  @override
  void initState() {
    super.initState();
    _showRegister = widget.initialShowRegister;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botón Atrás
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(height: 30),
              
              // Título principal - SIMPLIFICADO
              Center(
                child: Text(
                  _showRegister ? 'CREAR CUENTA' : 'INICIAR SESIÓN',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              
              Center(
                child: Text(
                  _showRegister 
                    ? 'Regístrate en EduBotic'
                    : 'Bienvenido a la plataforma',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // Botones ACCEDER/REGISTRARSE - ARRIBA DE LOS CAMPOS
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showRegister = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _showRegister 
                            ? Colors.grey[300] 
                            : Color(AppConstants.primaryColor),
                        foregroundColor: _showRegister 
                            ? Colors.grey 
                            : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('ACCEDER'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showRegister = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _showRegister 
                            ? Color(AppConstants.primaryColor) 
                            : Colors.grey[300],
                        foregroundColor: _showRegister 
                            ? Colors.white 
                            : Colors.grey,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('REGISTRARSE'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              
              // Campos del formulario
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (_showRegister)
                        _buildTextField(
                          controller: _nameController,
                          hintText: 'Nombre completo',
                        ),
                      
                      if (_showRegister) const SizedBox(height: 20),
                      
                      _buildTextField(
                        controller: _emailController,
                        hintText: 'Dirección de correo',
                      ),
                      const SizedBox(height: 20),
                      
                      _buildTextField(
                        controller: _passwordController,
                        hintText: 'Contraseña',
                        isPassword: true,
                      ),
                      const SizedBox(height: 30),
                      
                      // Botón principal de acción
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _showRegister ? _register : _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(AppConstants.primaryColor),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 2,
                              ),
                              child: Text(
                                _showRegister ? 'CREAR CUENTA' : 'INICIAR SESIÓN',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      
                      const SizedBox(height: 20),
                      
                      // Enlace "Olvidé mi contraseña" - SOLO EN MODO LOGIN
                      if (!_showRegister)
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // TODO: Implementar recuperación de contraseña
                            },
                            child: const Text(
                              'OLVIDÉ MI CONTRASEÑA',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      
                      const SizedBox(height: 40),
                      
                      // Separador
                      Row(
                        children: [
                          Expanded(
                            child: Container(height: 1, color: Colors.grey[300]),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'O continúa con',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(height: 1, color: Colors.grey[300]),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Botones de redes sociales
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            icon: 'G',
                            label: 'Google',
                            onPressed: () {
                              // TODO: Implementar login con Google
                            },
                          ),
                          const SizedBox(width: 20),
                          _buildSocialButton(
                            icon: 'M',
                            label: 'Microsoft',
                            onPressed: () {
                              // TODO: Implementar login con Microsoft
                            },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Términos y condiciones
                      const Text(
                        'AL CONTINUAR ACEPTAS NUESTROS TÉRMINOS\nDE USO Y POLÍTICA DE PRIVACIDAD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(AppConstants.primaryColor)),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!),
              color: Colors.grey[50],
            ),
            child: Center(
              child: Text(
                icon,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}