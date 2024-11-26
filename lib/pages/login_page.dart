import 'package:delivery_app/auth/auth_service.dart';
import 'package:delivery_app/component/my_textfield.dart';
import 'package:delivery_app/pages/home_page.dart';
import 'package:delivery_app/pages/mybutton.dart';
import 'package:delivery_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   final authService=AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isEmailValid = true;
  bool isPasswordValid = true;
  late final String? errorText;

  bool validateEmail(String email) {
    const emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'; // Regex for email validation
    final regExp = RegExp(emailPattern);

    if (email.isEmpty || !regExp.hasMatch(email)) {
      setState(() => isEmailValid = false);
      showErrorSnackbar("Invalid Email", "Please enter a valid email address.");
      return false;
    }
    setState(() => isEmailValid = true);
    return true;
  }

  bool validatePassword(String password) {
    if (password.isEmpty) {
      setState(() => isPasswordValid = false);
      showErrorSnackbar("Invalid Password", "Password cannot be empty.");
      return false;
    }
    setState(() => isPasswordValid = true);
    return true;
  }

  void showErrorSnackbar(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$title: $message"),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void login()async {
    //get auth service
    
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try{
      await authService.signInwithEmailPassword(email, password);
    }
    catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error:$e')));
      }
    }

    if (!validateEmail(email) || !validatePassword(password)) return;

    // Navigator to; HomePage; if validation passes
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const HomePage(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_open_rounded,
                size: 70,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 20),
              Text(
                "Food Delivery App",
                style: TextStyle(
                  fontSize: 19,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 15),
              MyTextfield(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
                errorText: isEmailValid ? null : "Invalid email address",
              ),
              const SizedBox(height: 10),
              MyTextfield(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
                errorText: isPasswordValid ? null : "Password cannot be empty",
              ),
              const SizedBox(height: 25),
              MyButton(
                text: "Sign In",
                
                onTap:(){
                   Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>   HomePage(),
                        ),
                      );
                }
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>   RegisterPage(onTap: () {  },),
                        ),
                      );
                    },
                    child: Text(
                      "Register now",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
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
