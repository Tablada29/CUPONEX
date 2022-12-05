import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //peticiones
import 'dart:async'; //manejar codigo async
import 'dart:convert'; // convertir datos del back json
import 'package:cuponex/Menu/Detalles/DetalleCupon.dart';
import 'package:provider/provider.dart';

import 'package:cuponex/provider/user_mode.dart';

import 'CuponesCat.dart';

const String ip ="http://10.0.2.2:3000"; //10.0.2.2

class EmpresasCat extends StatelessWidget{
  EmpresasCat(this.idBase);
  final String idBase;

  @override
  Widget build(BuildContext context) {
    final usermode = Provider.of<UserMode>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('EMPRESAS'),
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
        body: Cuponesful(idBase)
    );
  }
}

class Cuponesful extends StatefulWidget{
  Cuponesful(this.idBase);
  final String idBase;
  @override
  State<StatefulWidget> createState() {
    return new _Cuponesful(idBase);
  }
}

class _Cuponesful extends State<StatefulWidget>{
  _Cuponesful(this.idBase);
  final String idBase;
  Map data={};
  List cuponesData = [];

  getEmpresasCat() async{
    // Map data;
    // List cuponesData;
    http.Response response = await http.get(Uri.parse(ip+'/consEmpreByCat/'+idBase));

    data = json.decode(response.body);
    setState(() {
      cuponesData = data['data'];
    });
    print(response.body);
  }

  @override
  void initState() {
    super.initState();
    getEmpresasCat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan[900],
      width: double.infinity,
      child:
      ListView.builder(
          padding: EdgeInsets.all(40),
          itemCount: cuponesData == null ? 0 : cuponesData.length,
          itemBuilder: (BuildContext context, int index){

            return Container(
              child: Row(
                children: <Widget>[
                  if("${cuponesData[index]["cantidad"]}"!='0')...[
                    Icon(
                      Icons.business,
                      color: Colors.yellow ,
                      size: 50.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    SizedBox(
                      //Use of SizedBox
                      width: 9,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          print("Voy a mandar el dato: "+"${cuponesData[index]["_id"]}");
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return CuponesByCatBus("${cuponesData[index]["_id"]}");
                          }));
                        });
                        //print("Me presiono fuerte: "+"${cuponesData[index]["idCupon"]}");
                      },
                      child: Text(
                        "${cuponesData[index]["nombre"]}",
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
                  ]else...[
                  ]
                ],
              ),
            );
          }
      ),

    );
  }
}