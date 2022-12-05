import 'package:cuponex/Menu/Detalles/EmpresasCat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //peticiones
import 'dart:async'; //manejar codigo async
import 'dart:convert';

import 'package:provider/provider.dart';

import '../provider/user_mode.dart'; // convertir datos del back json

const String ip ="http://10.0.2.2:3000";//10.0.2.2

class Categorias extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final usermode = Provider.of<UserMode>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('CATEGORIAS'),
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
        body: Categoriaful()
    );
  }
}


class Categoriaful extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _Categoriaful();
  }
}

class _Categoriaful extends State<StatefulWidget>{
  Map data={};
  List categoriasDat = [];

  getCategorias() async{
    // Map data;
    // List cuponesData;
    http.Response response = await http.get(Uri.parse(ip+'/consultarCate'));

    data = json.decode(response.body);
    setState(() {
      categoriasDat = data['data'];
    });
    print(response.body);
  }

  @override
  void initState() {
    super.initState();
    getCategorias();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan[900],
      width: double.infinity,
      child: ListView.builder(
          padding: EdgeInsets.all(40),
          itemCount: categoriasDat == null ? 0 : categoriasDat.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              child: Row(
                children: <Widget>[
                if("${categoriasDat[index]["nombreCategoria"]}"=='Deportes')...[
                  Icon(
                    Icons.sports_soccer,
                    color: Colors.blueAccent,
                    size: 50.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ]else if("${categoriasDat[index]["nombreCategoria"]}"=='Comida')...[
                  Icon(
                    Icons.fastfood_outlined,
                    color: Colors.deepOrange,
                    size: 50.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ]else if("${categoriasDat[index]["nombreCategoria"]}"=='Ropa')...[
                  Icon(
                    Icons.checkroom,
                    color: Colors.white,
                    size: 50.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ]else if("${categoriasDat[index]["nombreCategoria"]}"=='Electronica')...[
                  Icon(
                    Icons.microwave,
                    color: Colors.green,
                    size: 50.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ]else if("${categoriasDat[index]["nombreCategoria"]}"=='Entretenimiento')...[
                  Icon(
                  Icons.movie_outlined,
                  color: Colors.black,
                  size: 50.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  ],
                  SizedBox(
                    //Use of SizedBox
                    width: 9,
                  ),
                 /* Text(
                    "${categoriasDat[index]["nombreCategoria"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white60,
                    ),
                  ),*/
                   GestureDetector(
                  onTap: () {
                    setState(() {
                    String f = '';
                    switch("${categoriasDat[index]["nombreCategoria"]}"){
                                  case 'Electronica' : {
                                    f = "4".toString();
                                  }
                                  break;
                                  case 'Ropa' : {
                                    f = "3".toString();
                                  }
                                  break;
                                  case 'Entretenimiento' : {
                                    f = "5".toString();
                                  }
                                  break;
                                  case 'Comida' : {
                                    f = "2".toString();
                                  }
                                  break;
                                  case 'Deportes' : {
                                    f = "1".toString();
                                  }
                                  break;
                                }
                      print("Voy a mandar el dato: "+"${categoriasDat[index]["nombreCategoria"]}");
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return EmpresasCat(f);
                      }));
                    });
                  },
                  child: Text(
                    "${categoriasDat[index]["nombreCategoria"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white70,
                    ),
                  ),

                ),
                  SizedBox(
                    //Use of SizedBox
                    height: 80,
                  ),
                ],
              ),
            );
          }
      ),

    );
  }

}