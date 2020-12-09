import 'package:flutter/material.dart';
import 'package:loja/common/helpers/validators.dart';
import 'package:provider/provider.dart';
import 'package:loja/models/user_manager.dart';
import 'package:loja/models/user.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/signup');
              },
              child: const Text(
                "CRIAR CONTA",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ))
        ],
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return ListView(
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                children: [
                  TextFormField(
                    enabled: !userManager.loading,
                    controller: emailController,
                    decoration: InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email) {
                      if (!emailValid(email)) return 'E-mail invalido';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: !userManager.loading,
                    controller: passwordControler,
                    decoration: InputDecoration(hintText: 'Password'),
                    obscureText: true,
                    autocorrect: false,
                    validator: (password) {
                      if (password.isEmpty || password.length < 6) {
                        return "Password Invalido";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {},
                      child: Text("Esqueci o password!"),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  RaisedButton(
                    onPressed: userManager.loading
                        ? null
                        : () {
                            if (formkey.currentState.validate()) {
                              userManager.signIn(
                                  user: User(
                                      email: emailController.text,
                                      password: passwordControler.text),
                                  onFail: (e) {
                                    scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text("Erro: $e"),
                                      backgroundColor: Colors.red,
                                    ));
                                  },
                                  onSucess: () {
                                    Navigator.of(context).pop();
                                  });
                            }
                          },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    child: userManager.loading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).primaryColor),
                          )
                        : Text("Entrar"),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
