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
      print('Login exitoso: ${user.email}');
    } else {
      print('Error en login');
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
      print(' Registro exitoso: ${user.name}');
    } else {
      print(' Error en registro');
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
    backgroundColor: Color (0xFF1E88E5),
    body: Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 400,
        margin: const EdgeInsets.only(left: 130, top: 60, bottom: 60),
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Botón Atrás
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.black, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'ATRAS',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

              // Botones ACCEDER y REGISTRARSE - EXACTAMENTE como en el mockup
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _showRegister 
                                ? Colors.grey[300]! 
                                : Colors.blue,
                            width: 2,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _showRegister = false;
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: _showRegister 
                              ? Colors.grey 
                              : Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'ACCEDER',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _showRegister 
                                ? Colors.blue 
                                : Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _showRegister = true;
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: _showRegister 
                              ? Colors.blue 
                              : Colors.grey,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'REGISTRARSE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Campos de texto - SIMPLES como en el mockup
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'DIRECCIÓN DE CORREO',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'CONTRASEÑA',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 30),

              // Botón principal
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _showRegister ? _register : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        _showRegister ? 'CREAR CUENTA' : 'INICIAR SESIÓN',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

              // El resto lo hacemos en la siguiente parte...
            ],
          ),
        ),
      ),
    );
  }
}