import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/primary_button.dart';
import '../../../../core/presentation/widgets/social_login_button.dart';
import '../providers/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: password);

      if (mounted) {
        context.go('/home');
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
    _emailController.dispose();
    _passwordController.dispose();
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
                  const SizedBox(height: 40),
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

                  const SizedBox(height: 60),

                  // Welcome Text
                  Text(
                    'Welcome Back',
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 40),

                  // Inputs
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email address',
                    keyboardType: TextInputType.emailAddress,
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ).animate().fadeIn(delay: 400.ms),

                  const SizedBox(height: 12),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.push('/forgot-password');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.outfit(
                          color: Colors.blueAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 500.ms),

                  const SizedBox(height: 24),

                  // Login Button
                  _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.blueAccent,
                        )
                      : PrimaryButton(
                          text: 'Login',
                          onPressed: _handleLogin,
                        ).animate().fadeIn(delay: 600.ms),

                  const SizedBox(height: 40),

                  // OR Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.1),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: GoogleFonts.outfit(
                            color: Colors.white38,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white.withOpacity(0.1),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 700.ms),

                  const SizedBox(height: 40),

                  // Social Buttons
                  Row(
                    children: [
                      Expanded(
                        child: SocialLoginButton(
                          text: 'Google',
                          icon: Icons.g_mobiledata,
                          backgroundColor: const Color(0xFF1E2029),
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SocialLoginButton(
                          text: 'Apple',
                          icon: Icons.apple,
                          backgroundColor: const Color(0xFF1E2029),
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 800.ms),

                  const SizedBox(height: 24),

                  // Continue as Guest
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        context.go('/home');
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white.withOpacity(0.1)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        'Continue as Guest',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 900.ms),

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
