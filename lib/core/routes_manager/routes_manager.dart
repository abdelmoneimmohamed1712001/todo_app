import 'package:flutter/material.dart';
import 'package:todo_app/ui/auth/login/login_screen.dart';
import 'package:todo_app/ui/home/home_screen.dart';

import '../../ui/auth/register/register_screen.dart';

class AppRoutes{
static const String homeRoute = '/home';
static const String loginRoute = '/';
static const String registerRoute = '/register';
static Route<dynamic>?onGenerateRoute (RouteSettings settings){
switch (settings.name){
  case homeRoute :{
    return MaterialPageRoute(builder: (context) => HomeScreen(),);
  }
  case loginRoute :{
    return MaterialPageRoute(builder: (context) => LoginScreen(),);
  }
  case registerRoute :{
    return MaterialPageRoute(builder: (context) => RegisterScreen(),);
  }
}
}
}