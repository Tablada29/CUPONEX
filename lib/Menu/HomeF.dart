
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //peticiones
import 'dart:async'; //manejar codigo async
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/user_mode.dart';
import 'Perfil.dart'; // convertir datos del back json

const String ip ="http://10.0.2.2:3000";//10.0.2.2



class HomeF extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final String prueba;
    return Scaffold(
        body: Homeful()
      //Homeful()
    );


  }
}


class Homeful extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _Homeful();
    //return new _Homeful();
  }
}

class _Homeful extends State<StatefulWidget>{
  String _id='';
  @override
  void initState() {
    super.initState();
    getEmailName();
  }

  Map data={};
  List loginData = [];

  String corre = '';
  String name= '';

  getEmailName() async{
    http.Response response = await http.get(Uri.parse(ip+'/emailname/'+_id));
    data = json.decode(response.body);
    // print(response.body);
    loginData = data['data'];
    corre ="${loginData[0]["correo"]}";
    name ="${loginData[0]["nombre"]}";
    // print(corre);
    // print(name);
  }

  @override
  Widget build(BuildContext context) {
    getEmailName();

    final usermode = Provider.of<UserMode>(context);

    final String finalName = name;
    final String finalEmail =corre;
    return Scaffold(
      appBar: AppBar(
        title: Text('INICIO'),
        backgroundColor: Colors.cyan[800],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              // <-- SEE HERE
              decoration: BoxDecoration(
                color: const Color(0xFF006064),
              ),
              accountName:
              Text(
                usermode.nombre+' '+usermode.apellidos,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
              accountEmail:
              Text(
                usermode.correo,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: const Text('Categorias'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/categorias');
              },
            ),

            ListTile(
              leading: Icon(Icons.business),
              title: const Text('Empresas'),
              onTap: () {
                Navigator.pushNamed(context, '/empresas');
              },
            ),
            ListTile(
              leading: Icon(Icons.document_scanner_sharp),
              title: const Text('Cupones'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/cupones');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/perfil');
              },
            ),
            ListTile(
              leading: Icon(Icons.document_scanner_outlined),
              title: const Text('Cupones Obtenidos'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacementNamed(context, '/cuponesConsuimidos');
              },
            ),
            SizedBox(
              //Use of SizedBox
              height: 250,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.of(context).pop();
                //Navigator.pushNamed(context, '/');
                // Navigator.popAndPushNamed(context, '/');
                Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                //Con esta linea sale y no puede regresar al menu, porque se cierra la app
              },
            ),
          ],

        ),


      ),
      body: Container(
        color: Colors.cyan[900],
        width: double.infinity,
        child: ListView(
            padding: EdgeInsets.all(40),
            children: <Widget>[

              SizedBox(
                //Use of SizedBox
                height: 55,
              ),
              Image.asset('assets/cuponexxx.png'),
              SizedBox(
                //Use of SizedBox
                height: 55,
              ),
            ]
        ),

      ),
    );

  }

}