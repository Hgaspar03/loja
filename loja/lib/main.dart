import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loja/models/admin_users_manager.dart';
import 'package:loja/models/cart_manager.dart';
import 'package:loja/models/home_manager.dart';
import 'package:loja/models/product_manager.dart';
import 'package:loja/models/products.dart';
import 'package:loja/screens/adress/adress_screen.dart';
import 'package:loja/screens/base/base_screen.dart';
import 'package:loja/screens/cart_screen.dart';
import 'package:loja/screens/checkout_screen.dart';
import 'package:loja/screens/edit_product/edit_product_screen.dart';
import 'package:loja/screens/login/lgin_screen.dart';
import 'package:loja/screens/select_product/select_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:loja/models/user_manager.dart';
import 'package:loja/screens/signup/signup_screen.dart';
import 'package:loja/screens/product/product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          update: (_, userMnanager, cartManager) {
            return cartManager..updateUser(userMnanager);
          },
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, usermanager, adminUsersmanager) {
            return adminUsersmanager..updateUser(usermanager);
          },
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
              return MaterialPageRoute(
                  builder: (_) => CartScreen(), settings: settings);
              break;
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(settings.arguments as Product));
              break;
            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) =>
                      EditProductScreen(settings.arguments as Product));
              break;
            case '/select_product':
              return MaterialPageRoute(builder: (_) => SelectProductScreen());
              break;
            case '/address':
              return MaterialPageRoute(builder: (_) => AdressScreen());
              break;
            case '/checkout':
              return MaterialPageRoute(builder: (_) => CheckoutScreen());
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
