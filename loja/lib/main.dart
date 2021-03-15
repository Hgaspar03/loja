import 'package:flutter/material.dart';
import 'package:loja/models/cart_manager.dart';
import 'package:loja/models/home_manager.dart';
import 'package:loja/models/product_manager.dart';
import 'package:loja/models/products.dart';
import 'package:loja/screens/base/base_screen.dart';
import 'package:loja/screens/cart_screen.dart';
import 'package:loja/screens/login/lgin_screen.dart';
import 'package:provider/provider.dart';
import 'package:loja/models/user_manager.dart';
import 'package:loja/screens/signup/signup_screen.dart';
import 'package:loja/screens/product/product_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => UserManager(),
        ),
        ChangeNotifierProvider(create: (_) => ProductManager(), lazy: false),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          update: (_, userMnanager, cartManager) {
            return cartManager..updateUser(userMnanager);
          },
          lazy: false,
        )
      ],
      child: MaterialApp(
        title: 'Loja do Helenio Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 4, 125, 161),
            scaffoldBackgroundColor: Color.fromARGB(255, 4, 125, 161),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(elevation: 0)),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
              break;
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
              break;
            case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen());
              break;
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(settings.arguments as Product));
              break;
            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
