import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/primary_button.dart';
import '../providers/auth_providers.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleResetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your email')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(authRepositoryProvider).resetPassword(email);

      if (mounted) {
        // Show success dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Check Your Email'),
            content: Text('We\'ve sent password reset instructions to $email'),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop(); // Close dialog
                  context.pop(); // Go back to login
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
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

                // Title
                Text(
                  'Forgot Password?',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: 16),

                // Description
                Text(
                  "Enter your email and we'll send you instructions to reset your password.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ).animate().fadeIn(delay: 300.ms),

                const SizedBox(height: 40),

                // Input
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email address',
                  keyboardType: TextInputType.emailAddress,
                ).animate().fadeIn(delay: 400.ms),

                const SizedBox(height: 24),

                // Send Reset Link Button
                _isLoading
                    ? const CircularProgressIndicator(color: Colors.blueAccent)
                    : PrimaryButton(
                        text: 'Send Reset Link',
                        onPressed: _handleResetPassword,
                      ).animate().fadeIn(delay: 500.ms),

                const Spacer(),

                // Return to Login
                TextButton(
                  onPressed: () {
                    context.pop(); // Go back to Login
                  },
                  child: Text(
                    'Return to Login',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ).animate().fadeIn(delay: 600.ms),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
