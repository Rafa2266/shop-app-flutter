import 'dart:math';

import 'package:flutter/material.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.login;
  Map<String, String> _authData = {'email': '', 'password': ''};

  bool _isLogin() => _authMode == AuthMode.login;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.signup;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  void _submit() {
    final isValid = _formkey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    _formkey.currentState?.save();

    if (_isLogin()) {
      //login
    } else {
      //registrar
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: _isLogin() ? 310 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formkey,
          child: Column(children: [
            TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  if (email.trim().isEmpty || !email.contains('@')) {
                    return "Informe um e-mail válido";
                  }
                  return null;
                }),
            TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: _passwordController,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.isEmpty || password.length < 5) {
                    return "Informe uma senha válida";
                  }
                  return null;
                }),
            if (!_isLogin())
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: _isLogin()
                    ? null
                    : (_password) {
                        final password = _password ?? '';
                        if (password != _passwordController.text) {
                          return "Senhas informadas não conferem";
                        }
                        return null;
                      },
              ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 8)),
                    child: Text(_isLogin() ? 'ENTRAR' : 'REGISTRAR'),
                  ),
            const Spacer(),
            TextButton(
                onPressed: _switchAuthMode,
                child:
                    Text(_isLogin() ? 'DESEJA REGISTRAR?' : 'JÁ POSSUI CONTA'))
          ]),
        ),
      ),
    );
  }
}
