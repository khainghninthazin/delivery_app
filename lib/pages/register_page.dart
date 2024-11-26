import 'package:delivery_app/auth/auth_service.dart';
import 'package:delivery_app/component/my_textfield.dart';
import 'package:delivery_app/pages/home_page.dart';

import 'package:delivery_app/pages/login_page.dart';
import 'package:delivery_app/pages/mybutton.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authservice=AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =TextEditingController();

  void signup()async {
    final email=emailController.text;
    final password=passwordController.text;
    final confirmPassword=confirmPasswordController.text;

    if(password!=confirmPassword){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('password donnot match')));
      return;
    }
    try{
      await authservice.signInwithEmailPassword(email,password);
      Navigator.pop(context);
    }
    catch(e){
      if(mounted){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error:$e')));
      }
    }
  }
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_open_rounded,
              size: 70,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Lets create an account for you",
              style: TextStyle(
                fontSize: 19,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MyTextfield(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextfield(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextfield(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              obscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              text: "Sign up",
            onTap: (){
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>   HomePage(),
                        ),
                      );
            }
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Alrady have an account?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  LoginPage(onTap: () {  },),
                      ),
                    );
                  },
                  child: Text(
                    "Login now",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
