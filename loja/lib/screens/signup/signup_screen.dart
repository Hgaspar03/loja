import 'package:flutter/material.dart';
import 'package:loja/common/helpers/validators.dart';
import 'package:loja/models/user.dart';
import 'package:loja/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formstate,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Nome Completo'),
                  onSaved: (newValue) => user.nome = newValue,
                  validator: (nome) {
                    if (nome.isEmpty)
                      return 'Campo Obrigatorio';
                    else if (nome.trim().split(' ').length <= 1)
                      return 'Preencha seu nome completo';

                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => user.email = email,
                  validator: (email) {
                    if (!emailValid(email)) return 'E-mail invalido';
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                  obscureText: true,
                  validator: (password) {
                    if (password.isEmpty) return "Password Invalido";
                    if (password.length < 6)
                      return 'Password deve conter pelo nmenos 6 digitos';
                    return null;
                  },
                  onSaved: (pass) => user.password = pass,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Confirmar o password'),
                  obscureText: true,
                  validator: (password) {
                    if (password.isEmpty) return "Password Invalido";
                    if (password.length < 6)
                      return 'Password deve conter pelo nmenos 6 digitos';
                    return null;
                  },
                  onSaved: (pass) => user.conformPassword = pass,
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      if (formstate.currentState.validate()) {
                        formstate.currentState.save();

                        if (user.password != user.conformPassword) {
                          scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text('Password nao coincidem'),
                            backgroundColor: Colors.red,
                          ));
                          return;
                        }
                        context.read<UserManager>().signUp(
                            user: user,
                            onFail: (e) {
                              scaffoldKey.currentState.showSnackBar(SnackBar(
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
                    child: Text(
                      'Criar Conta',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
