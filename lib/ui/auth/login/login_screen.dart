import 'package:flutter/material.dart';
import 'package:todo_app/core/routes_manager/routes_manager.dart';
import 'package:todo_app/ui/auth/register/register_screen.dart';
import 'package:todo_app/ui/widgets/custom_text_field.dart';

import '../../../core/utils/email_validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSecure = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,elevation: 0,
      ),
      backgroundColor: Color(0xff5D9CEC),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              Image.asset('assets/images/login.png',width: size.width * .6,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                Text('Email :',textAlign: TextAlign.start,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
                CustomTextFormField(
                  hint: 'email',
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (input) {
                    if (input == null || input
                        .trim()
                        .isEmpty) {
                      return 'Plz, enter e-mail address';
                    }
                    if (!isValidEmail(input)) {
                      return 'email bad format';
                    }
                  },

                ),
                  Text('Password :',textAlign: TextAlign.start,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
                  CustomTextFormField(
                  controller: passwordController,
                  hint: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  isSecureText: isSecure,
                  suffixIcon: IconButton(
                    onPressed: () {
                      isSecure = !isSecure;
                      setState(() {});
                    },
                    icon:
                    Icon(isSecure ? Icons.visibility_off : Icons.visibility),
                  ),
                  validator: (input) {
                    if (input == null || input
                        .trim()
                        .isEmpty) {
                      return 'Plz, enter password';
                    }
                    if (input.length < 6) {
                      return 'password must be at least 6 chars';
                    }
                  },
                ),
                SizedBox(height: 12,),
                ElevatedButton(
                    onPressed: () {
                  login();
                },
                    style: ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                      backgroundColor: MaterialStateProperty.all(Color(0xff141938)),
                    ),
                    child: Container(
                    width: double.infinity,
                    child: Text('Login',textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),))),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('Need an acount ?'),
                    SizedBox(width: 5,),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        fixedSize: Size.fromWidth(0)
                      ),
                      onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.registerRoute);
                    }, child: Text('Sign Up',style: TextStyle(color: Colors.white),),),
                  ],)
              ],)
            ],
          ),
        ),
      ),
    );
  }

void login() {
  bool isValidForm = formKey.currentState!.validate();
  if (!isValidForm) {
    return;
  }
}
}
