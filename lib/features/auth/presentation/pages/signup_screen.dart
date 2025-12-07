import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/primary_button.dart';
import '../providers/auth_providers.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleSignup() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await ref
          .read(authRepositoryProvider)
          .signUp(email: email, password: password, username: name);

      if (mounted) {
        if (response.session == null) {
          // Email confirmation required
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Verify your email'),
              content: Text(
                'A verification email has been sent to $email. Please verify your email to log in.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop(); // Close dialog
                    context.push('/login'); // Go to login
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          // No email confirmation required, logged in automatically
          context.go('/home');
        }
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F2027), // Darkest Blue/Black
              Color(0xFF203A43),
              Color(0xFF2C5364), // Dark Blue-Grey
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.alt_route,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'FlowRoute AI',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ).animate().fadeIn().slideY(begin: -0.5, end: 0),

                  const SizedBox(height: 40),

                  // Create Account Text
                  Text(
                    'Create Account',
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 40),

                  // Inputs
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Full Name',
                    keyboardType: TextInputType.name,
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email address',
                    keyboardType: TextInputType.emailAddress,
                  ).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ).animate().fadeIn(delay: 500.ms),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ).animate().fadeIn(delay: 600.ms),

                  const SizedBox(height: 40),

                  // Signup Button
                  _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.blueAccent,
                        )
                      : PrimaryButton(
                          text: 'Sign Up',
                          onPressed: _handleSignup,
                        ).animate().fadeIn(delay: 700.ms),

                  const SizedBox(height: 24),

                  // Login Link
                  TextButton(
                    onPressed: () {
                      context.push('/login');
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: GoogleFonts.outfit(
                          color: Colors.white60,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: 'Log in',
                            style: GoogleFonts.outfit(
                              color: const Color(0xFF2962FF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 800.ms),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
