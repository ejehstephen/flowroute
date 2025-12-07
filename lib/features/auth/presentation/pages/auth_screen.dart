import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

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
                const Spacer(flex: 2),
                // Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.alt_route,
                      color: Colors.blueAccent,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'FlowRoute AI',
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ).animate().fadeIn().slideY(begin: -0.5, end: 0),

                const Spacer(flex: 1),

                // Pagination dots placeholder (visual only as per design)
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       width: 6,
                //       height: 6,
                //       decoration: const BoxDecoration(
                //         color: Colors.blue,
                //         shape: BoxShape.circle,
                //       ),
                //     ),
                //     const SizedBox(width: 8),
                //     Container(
                //       width: 6,
                //       height: 6,
                //       decoration: BoxDecoration(
                //         color: Colors.white.withOpacity(0.2),
                //         shape: BoxShape.circle,
                //       ),
                //     ),
                //     const SizedBox(width: 8),
                //     Container(
                //       width: 6,
                //       height: 6,
                //       decoration: BoxDecoration(
                //         color: Colors.white.withOpacity(0.2),
                //         shape: BoxShape.circle,
                //       ),
                //     ),
                //   ],
                // ).animate().fadeIn(delay: 200.ms),
                const Spacer(flex: 3),

                // Main Text
                Text(
                  'Navigate Smarter',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 16),
                Text(
                  'Get started with your AI-powered traffic assistant.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ).animate().fadeIn(delay: 500.ms),

                const Spacer(flex: 2),

                // Buttons
                _SocialButton(
                  text: 'Sign up with Google',
                  icon: Icons.g_mobiledata, // Placeholder for Google Icon
                  backgroundColor: const Color(0xFF2D2D3A),
                  textColor: Colors.white,
                  onPressed: () {},
                ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 16),
                _SocialButton(
                  text: 'Sign up with Apple',
                  icon: Icons.apple,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {},
                ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/signup');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2962FF), // Bright Blue
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Sign up with Email',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0),

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
                ).animate().fadeIn(delay: 900.ms),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
