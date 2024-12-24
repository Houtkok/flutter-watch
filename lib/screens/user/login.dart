import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watches_project/models/user.dart';
import 'package:watches_project/models/user_manager.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.userManager});
  final UserManager userManager;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    _emailInput.dispose();
    _passwordInput.dispose();
    super.dispose();
  }

  void _attemptLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    String email = _emailInput.text.trim();
    String password = _passwordInput.text;

    try {
      await Future.delayed(const Duration(seconds: 1)); 
      User? user = widget.userManager.authenticate(email, password);
      
      setState(() {
        _isLoading = false;
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          _errorMessage = 'Invalid email or password';
        }
      });
    } 
    catch (e) {
      setState(() {
          _isLoading = false;
          _errorMessage = 'An error occurred during login. Please try again.';
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50),
                  Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.blueGrey[700],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailInput,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordInput,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    obscureText: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _attemptLogin,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Log In',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                    },
                    child: const Text(
                      'Don’t have an account? Sign up',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
