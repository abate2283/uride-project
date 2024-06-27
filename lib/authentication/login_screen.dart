import 'package:flutter/material.dart';
import 'package:userapp/authentication/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [

              Image.asset(
                  "assets/images/riderlogo.png"
              ),

              const Text(
                "Login as a User",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Text and Button
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    const SizedBox(height: 12,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: "User Email",
                          labelStyle: TextStyle(
                              fontSize: 18
                          )
                      ),
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 18,
                      ),

                    ),
                    const SizedBox(height: 12,),
                    TextField(
                      controller: passwordTextEditingController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: "User Password",
                          labelStyle: TextStyle(
                              fontSize: 18
                          )
                      ),
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 18,
                      ),

                    ),
                    const SizedBox(height: 12,),

                    ElevatedButton(
                      onPressed:()
                      {

                      },
                      style:  ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(horizontal: 80)
                      ),
                      child: const Text(
                          "Login"
                      ),

                    )


                  ],
                ),
              ),
              // TextButton
              TextButton(
                onPressed:()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>SignupScreen()));
                },
                child: const Text(
                  "Don\'t have an Account? Register Here Please!",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
