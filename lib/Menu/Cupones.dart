/*import 'dart:async';
import 'dart:convert'; //Trae y convierte los datos
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // para ejecuiones http
import 'package:flutter/foundation.dart';
class Cupones extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CUPONEX MENÚ'),
          backgroundColor: Colors.cyan[800],
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader( // <-- SEE HERE
                decoration: BoxDecoration(
                  color: const Color(0xFF006064),
                ),
                accountName: Text(
                  "Pinkesh Darji",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                ),
                accountEmail: Text(
                  "pinkesh.earth@gmail.com",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
                currentAccountPicture: FlutterLogo(),
              ),

              ListTile(
                leading: Icon(Icons.category),
                title: const Text('Categorias'),
                onTap: () {
                  Navigator.pushNamed(context, '/categorias');
                },
              ),
              ListTile(
                leading: Icon(Icons.business),
                title: const Text('Empresas'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
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
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.document_scanner_outlined),
                title: const Text('Cupones Obtenidos'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
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
                  Navigator.pushNamed(context, '/');
                },
              ),
            ],
          ),
        ),
        body: Cuponesful()
    );
  }
}
//MODELOS
class Cupon{
  final int idCupon;
  final String nombre;
  final String fechaInicio;
  final String fechaFin;
  final int descuento;
  final int porcentaje;
  final String descripcion;
  final int idEmpresaOfrece;
  final int cantidad;

  Cupon({ required this.idCupon,
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFin,
    required this.descuento,
    required this.porcentaje,
    required this.descripcion,
    required this.idEmpresaOfrece,
    required this.cantidad,
});


}
/*
class User{
  final int id;
  final int userId;
  final String title;
  final String body;

  User({required this.id, required this.userId, required this.title, required this.body});

//Constructor para acutalización
/*
  User({
    this.id = 0,
    this.userId = 0,
    this.title="",
    this.body=""});
*/

}*/
class Cuponesful extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _Cuponesful();
  }
}

class _Cuponesful extends State<StatefulWidget>{

  //petición
  Future<List<Cupon>> getRequest() async{

    String url="http://192.168.92.1:3000/consultarCupones";
    final response=await http.get(Uri.parse(url));
    var responseData=jsonDecode(response.body);
    print("LA data tiene: "+response.body);
    //var response = null;

    //Cramos la lista
    List<Cupon> Cupones = [];
    for (var singleCupon in responseData){
      Cupon cupon =Cupon(
        idCupon:singleCupon.body["idCupon"],
        nombre:singleCupon["nombre"],
       fechaInicio:singleCupon["fechaInicio"],
        fechaFin:singleCupon["fechaFin"],
        descuento:singleCupon["descuento"],
        porcentaje:singleCupon["porcentaje"],
        descripcion:singleCupon["descripcion"],
        idEmpresaOfrece:singleCupon["idEmpresaOfrece"],
        cantidad:singleCupon["cantidad"],
      );
       Cupones.add(cupon);

      }
   // print(Cupones);
    return Cupones;
  }


  @override
  /*
  Widget build(BuildContext context) {
    return SafeArea(
     // color: Colors.cyan[900],
     // width: double.infinity,
      child: Container(
          padding: EdgeInsets.all(40),
          child: FutureBuilder(
              future: getRequest(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot ){
                if(snapshot.data==null){
                  return Container(
                      child: Center(child: CircularProgressIndicator(),)
                  );
                }
                else{
                  return ListView.builder(itemCount: snapshot.data.length,
                      itemBuilder: (ctx,index)=> ListTile(

                       subtitle: Text(snapshot.data[index].nombre),
                      //  contentPadding: const EdgeInsets.only(bottom: 20.0),
                      )
                  );
                }
              }
          ),
      ),

    );
  }*/
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            child: FutureBuilder(
                future: getRequest(),
                builder: (BuildContext ctx, AsyncSnapshot snapshot ){
                  if(snapshot.data==null){
                    print("Entre al if");
                    return Container(
                        child: Center(child: CircularProgressIndicator(),)
                    );
                  }
                  else{
                    print("Entre al else");
                    return ListView.builder(itemCount: snapshot.data.length,
                        itemBuilder: (ctx,index)=> ListTile(
                          subtitle: Text(snapshot.data[index].idCupon),
                            contentPadding: const EdgeInsets.only(bottom: 20.0),
                        )
                    );

                  }
                }
            ),
          ),
        )
    );

  }



