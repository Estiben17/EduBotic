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
      // Navegar al home
      print(' Login exitoso: ${user.email}');
    } else {
      // Mostrar error
      print(' Error en login');
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo o ícono
                Icon(
                  Icons.school,
                  size: 80,
                  color: Color(AppConstants.primaryColor),
                ),
                const SizedBox(height: 20),
                
                // Título
                Text(
                  _showRegister ? 'Crear Cuenta' : 'Iniciar Sesión',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _showRegister 
                    ? 'Regístrate en EduBotic'
                    : 'Bienvenido a la plataforma',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                
                // Formulario
                if (_showRegister)
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre completo',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                
                if (_showRegister) const SizedBox(height: 16),
                
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                
                // Botón de acción
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _showRegister ? _register : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(AppConstants.primaryColor),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          _showRegister ? 'Registrarse' : 'Iniciar Sesión',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                
                const SizedBox(height: 20),
                
                // Cambiar entre login/registro
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showRegister = !_showRegister;
                    });
                  },
                  child: Text(
                    _showRegister
                        ? '¿Ya tienes cuenta? Inicia sesión'
                        : '¿No tienes cuenta? Regístrate',
                    style: TextStyle(
                      color: Color(AppConstants.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}