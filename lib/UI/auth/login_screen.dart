import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingopandasameepjain/UI/auth/signup_screen.dart';
import 'package:provider/provider.dart';
import '../../Provider/auth_provider.dart';
import '../news/news_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Create a key for the form
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyNews',
          style: GoogleFonts.poppins(
            color: Color(0xFF0C54BE), // Updated font color to OC54BE
            fontSize: 24,
            fontWeight: FontWeight.bold, // Use Bold from Poppins
          ),
        ),
        backgroundColor: Color(0xFFF5F9FD), // Background color F5F9FD
      ),
      backgroundColor: Color(0xFFF5F9FD), // Light background color from style guide
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Assign the form key to the Form widget
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: GoogleFonts.poppins(
                          color: Color(0xFF303F60),
                          fontWeight: FontWeight.w500, // Medium weight
                        ),
                        filled: true,
                        fillColor: Colors.white, // Keep input background white
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email'; // Validation error message
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email'; // Email format validation
                        }
                        return null; // Field is valid
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: GoogleFonts.poppins(
                          color: Color(0xFF303F60),
                          fontWeight: FontWeight.w500,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password'; // Validation error message
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long'; // Password length validation
                        }
                        return null; // Field is valid
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Only attempt login if the form is valid
                      await authProvider.login(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                      if (authProvider.errorMessage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Login successful!")),
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => NewsScreen()),
                              (Route<dynamic> route) => false, // Remove all previous routes
                        );
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(authProvider.errorMessage!)),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0C54BE), // Primary color from style guide
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Use Bold from Poppins
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New here?',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF303F60),
                      fontWeight: FontWeight.w500, // Medium weight for less emphasis
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      'Signup',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF0C54BE), // Primary color for links
                        fontWeight: FontWeight.bold, // Bold for emphasis
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
