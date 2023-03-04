import 'package:bmwapp/bloc/login_bloc.dart';
import 'package:bmwapp/bloc/provider.dart';
import 'package:bmwapp/models/users_model.dart';
import 'package:flutter/material.dart';

import '../providers/users_provider.dart';
import '../utils/alert_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordHidden = true;
  void _toggleVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: _mainImage(context),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.center,
                    child: _mainTitle(context),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Correo electrónico',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.black),
                  ),
                  _emailField(bloc),
                  const SizedBox(height: 30.0),
                  Text(
                    'Código',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.black),
                  ),
                  _passwordField(bloc),
                  const SizedBox(height: 30.0),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: _createButton(bloc),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    alignment: Alignment.center,
                    child: _brandLogo(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainImage(context) {
    return SizedBox(
      height: 150,
      child: Image.asset("assets/img/logo-bmw-dark.png"),
    );
  }

  Widget _mainTitle(context) {
    return Text(
      '¡Bienvenido! ingresa a nuestro evento',
      textAlign: TextAlign.center,
      style:
          Theme.of(context).textTheme.headline1?.copyWith(color: Colors.black),
    );
  }

  Widget _emailField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Escribe tu correo electrónico',
            errorText:
                snapshot.error != null ? snapshot.error!.toString() : null,
            errorStyle: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.red),
          ),
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget _passwordField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          obscureText: _isPasswordHidden,
          decoration: InputDecoration(
              hintText: "Ingresa el código que recibiste",
              errorText:
                  snapshot.error != null ? snapshot.error!.toString() : null,
              errorStyle: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.red),
              suffixIcon: IconButton(
                icon: Icon(_isPasswordHidden
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: _toggleVisibility,
              )),
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final size = MediaQuery.of(context).size;

        return ElevatedButton(
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
          child: SizedBox(
            width: size.width * 0.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Ingresar',
                  textAlign: TextAlign.left,
                ),
                Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.black,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _brandLogo() {
    return Column(
      children: [
        Text(
          "BY",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.grey),
        ),
        const SizedBox(
          height: 10,
        ),
        Image.asset(
          "assets/img/tribu-logo.png",
          height: 40,
        ),
      ],
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    UserProvider userProvider = UserProvider();
    UserModel? user = await userProvider.login(bloc.email, bloc.password);

    if (mounted) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        showMyDialog(
          context,
          "Error",
          const Text(
              "El correo o el código no son válidos, intenta nuevamente."),
        );
      }
    }
  }
}
