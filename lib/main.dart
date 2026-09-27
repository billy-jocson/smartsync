import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SmartSyncApp());
}

class SmartSyncApp extends StatelessWidget {
  const SmartSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartSync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF070B19),
        primarySwatch: Colors.blue,
        fontFamily: 'Lato',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

// ==========================================
// LOGIN SCREEN
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final String username = _usernameController.text.trim();

      Navigator.pushReplacementNamed(context, '/home', arguments: username);
    }
  }

  void _goToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 32,
                    ),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 38,
                                  color: Colors.white,
                                  fontFamily: 'Lora',
                                ),
                              ),
                              Text(
                                'Login using SmartSync account.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Lora',
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 24),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 16,
                                    sigmaY: 16,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.35),
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.12),
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 15,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildFieldLabel('Username'),
                                        const SizedBox(height: 8),
                                        _buildTextField(
                                          controller: _usernameController,
                                          hintText: 'Enter your username',
                                          icon: Icons.person_outline,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Username is required';
                                            }
                                            if (value.trim().length < 3) {
                                              return 'Username must be at least 3 characters';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        _buildFieldLabel('Password'),
                                        const SizedBox(height: 8),
                                        _buildTextField(
                                          controller: _passwordController,
                                          hintText: 'Enter your password',
                                          icon: Icons.lock_outline,
                                          obscureText: _obscurePassword,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons
                                                        .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: Colors.white54,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword =
                                                    !_obscurePassword;
                                              });
                                            },
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Password is required';
                                            }
                                            if (value.length < 6) {
                                              return 'Password must be at least 6 characters';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 28),

                              PrimaryGradientButton(
                                text: 'Login',
                                onPressed: _handleLogin,
                              ),

                              const SizedBox(height: 20),

                              Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.35),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: 'Lato',
                                        shadows: [
                                          Shadow(
                                            color: Colors.black54,
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: "Don't have an account? ",
                                        ),
                                        TextSpan(
                                          text: 'Sign Up',
                                          style: const TextStyle(
                                            color: Color(0xFF9FC4FF),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = _goToLogin,
                                        ),
                                        const TextSpan(text: ' here.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// SIGN-UP SCREEN
// ==========================================
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      final String name = _fullNameController.text.trim().isNotEmpty
          ? _fullNameController.text.trim()
          : 'User';

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
        arguments: name,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 32,
                    ),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 38,
                                  color: Colors.white,
                                  fontFamily: 'Lora',
                                ),
                              ),
                              Text(
                                'Enter your details accurately.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Lora',
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 20),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 16,
                                    sigmaY: 16,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.35),
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.12),
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 15,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildFieldLabel('Full Name'),
                                        const SizedBox(height: 8),
                                        _buildTextField(
                                          controller: _fullNameController,
                                          hintText: 'Enter your full name (e.g. John D. Doe)',
                                          icon: Icons.person_outline,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Please enter your full name';
                                            }
                                            if (value.trim().length < 2) {
                                              return 'Name is too short';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        _buildFieldLabel('Email'),
                                        const SizedBox(height: 8),
                                        _buildTextField(
                                          controller: _emailController,
                                          hintText: 'Enter your email',
                                          icon: Icons.mail_outline,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Please enter your email';
                                            }
                                            final emailRegex = RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                            );
                                            if (!emailRegex.hasMatch(
                                              value.trim(),
                                            )) {
                                              return 'Please enter a valid email address';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        _buildFieldLabel('Password'),
                                        const SizedBox(height: 8),
                                        _buildTextField(
                                          controller: _passwordController,
                                          hintText: 'Enter your password',
                                          icon: Icons.lock_outline,
                                          obscureText: _obscurePassword,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscurePassword
                                                  ? Icons
                                                        .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: Colors.white54,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword =
                                                    !_obscurePassword;
                                              });
                                            },
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a password';
                                            }
                                            if (value.length < 6) {
                                              return 'Password must be at least 6 characters';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        _buildFieldLabel('Confirm Password'),
                                        const SizedBox(height: 8),
                                        _buildTextField(
                                          controller:
                                              _confirmPasswordController,
                                          hintText: 'Re-enter your password',
                                          icon: Icons.lock_outline,
                                          obscureText: _obscureConfirmPassword,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscureConfirmPassword
                                                  ? Icons
                                                        .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: Colors.white54,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureConfirmPassword =
                                                    !_obscureConfirmPassword;
                                              });
                                            },
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please confirm your password';
                                            }
                                            if (value !=
                                                _passwordController.text) {
                                              return 'Passwords do not match';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 28),

                              PrimaryGradientButton(
                                text: 'Sign Up',
                                onPressed: _handleSignUp,
                              ),

                              const SizedBox(height: 20),

                              Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.35),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: 'Lato',
                                        shadows: [
                                          Shadow(
                                            color: Colors.black54,
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Have an account? ',
                                        ),
                                        TextSpan(
                                          text: 'Login',
                                          style: const TextStyle(
                                            color: Color(0xFF9FC4FF),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushNamed(
                                                context,
                                                '/login',
                                              );
                                            },
                                        ),
                                        const TextSpan(text: ' here.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// HOME SCREEN (ADAPTIVE BENTO / EQUAL GRID)
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openImageViewer(BuildContext context, String imageUrl) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.92),
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 40.0,
                    ),
                    child: InteractiveViewer(
                      panEnabled: true,
                      minScale: 0.5,
                      maxScale: 4.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.broken_image,
                                color: Colors.white,
                                size: 48,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: SafeArea(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white24, width: 1),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          );
          final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );

          return FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(scale: scaleAnimation, child: child),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String userName =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'User';

    const List<String> imageUrls = [
      'https://picsum.photos/300/450?random=1',
      'https://picsum.photos/300/250?random=2',
      'https://picsum.photos/300/250?random=3',
      'https://picsum.photos/300/450?random=4',
    ];

    return Scaffold(
      appBar: const AppHeader(isHome: true),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BackgroundWidget(blurred: true),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isMobile = constraints.maxWidth <= 650;

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: isMobile ? 500 : 850,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            const Text(
                              'Welcome back,',
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontFamily: 'Lora',
                              ),
                            ),
                            Text(
                              userName,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Lora',
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 28),
                            Text(
                              "Here's your synced photos:",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontFamily: 'Lato',
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 14),

                            if (isMobile)
                              SizedBox(
                                height: 480,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: _buildPhotoCard(
                                              context,
                                              imageUrls[0],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Expanded(
                                            flex: 4,
                                            child: _buildPhotoCard(
                                              context,
                                              imageUrls[1],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: _buildPhotoCard(
                                              context,
                                              imageUrls[2],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Expanded(
                                            flex: 6,
                                            child: _buildPhotoCard(
                                              context,
                                              imageUrls[3],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              SizedBox(
                                height: 260,
                                child: Row(
                                  children: [
                                    for (
                                      int i = 0;
                                      i < imageUrls.length;
                                      i++
                                    ) ...[
                                      if (i > 0) const SizedBox(width: 12),
                                      Expanded(
                                        child: _buildPhotoCard(
                                          context,
                                          imageUrls[i],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoCard(BuildContext context, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _openImageViewer(context, url),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.white10,
                child: const Icon(Icons.image, color: Colors.white30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// REUSABLE UI WIDGETS
// ==========================================
class BackgroundWidget extends StatefulWidget {
  final bool blurred;

  const BackgroundWidget({super.key, this.blurred = false});

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _blurAnimation;

  static const double _maxBlur = 18.0;
  static const double _maxOverlayOpacity = 0.50;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),

      value: widget.blurred ? 0.0 : 0.0,
    );
    _blurAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    if (widget.blurred) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void didUpdateWidget(covariant BackgroundWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.blurred && !oldWidget.blurred) {
      _controller.forward();
    } else if (!widget.blurred && oldWidget.blurred) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _blurAnimation,
      builder: (context, child) {
        final double t = _blurAnimation.value;
        final double sigma = t * _maxBlur;
        final double overlayOpacity = t * _maxOverlayOpacity;

        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/background.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: const Color(0xFF070B19)),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                child: Container(
                  color: Colors.black.withOpacity(overlayOpacity),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;

  const AppHeader({super.key, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 22,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.sync, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 8),
            const Text(
              'SmartSync',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                fontFamily: 'Lora',
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: isHome
            ? [
                Center(
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                      },
                      icon: const Icon(
                        Icons.logout,
                        size: 14,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Lato',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

Widget _buildFieldLabel(String label) {
  return Text(
    label,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      fontFamily: 'Lato',
    ),
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  bool obscureText = false,
  Widget? suffixIcon,
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    style: const TextStyle(color: Colors.white, fontSize: 14),
    validator: validator,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.black.withOpacity(0.35),
      prefixIcon: Icon(icon, color: Colors.white60, size: 18),
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF5AA9F2), width: 1.2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 1.5),
      ),
      errorStyle: const TextStyle(
        color: Color(0xFFFF6B6B),
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

class PrimaryGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF8AB6FF), Color(0xFF2F5FE0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3360E5).withOpacity(0.45),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }
}
