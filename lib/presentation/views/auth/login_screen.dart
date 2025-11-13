import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Importaciones ABSOLUTAS
import 'package:ava_platform/presentation/viewmodels/auth_viewmodel.dart';
import 'package:ava_platform/utils/constants.dart';
import 'package:ava_platform/data/repositories/auth_repository.dart';
import 'package:ava_platform/data/datasources/remote/firebase_auth_datasource.dart';
import 'package:ava_platform/presentation/views/home/home_screen.dart';

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
  // ===========================================================================
  // VIEWMODEL Y CONTROLADORES
  // ===========================================================================
  late AuthViewModel _authViewModel;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  
  bool _showRegister = false;
  bool _obscurePassword = true;
  bool _showTabs = false;

  // ===========================================================================
  // CICLO DE VIDA
  // ===========================================================================
  @override
  void initState() {
    super.initState();
    _showRegister = widget.initialShowRegister;
    _showTabs = false;
    _initializeViewModel();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _authViewModel.dispose();
    super.dispose();
  }

  // ===========================================================================
  // INICIALIZACIÓN DEL VIEWMODEL
  // ===========================================================================
  void _initializeViewModel() {
    final authRepository = AuthRepository(FirebaseAuthDatasource());
    _authViewModel = AuthViewModel(authRepository: authRepository);
    
    _authViewModel.addListener(_onViewModelChanged);
  }

  void _onViewModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  // ===========================================================================
  // MÉTODOS DE LA VISTA
  // ===========================================================================
  void _login() async {
    final success = await _authViewModel.signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    
    if (success && mounted) {
      _navigateToHome();
    } else if (mounted) {
      _showError(_authViewModel.errorMessage ?? 'Error en el login');
    }
  }

  void _register() async {
    final success = await _authViewModel.register(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _nameController.text.trim(),
    );
    
    if (success && mounted) {
      _navigateToHome();
    } else if (mounted) {
      _showError(_authViewModel.errorMessage ?? 'Error en el registro');
    }
  }

  void _signInWithGoogle() async {
    final success = await _authViewModel.signInWithGoogle();
    
    if (success && mounted) {
      _navigateToHome();
    } else if (mounted) {
      _showError(_authViewModel.errorMessage ?? 'Error en el login con Google');
    }
  }

  void _navigateToHome() {
  // Navegar a la pantalla de mantenimiento
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ),
  );
}
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ===========================================================================
  // MÉTODOS DE NAVEGACIÓN ENTRE FORMULARIOS
  // ===========================================================================
  void _goToLogin() {
    setState(() {
      _showRegister = false;
      _showTabs = false;
      _clearRegisterFields();
    });
  }

  void _goToRegister() {
    setState(() {
      _showRegister = true;
      _showTabs = false;
      _clearLoginFields();
    });
  }

  // ===========================================================================
  // MÉTODOS DE LIMPIEZA DE FORMULARIOS
  // ===========================================================================
  void _clearRegisterFields() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  void _clearLoginFields() {
    _emailController.clear();
    _passwordController.clear();
  }

  // ===========================================================================
  // CONSTRUCCIÓN PRINCIPAL
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.darkBackground,
      body: Row(
        children: [
          // ===================================================================
          // FORMULARIO (IZQUIERDA)
          // ===================================================================
          _buildFormContainer(),
          
          // ===================================================================
          // IMAGEN (DERECHA)
          // ===================================================================
          _buildImageSection(),
        ],
      ),
    );
  }

  // ===========================================================================
  // WIDGETS DE CONSTRUCCIÓN
  // ===========================================================================
  Widget _buildFormContainer() {
    return Container(
      width: 400,
      margin: const EdgeInsets.only(left: 80, top: 60, bottom: 60),
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 254, 254, 254),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: _showRegister 
          ? _buildRegisterLayout() 
          : _buildLoginLayout(),
    );
  }

  Widget _buildImageSection() {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: SvgPicture.asset(
            'assets/images/edubotic.svg',
            width: 600,
            height: 600,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 60, color: Colors.grey),
                  const SizedBox(height: 10),
                  Text(
                    'Imagen no encontrada',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // LAYOUT DE REGISTRO
  // ===========================================================================
  Widget _buildRegisterLayout() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ===================================================================
          // BOTÓN ATRÁS
          // ===================================================================
          _buildBackButton(),
          const SizedBox(height: 30),

          // ===================================================================
          // TÍTULO
          // ===================================================================
          _buildRegisterTitle(),
          const SizedBox(height: 30),

          // ===================================================================
          // CAMPOS DE FORMULARIO
          // ===================================================================
          _buildNameField(),
          const SizedBox(height: 20),
          _buildEmailField(),
          const SizedBox(height: 20),
          _buildPasswordField(),
          const SizedBox(height: 30),

          // ===================================================================
          // BOTÓN REGISTRAR
          // ===================================================================
          _buildRegisterButton(),
          const SizedBox(height: 20),

          // ===================================================================
          // SEPARADOR
          // ===================================================================
          _buildSeparator(),
          const SizedBox(height: 20),

          // ===================================================================
          // BOTÓN GOOGLE
          // ===================================================================
          _buildGoogleButton(),
          const SizedBox(height: 20),

          // ===================================================================
          // TÉRMINOS Y CONDICIONES
          // ===================================================================
          _buildTermsText(),
          const SizedBox(height: 20),

          // ===================================================================
          // ENLACE A LOGIN
          // ===================================================================
          _buildLoginLink(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // ===========================================================================
  // COMPONENTES DE REGISTRO
  // ===========================================================================
  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
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
    );
  }

  Widget _buildRegisterTitle() {
    return const Text(
      'CREA UNA CUENTA PARA COMENZAR',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildNameField() {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: _nameController,
        decoration: const InputDecoration(
          hintText: 'NOMBRE COMPLETO',
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
    );
  }

  Widget _buildEmailField() {
    return SizedBox(
      width: double.infinity,
      child: TextField(
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
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _buildPasswordField() {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          hintText: 'CONTRASEÑA',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return _authViewModel.isLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'CREAR CUENTA',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
  }

  Widget _buildSeparator() {
    return const Row(
      children: [
        Expanded(child: Divider(color: Colors.grey)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'O',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey)),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return Center(
      child: SizedBox(
        width: 200,
        height: 50,
        child: OutlinedButton(
          onPressed: _authViewModel.isLoading ? null : _signInWithGoogle,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            side: const BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/google.svg',
                width: 36,
                height: 36,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 36, color: Colors.red);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsText() {
    return const Text(
      'AL CONTINUAR ACEPTAS NUESTROS TÉRMINOS\nDE USO Y POLÍTICA DE PRIVACIDAD',
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey,
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoginLink() {
    return GestureDetector(
      onTap: _authViewModel.isLoading ? null : _goToLogin,
      child: Text(
        '¿YA TIENES TU CUENTA? ACCEDER',
        style: TextStyle(
          fontSize: 14,
          color: _authViewModel.isLoading ? Colors.grey : Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ===========================================================================
  // LAYOUT DE LOGIN
  // ===========================================================================
  Widget _buildLoginLayout() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================================================================
          // BOTÓN ATRÁS
          // ===================================================================
          _buildBackButton(),
          const SizedBox(height: 30),

          // ===================================================================
          // PESTAÑAS (SOLO SI _showTabs ES TRUE)
          // ===================================================================
          if (_showTabs) ...[
            _buildLoginTabs(),
            const SizedBox(height: 30),
          ],

          // ===================================================================
          // CAMPOS DE FORMULARIO
          // ===================================================================
          _buildEmailField(),
          const SizedBox(height: 20),
          _buildPasswordField(),
          const SizedBox(height: 30),

          // ===================================================================
          // BOTÓN INICIAR SESIÓN
          // ===================================================================
          _buildLoginButton(),
          const SizedBox(height: 20),

          // ===================================================================
          // SEPARADOR (NUEVO - PARA LOGIN)
          // ===================================================================
          _buildSeparator(),
          const SizedBox(height: 20),

          // ===================================================================
          // BOTÓN GOOGLE (NUEVO - PARA LOGIN)
          // ===================================================================
          _buildGoogleButton(),
          const SizedBox(height: 20),

          // ===================================================================
          // ENLACE A REGISTRO (SOLO SI NO HAY PESTAÑAS)
          // ===================================================================
          if (!_showTabs) ...[
            _buildRegisterLink(),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  // ===========================================================================
  // COMPONENTES DE LOGIN
  // ===========================================================================
  Widget _buildLoginTabs() {
    return Row(
      children: [
        _buildLoginTab(
          text: 'ACCEDER',
          isActive: !_showRegister,
          onTap: _authViewModel.isLoading
              ? null
              : () {
                  setState(() {
                    _showRegister = false;
                    _clearLoginFields();
                  });
                },
        ),
        _buildLoginTab(
          text: 'REGISTRARSE',
          isActive: _showRegister,
          onTap: _authViewModel.isLoading
              ? null
              : _goToRegister,
        ),
      ],
    );
  }

  Widget _buildLoginTab({
    required String text,
    required bool isActive,
    required VoidCallback? onTap,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? Colors.blue : Colors.grey[300]!,
              width: 2,
            ),
          ),
        ),
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: isActive ? Colors.blue : Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return _authViewModel.isLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'INICIAR SESIÓN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
  }

  Widget _buildRegisterLink() {
    return GestureDetector(
      onTap: _authViewModel.isLoading ? null : _goToRegister,
      child: Text(
        '¿NO TIENES CUENTA? REGISTRARSE',
        style: TextStyle(
          fontSize: 14,
          color: _authViewModel.isLoading ? Colors.grey : Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}