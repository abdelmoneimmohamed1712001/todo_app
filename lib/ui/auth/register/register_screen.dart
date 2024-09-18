import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/providers/app_auth_provider.dart';
import 'package:todo_app/ui/widgets/custom_text_field.dart';

import '../../../core/routes_manager/routes_manager.dart';
import '../../../core/utils/email_validation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isSecure1 = true;
  bool isSecure2 = true;
  var fullNameController = TextEditingController();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xff5D9CEC),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/Sign_up.png',
                  width: size.width * .6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Full Name :',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    CustomTextFormField(
                      hint: 'Full Name',
                      keyboardType: TextInputType.name,
                      controller: fullNameController,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Plz, enter full name';
                        }
                        return null;
                      },
                    ),
                    Text(
                      'User Name :',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    CustomTextFormField(
                      hint: 'User Name',
                      keyboardType: TextInputType.emailAddress,
                      controller: userNameController,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Plz, enter user name';
                        }
                        if (!(input is String)) {
                          return 'Plz, enter a valid user name';
                        }
                        return null;
                      },
                    ),
                    Text(
                      'Email :',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    CustomTextFormField(
                      hint: 'E-mail Address',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Plz, enter e-mail address';
                        }
                        if (!isValidEmail(input)) {
                          return 'email bad format';
                        }
                      },
                    ),
                    Text(
                      'Password :',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    CustomTextFormField(
                      controller: passwordController,
                      hint: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      isSecureText: isSecure1,
                      suffixIcon: IconButton(
                        onPressed: () {
                          isSecure1 = !isSecure1;
                          setState(() {});
                        },
                        icon: Icon(isSecure1
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Plz, enter password';
                        }
                        if (input.length < 6) {
                          return 'password must be at least 6 chars';
                        }
                      },
                    ),
                    Text(
                      'Confirm Password :',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    CustomTextFormField(
                      controller: rePasswordController,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return 'Plz, enter password confirmation';
                        }
                        if (input != passwordController.text) {
                          return 'password doesn\'t match';
                        }
                      },
                      hint: 're-password',
                      keyboardType: TextInputType.visiblePassword,
                      isSecureText: isSecure2,
                      suffixIcon: IconButton(
                        onPressed: () {
                          isSecure2 = !isSecure2;
                          setState(() {});
                        },
                        icon: Icon(isSecure2
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          createAccount(
                              emailController.text,
                              passwordController.text,
                              userNameController.text,
                              fullNameController.text);
                        },
                        style: ButtonStyle(
                          elevation: MaterialStatePropertyAll(0),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff141938)),
                        ),
                        child: Container(
                            width: double.infinity,
                            child: Text(
                              'Register',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22),
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an acount ?',
                            style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.loginRoute);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAccount(
      String email, String password, String fullName, String userName) async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    if (formKey.currentState?.validate() == false) {
      return;
    }
    try {
      DialogUtils.showLoadingDialog(context, 'Creating Acount...');
      await authProvider.register(
          email: email,
          password: password,
          fullName: fullName,
          userName: userName);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(
        context,
        message: 'Acount Registered Successgully',
        posActionTitle: 'Login',
        posAction: () {
          Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == 'weak-password') {
        DialogUtils.showMessageDialog(context,
            message: 'The password provided is too weak.',
            negActionTitle: 'Try Again');
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showMessageDialog(context,
            message: 'The account already exists for that email.',
            negActionTitle: 'Try Again');
      }
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          message: e.toString(), posActionTitle: 'ok');
    }
  }
}
