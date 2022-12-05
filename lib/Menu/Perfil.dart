
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; //Trae y convierte los datos
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // para ejecuiones http
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/user_mode.dart'; // convertir datos del back json

const String ip ="http://10.0.2.2:3000";//10.0.2.2

class Perfil extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Perfilful(),
    );
  }
}

class Perfilful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Perfilful();
  }
}

class _Perfilful extends State<StatefulWidget>{
  final usermode = Provider.of<UserMode>;
  //Datos Cliente
  final clname = TextEditingController();
  final clape = TextEditingController();
  final cldir = TextEditingController();
  final cltel = TextEditingController();
  final clemail = TextEditingController();
  final clpass = TextEditingController();

  Map data={};
  List userData = [];
//Metodo para registrar datos
  actualizarDatosUsuario(id) async{
    http.Response response = await http.post(Uri.parse(ip+'/actualizarUser/'+id),
      body: {
        "nombre": clname.text,
        "apellidos": clape.text,
        "direccion": cldir.text,
        "telefono": cltel.text,
        "correo": clemail.text,
        "contrasenia": clpass.text,
        "tipoUsr": false.toString(),
      },
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),);
    print('la respuesta tiene: '+response.body);
  }


  @override
  Widget build(BuildContext context) {



    String idUpdate = '';
    final usermode = Provider.of<UserMode>(context);
    idUpdate = usermode.id;

    clname.text = usermode.nombre;
    clape.text  = usermode.apellidos;
    cldir.text  = usermode.direccion;
    cltel.text  = usermode.telefono;
    clemail.text  = usermode.correo;
    clpass.text = usermode.contrasenia;

    String _password="";
    return Scaffold(
      appBar: AppBar(
        title: Text('ACTUALIZAR DATOS'),
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
      body:
      Container(
        color: Colors.cyan[900],
        width: double.infinity,
        child:
        ListView(
          padding: EdgeInsets.all(40),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child:    Image.asset('assets/cuponexxx.png'),

            ),
            SizedBox(
              //Use of SizedBox
              height: 10,
            ),
            Text(
              'ACTUALIZAR INFORMACIÓN',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              //Use of SizedBox
              height: 12,
            ),
            Column(
                children: [
                  SizedBox(
                    //Use of SizedBox
                    height: 12,
                  ),
                  TextField(
                    controller: clname,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person), //icon at head of input
                      // border: OutlineInputBorder(),
                      labelText: 'Nombre',
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white, //<-- SEE HERE
                    ),
                  ),
                  SizedBox(
                    //Use of SizedBox
                    height: 12,
                  ),
                  TextField(
                    controller: clape,
                    decoration: InputDecoration(
                      icon: Icon(Icons.dns), //icon at head of input
                      //border: OutlineInputBorder(),
                      labelText: 'Apellidos',
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white, //<-- SEE HERE
                    ),
                  ),
                  SizedBox(
                    //Use of SizedBox
                    height: 12,
                  ),
                  TextField(
                    controller: cldir,
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_on), //icon at head of input
                      // border: OutlineInputBorder(),
                      labelText: 'Dirección',
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white, //<-- SEE HERE
                    ),
                  ),
                  SizedBox(
                    //Use of SizedBox
                    height: 12,
                  ),
                  TextField(
                    controller: cltel,
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone), //icon at head of input
                      // border: OutlineInputBorder(),
                      labelText: 'Telefono',
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white, //<-- SEE HERE
                    ),
                  ),
                  SizedBox(
                    //Use of SizedBox
                    height: 12,
                  ),
                  TextField(
                    controller: clemail,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email), //icon at head of input
                      // border: OutlineInputBorder(),
                      labelText: 'Correo',
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white, //<-- SEE HERE
                    ),
                  ),
                  SizedBox(
                    //Use of SizedBox
                    height: 12,
                  ),
                  TextField(
                    controller: clpass,
                    decoration: InputDecoration(
                      icon: Icon(Icons.password), //icon at head of input
                      // border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white, //<-- SEE HERE
                    ),
                  ),
                  SizedBox(
                    //Use of SizedBox
                    height: 12,
                  ),
                ]),
            SizedBox(
              //Use of SizedBox
              height: 12,
            ),
            MaterialButton(
              onPressed: () {
                actualizarDatosUsuario(idUpdate);
                usermode.nombre =clname.text;
                usermode.apellidos =clape.text;
                usermode.direccion =cldir.text ;
                usermode.telefono =cltel.text;
                usermode.correo =clemail.text ;
                usermode.contrasenia =clpass.text;

                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        title: const Text('ACTUALIZACIÓN EXITOSA!!!'),
                        content: const Text('Los Datos han sido actualizado correctamente'),
                        actions: <Widget>[
                         /* TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Regresar'),

                          ),*/
                          TextButton(
                            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false),
                            child: const Text('Entendido'),
                          ),
                        ],
                      ),

                );




              },
              // minWidth: 10,
              height: 40.0,
              color: Colors.yellow,
              child:
              Text('Actualizar Información',
                  style: TextStyle(
                    color: Colors.black,
                  )),
            ),
          ],
        ),
      ),
    );
  }

}
