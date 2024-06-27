import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:userapp/methods/common_methods.dart';
import 'package:userapp/pages/home_page.dart';
import 'package:userapp/widgets/loading_dialog.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userPhoneTextEditingController = TextEditingController();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  CommonMethods cMethods = CommonMethods();
  checkIfNetworkIsAvailable(){
    cMethods.checkConnectivity(context);
    signUpFormValidation();
}
  signUpFormValidation()
  {
    if(userNameTextEditingController.text.trim().length < 3){
        cMethods.displaySnackBar("Your userName must be greater than 4 letters. ", context);
    }
    else if(userPhoneTextEditingController.text.trim().length < 7){
      cMethods.displaySnackBar("Your Phone number must be greater than 7 characters! ", context);
    }
    else if(!emailTextEditingController.text.contains("@")){
      cMethods.displaySnackBar("Your email must have @ to be correct.", context);
    }
    else
      {
        // register user
        registerNewUser();
      }
  }

  registerNewUser() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)=>LoadingDialog(messageText: "Registering your account..."),
    );
    final User? userFirebase = (
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim(),
        ).catchError((errorMessage)
            {
              cMethods.displaySnackBar(errorMessage.toString(), context);
            })
    ).user;

    if(!context.mounted) return;
    Navigator.pop(context);

    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
    Map userDataMap =
        {
          "name": userNameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": userPhoneTextEditingController.text.trim(),
          "id": userFirebase.uid,
          "blockStatus": "no",
        };
        usersRef.set(userDataMap);

        Navigator.push(context, MaterialPageRoute(builder: (c)=> HomePage()));
  }


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
                "Create a User\'s Account",
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
                    TextField(
                      controller: userNameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "User Name",
                        labelStyle: TextStyle(
                          fontSize: 18
                        )
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),

                    ),
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
                    TextField(
                      controller: userPhoneTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "Users Phone Number",
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
                          checkIfNetworkIsAvailable();
                        },
                        style:  ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(horizontal: 80)
                        ),
                        child: const Text(
                          "Sign up"
                        ),

                        )


                  ],
                ),
              ),
              // TextButton
              TextButton(
                onPressed:()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));
                },
                child: const Text(
                  "Already have an Account? Login Here Please!",
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