/*
  //petición
  Future<List<User>> getRequest() async{
    String url="https://jsonplaceholder.typicode.com/posts";
    final response=await http.get(Uri.parse(url));
    var responseData=json.decode(response.body);

    //Cramos la lista
    List<User> users = [];
    //recorremos la lista
    for (var singleUser in responseData){
      User user =User(
        id:singleUser["id"],
        userId:singleUser["userId"],
        title:singleUser["title"],
        body:singleUser["body"],
      );
      users.add(user);

    }
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Datos desde API"),
            leading: const Icon(Icons.get_app),
          ),
          body: Container(
            child: FutureBuilder(
                future: getRequest(),
                builder: (BuildContext ctx, AsyncSnapshot snapshot ){
                  if(snapshot.data==null){
                    return Container(
                        child: Center(child: CircularProgressIndicator(),)
                    );
                  }
                  else{
                    return ListView.builder(itemCount: snapshot.data.length,
                        itemBuilder: (ctx,index)=> ListTile(
                          title: Text(snapshot.data[index].title),
                          subtitle: Text(snapshot.data[index].body),
                          contentPadding: const EdgeInsets.only(bottom: 20.0),
                        )
                    );
                  }
                }
            ),
          ),
        )
    );

  }
*/

}
*/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //peticiones
import 'dart:async'; //manejar codigo async
import 'dart:convert'; // convertir datos del back json
import 'package:cuponex/Menu/Detalles/DetalleCupon.dart';
import 'package:provider/provider.dart';

import '../provider/user_mode.dart';

const String ip ="http://10.0.2.2:3000"; //10.0.2.2

class Cupones extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final usermode = Provider.of<UserMode>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('CUPONES'),
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
        body: Cuponesful()
    );
  }
}

class Cuponesful extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _Cuponesful();
  }
}

class _Cuponesful extends State<StatefulWidget>{
   Map data={};
   List cuponesData = [];


  getCupones() async{
   // Map data;
   // List cuponesData;
    http.Response response = await http.get(Uri.parse(ip+'/consultarCupones'));

   data = json.decode(response.body);
   setState(() {
    cuponesData = data['data'];
   });
    print(response.body);
  }

  @override
  void initState() {
    super.initState();
    getCupones();
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
                  Icons.discount,
                  color: Colors.redAccent,
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
                        return DetalleCupon("${cuponesData[index]["_id"]}");
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



/*
  //petición
  Future<List<User>> getRequest() async{
    String url="https://jsonplaceholder.typicode.com/posts";
    final response=await http.get(Uri.parse(url));
    var responseData=json.decode(response.body);

    //Cramos la lista
    List<User> users = [];
    //recorremos la lista
    for (var singleUser in responseData){
      User user =User(
        id:singleUser["id"],
        userId:singleUser["userId"],
        title:singleUser["title"],
        body:singleUser["body"],
      );
      users.add(user);

    }
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Datos desde API"),
            leading: const Icon(Icons.get_app),
          ),
          body: Container(
            child: FutureBuilder(
                future: getRequest(),
                builder: (BuildContext ctx, AsyncSnapshot snapshot ){
                  if(snapshot.data==null){
                    return Container(
                        child: Center(child: CircularProgressIndicator(),)
                    );
                  }
                  else{
                    return ListView.builder(itemCount: snapshot.data.length,
                        itemBuilder: (ctx,index)=> ListTile(
                          title: Text(snapshot.data[index].title),
                          subtitle: Text(snapshot.data[index].body),
                          contentPadding: const EdgeInsets.only(bottom: 20.0),
                        )
                    );
                  }
                }
            ),
          ),
        )
    );

  }
*/

}