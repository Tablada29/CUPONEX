
import 'package:cuponex/Menu/Categorias.dart';
import 'package:cuponex/Menu/Cupones.dart';
import 'package:cuponex/Menu/CuponesObtenidos.dart';
import 'package:cuponex/Menu/Empresas.dart';
import 'package:cuponex/Menu/HomeF.dart';
import 'package:cuponex/Menu/Perfil.dart';
import 'package:cuponex/Registro/Registro.dart';
import 'package:cuponex/provider/user_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Login/LoginFu.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UserMode(),
          child: MaterialApp(
              debugShowCheckedModeBanner: false, //Para quitar modo debug
              title: 'CUPONEX',
              initialRoute: '/',
              routes: {
                //'/': (context) => LoginF(),
                '/': (context) => LoginFu(),
                '/home': (context) => HomeF(),
                '/registro': (context) => RegistroCostumer(),
                '/categorias': (context) => Categorias(),
                '/cupones': (context) => Cupones(),
                '/empresas': (context) => Empresas(),
                '/perfil': (context) => Perfil(),
                '/cuponesConsuimidos' : (context) => CuponesObtenidos(),
              },
            ),
    );
  }
}