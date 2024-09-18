import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/routes_manager/routes_manager.dart';
import 'package:todo_app/providers/app_auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 3),() {
      navigate();

    },);
    return Image.asset('assets/images/splash.png',fit: BoxFit.fill,width: double.infinity,height: double.infinity,);
  }


void navigate() {
  var authProvider = Provider.of<AppAuthProvider>(context,listen: false);
  if(authProvider.isLoggedInBefore()){
    authProvider.retrieveUserFromDatabase();
    Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
  }
  else{
    Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
  }
}}
