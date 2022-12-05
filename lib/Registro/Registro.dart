import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; //Trae y convierte los datos
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // para ejecuiones http
import 'package:intl/intl.dart'; // convertir datos del back json


const String ip ="http://10.0.2.2:3000";//10.0.2.2


List<String> listitems = ["Seleccione Usuario", "Cliente", "Empresa"];
String selectval = "Seleccione Usuario";

List<String> categorylist = ["Seleccione Categoria","Electronica", "Ropa", "Entretenimiento",];
String category = "Seleccione Categoria";

String tipo = "Vacio";

class RegistroCostumer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       // title: 'Registro',
       // home: Scaffold(
            body:
                VentanaRegistro()
       // )
    );
  }
}

class VentanaRegistro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _VentanaRegistro();
  }
}

class _VentanaRegistro extends State<StatefulWidget>{


  //Datos Cliente
  final clname = TextEditingController();
  final clape = TextEditingController();
  final cldir = TextEditingController();
  final cltel = TextEditingController();
  final clemail = TextEditingController();
  final clpass = TextEditingController();

  Map data={};
//Metodo para registrar datos
  registroUsuarioCliente() async{
    http.Response response = await http.post(Uri.parse(ip+'/insertarUsuario'),
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
          "Content-Type" : "application/x-www-form-urlencoded"
        });
    print(response);
  }
  //Datos Empresa
  final busname = TextEditingController();
  final busdir = TextEditingController();
  final bustel = TextEditingController();
  final busemail = TextEditingController();
  final buspass = TextEditingController();
  String buscat = '';
  //Meotod para registrar Empresa
  NewRegisterBussines() async{
    http.Response response = await http.post(Uri.parse(ip+'/insertarEmpresa'),
        body: {
          "nombre": busname.text,
          "direccion": busdir.text,
          "telefono": bustel.text,
          "correo": busemail.text,
          "contrasenia": buspass.text,
          "idCategoria" : buscat,
          "tipoUsr": true.toString(),
        },
        headers: {
          "Content-Type" : "application/x-www-form-urlencoded"
        });
    print(response);
  }
  /*********************************************/


  final _formKey = GlobalKey<FormState>();

  // regular expression to check if string
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;

  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great

  //A function that validate user entered password
  bool validatePassword(String pass){
    String _password = pass.trim();

    if(_password.isEmpty){
      setState(() {
        password_strength = 0;
      });
    }else if(_password.length < 6 ){
      setState(() {
        password_strength = 1 / 4;
      });
    }else if(_password.length < 8){
      setState(() {
        password_strength = 2 / 4;
      });
    }else{
      if(pass_valid.hasMatch(_password)){
        setState(() {
          password_strength = 4 / 4;
        });
        return true;
      }else{
        setState(() {
          password_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }



  @override
  Widget build(BuildContext context) {

    String _password="";
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
            SizedBox(
              //Use of SizedBox
              height: 30,
            ),
            Text(
              'REGISTRO CUPONEX',
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
            Container(
             child: Padding(
               padding: EdgeInsets.only(
                   left:43,
                   right:10, top: 10, bottom: 10),
            child: DropdownButtonFormField(
              isExpanded: true,
              // icon: Icon(Icons.groups),

             icon: const Icon(
                Icons.groups,
                color: Colors.black,
              ),
              iconSize: 25,
              elevation: 16,
              dropdownColor: Colors.white,
              style: TextStyle(
                  color: Colors.black
              ),
              /* underline: Container(
                height: 2,
                color: Colors.black,
              ),*/
              decoration: InputDecoration(
                  hintText: '',
               // border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
              ),
              value: selectval,
              onChanged: (value){
                setState(() {
                  print(value.toString());
                  selectval = value.toString();
                  tipo = selectval;
                });
              },
              items: listitems.map((itemone){
                return DropdownMenuItem(
                    value: itemone,
                    child: Text(itemone)
                );
              }).toList(),
                ),
              ),
            ),

                  Column(
                  children: [
                    if(tipo=='Cliente')...[
                      ////////************* HASata aquí Inicia la parte de cliente
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
                      SizedBox(
                        //Use of SizedBox
                        height: 0,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(

                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child:

                              TextFormField(
                                controller: clpass,
                                onChanged: (value){
                                  _formKey.currentState!.validate();
                                },
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Por favor ingrese su contraseña";
                                  }else{
                                    //call function to check password
                                    bool result = validatePassword(value);
                                    if(result){
                                      // create account event
                                      return null;
                                    }else{
                                     return "Ingrese mayuscula, minuscula, numero, signos";
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                icon: Icon(Icons.person), //icon at head of input
                                //  border: OutlineInputBorder(),
                                labelText: 'Contraseña',
                                filled: true, //<-- SEE HERE
                                fillColor: Colors.white, //<-- SEE HERE
                               // hintText: "Contraseña",
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: LinearProgressIndicator(
                                value: password_strength,
                                backgroundColor: Colors.grey[300],
                                minHeight: 5,
                                color: password_strength <= 1 / 4
                                    ? Colors.red
                                    : password_strength == 2 / 4
                                    ? Colors.yellow
                                    : password_strength == 3 / 4
                                    ? Colors.blue
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                       SizedBox(
                         //Use of SizedBox
                         height: 12,
                       ),
                      ////////************* HASata aquí llega la parte de cliente
                    ]else if(tipo=='Empresa')...[
                      ////////************* HASata aquí Inicia la parte de Empresas
                      SizedBox(
                        //Use of SizedBox
                        height: 12,
                      ),
                      TextField(
                        controller: busname,
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
                        controller: busdir,
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
                        controller: bustel,
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
                        controller: busemail,
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
                        height: 2,
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left:40,
                              right:0, top: 10, bottom: 10),
                          child:
                          DropdownButtonFormField(

                            isExpanded: true,
                            // icon: Icon(Icons.groups),

                            icon: const Icon(
                              Icons.category,
                              color: Colors.black,
                            ),
                            iconSize: 25,
                            elevation: 16,
                            dropdownColor: Colors.white,
                            style: TextStyle(
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                              hintText: '',
                              // border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            value: category,
                            onChanged: (value2){
                              setState(() {
                                print(value2.toString());
                                category = value2.toString();
                                String f = '';
                                switch(category){
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
                                buscat = f;
                              });
                            },
                            items: categorylist.map((itemone){
                              return DropdownMenuItem(
                                  value: itemone,
                                  child: Text(itemone)
                              );
                            }).toList(),

                          ),
                        ),
                      ),
                      SizedBox(
                        //Use of SizedBox
                        height: 2,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(

                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child:

                              TextFormField(
                                  controller: buspass,
                                  onChanged: (value){
                                    _formKey.currentState!.validate();
                                  },
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Por favor ingrese su contraseña";
                                    }else{
                                      //call function to check password
                                      bool result = validatePassword(value);
                                      if(result){
                                        // create account event
                                        return null;
                                      }else{
                                        return "Ingrese mayuscula, minuscula, numero, signos";
                                      }
                                    }
                                  },
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.person), //icon at head of input
                                    //  border: OutlineInputBorder(),
                                    labelText: 'Contraseña',
                                    filled: true, //<-- SEE HERE
                                    fillColor: Colors.white, //<-- SEE HERE
                                    // hintText: "Contraseña",
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: LinearProgressIndicator(
                                value: password_strength,
                                backgroundColor: Colors.grey[300],
                                minHeight: 5,
                                color: password_strength <= 1 / 4
                                    ? Colors.red
                                    : password_strength == 2 / 4
                                    ? Colors.yellow
                                    : password_strength == 3 / 4
                                    ? Colors.blue
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ////////************* HASata aquí llega la parte de empresa
                    ]
                  ]),
            Text(
              'Al registrarse esta aceptando todos los terminos y condiciones',
              textAlign: TextAlign.center,
              style: const TextStyle(
                // fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              //Use of SizedBox
              height: 12,
            ),
            MaterialButton(
              onPressed: () {
                if(tipo=='Cliente'){

                  if( clname.text == null &&
                      clape.text == null &&
                      cldir.text == null &&
                      cldir.text == null &&
                      cltel.text == null &&
                      clemail.text == null &&
                      clpass.text == null
                  ||
                      clname.text == '' &&
                          clape.text == '' &&
                          cldir.text == '' &&
                          cldir.text == '' &&
                          cltel.text == '' &&
                          clemail.text == '' &&
                          clpass.text == ''
                      ||
                      clname.text == '' ||
                          clape.text == '' ||
                          cldir.text == '' ||
                          cldir.text == '' ||
                          cltel.text == '' ||
                          clemail.text == '' ||
                          clpass.text == ''  ||
                      clname.text == null ||
                          clape.text == null ||
                          cldir.text == null ||
                          cldir.text == null ||
                          cltel.text == null ||
                          clemail.text == null ||
                          clpass.text == null
                  ){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(
                            title: const Text('¡CAMPOS VACIOS!'),
                            content: const Text('Favor de llenar todos los campos sin excepción alguna'),
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
                  }else{
                    registroUsuarioCliente();
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(
                            title: const Text('REGISTRO EXITOSO!!!'),
                            content: const Text('Puede iniciar sesión con su correo y contraseña registrados'),
                            actions: <Widget>[
                              /*TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),*/
                              TextButton(
                                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                    );
                  }


                }else if(tipo=='Empresa'){
                  if( busname.text == null &&
                      busdir.text == null &&
                      bustel.text == null &&
                      busemail.text == null &&
                      buspass.text == null &&
                      buscat == null
                      ||
                      busname.text == '' &&
                          busdir.text == '' &&
                          bustel.text == '' &&
                          busemail.text == '' &&
                          buspass.text =='' &&
                          buscat == ''
                      ||
                      busname.text == null ||
                          busdir.text == null ||
                          bustel.text == null ||
                          busemail.text == null ||
                          buspass.text == null ||
                          buscat == null ||
                  busname.text == '' ||
                  busdir.text == '' ||
                  bustel.text == '' ||
                  busemail.text == '' ||
                  buspass.text == '' ||
                  buscat == ''
                  ){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(
                            title: const Text('¡CAMPOS VACIOS!'),
                            content: const Text('Favor de llenar todos los campos sin excepción alguna'),
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
                  }else{
                    NewRegisterBussines();
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(
                            title: const Text('REGISTRO EXITOSO!!!'),
                            content: const Text('Puede iniciar sesión con su correo y contraseña registrados'),
                            actions: <Widget>[
                              /*TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),*/
                              TextButton(
                                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                    );
                  }
                }
                selectval= "Seleccione Usuario";
                tipo = "Seleccione Usuario";
              },
              // minWidth: 10,
              height: 40.0,
              color: Colors.yellow,
              child:

              Text('Registrarse',
                  style: TextStyle(
                    color: Colors.black,
                  )),


            ),
          ],
        ),
    );
  }

}
