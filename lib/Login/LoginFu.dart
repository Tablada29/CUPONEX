import 'package:cuponex/provider/user_mode.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; //Trae y convierte los datos
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';  // para ejecuiones http

const String ip ="http://10.0.2.2:3000";//10.0.2.2

class LoginFu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //return MaterialApp(
    return new Scaffold(
      //  title: 'LOGIN',
      //  home: Scaffold(
        body:
        LoginFul()

      //  )

    );
  }
}

class LoginFul extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _LoginFul();
  }
}

class _LoginFul extends State<StatefulWidget>{

    //Datos para provider
  var idRecibido='';
  var nombreRecibido='';
  var apellidosRecibidos='';
  var direccionRecibidos='';
  var telefonoRecibidos='';
  var correoRecibidos='';
  var contraseniaRecbidos='';

  //Datos Login
  final user = TextEditingController();
  final pass = TextEditingController();

  final _formKey = GlobalKey<FormState>();



  Map data={};
  List loginData = [];
  getLogin() async{
    // Map data;
    // List cuponesData;
    http.Response response = await http.get(Uri.parse(ip+'/login/'+user.text+'/'+pass.text));
    data = json.decode(response.body);
    setState(() {
      loginData = data['data'];
      idRecibido = "${loginData[0]["_id"]}".toString();
      nombreRecibido = "${loginData[0]["nombre"]}".toString();
      apellidosRecibidos = "${loginData[0]["apellidos"]}".toString();
      direccionRecibidos = "${loginData[0]["direccion"]}".toString();
      telefonoRecibidos = "${loginData[0]["telefono"]}".toString();
      correoRecibidos = "${loginData[0]["correo"]}".toString();
      contraseniaRecbidos = "${loginData[0]["contrasenia"]}".toString();

    });
    //  print(response.body);
  }


  @override
  Widget build(BuildContext context) {
    final usermode = Provider.of<UserMode>(context);
    usermode.id =idRecibido;
    usermode.nombre =nombreRecibido;
    usermode.apellidos =apellidosRecibidos;
    usermode.direccion =direccionRecibidos;
    usermode.telefono =telefonoRecibidos;
    usermode.correo =correoRecibidos;
    usermode.contrasenia =contraseniaRecbidos;



    return Container(
      color: Colors.cyan[900],
      width: double.infinity,
      child: ListView(
        padding: EdgeInsets.all(40),
        children: <Widget>[
          SizedBox(
            //Use of SizedBox
            height: 25,
          ),
          Image.asset('assets/cuponexxx.png'),
          const SizedBox(
            //Use of SizedBox
            height: 30,
          ),
          Form(
            key: _formKey,
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: user,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person), //icon at head of input
                    // border: OutlineInputBorder(),
                    labelText: 'Usuario',
                    filled: true, //<-- SEE HERE
                    fillColor: Colors.white, //<-- SEE HERE
                  ),
                  validator: (user) {
                    if (user!.isEmpty) {
                      return 'Por favor ingrese su usuario';
                    }
                  },
                ),
                SizedBox(
                  //Use of SizedBox
                  height: 30,
                ),
                TextFormField(
                  obscureText: true,
                  controller: pass,
                  decoration: InputDecoration(
                    //  suffixIcon: Icon(Icons.remove_red_eye), //icon at tail of input
                    //icon: Icon(Icons.lock), //icon at head of input
                    //prefixIcon: Icon(Icons.people), //you can use prefixIcon property too
                    //prefisIcon sets Icon inside the TextField border, 'icon' sets outside border.
                    //  suffixIcon: Icon(Icons.remove_red_eye) //icon at tail of input
                    icon: Icon(Icons.key), //icon at head of input,
                    // border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                    filled: true, //<-- SEE HERE
                    fillColor: Colors.white, //<-- SEE HERE
                  ),
                  validator: (pass) {
                    if (pass!.isEmpty) {
                      return 'Por favor ingrese su contraseña';
                    }
                  },
                ),
                SizedBox(
                  //Use of SizedBox
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () {
                    getLogin();
                    if (_formKey.currentState!.validate()) {
                      if(usermode.correo==user.text && usermode.contrasenia == pass.text){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(
                                title: Text('¡BIENVENIDO '+usermode.nombre+' '+usermode.apellidos+'!'),
                                content: const Text('Te recordamos que CUPONEX es una APP BETA, por lo tanto tus comentarios nos ayudaran a mejorar, disfrutala'),
                                actions: <Widget>[
                                  /*TextButton(
                                      onPressed: () =>   Navigator.pushNamed(context, '/home'),
                                      child: const Text('Entendido'),
                                    ),*/
                                  TextButton(
                                  /*  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context){
                                     // return Home("${loginData[0]["_id"]}");
                                    //  return HomeF();
                                    })),*/
                                    onPressed: () =>  Navigator.pushNamed(context, '/home'),
                                    child: const Text('Entendido'),
                                  ),
                                ],
                              ),
                        );
                      }
                      else{
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(
                                title: Text('Opss!!'),
                                content: const Text('Los datos ingresados no se encuentran en nuestro sistema, si deseas registrarte presiona el botón de registrarse'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                    child: const Text('Verificar'),
                                  ),
                                  TextButton(
                                    onPressed: () =>  Navigator.pushNamed(context, '/registro'),
                                    child: const Text('Registrarse'),
                                  ),
                                ],
                              ),
                        );
                      }
                    }else{
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                              title: const Text('¡CAMPOS VACIOS!'),
                              content: const Text('Favor de llenar todos los campos'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Ok'),
                                  child: const Text('Ok'),
                                ),
                                /*  TextButton(
                                    onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false),
                                    child: const Text('OK'),
                                  ),*/
                              ],
                            ),
                      );
                    }
                  },
                  // minWidth: 10,
                  height: 40.0,
                  minWidth: 100,
                  color: Colors.yellow,
                  child:

                  Text('Iniciar Sesión',
                      style: TextStyle(
                        color: Colors.black,
                      )),


                ),

              ],
            ),
          ),
          SizedBox(
            //Use of SizedBox
            height: 30,
          ),
          Text(
            '¿Olvidaste tu contraseña?',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            //Use of SizedBox
            height: 30,
          ),
          GestureDetector(
            child: Text(
              '¿No tienes cuenta? Registrate',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/registro');
            },
          )
        ],
      ),
    );
  }

}