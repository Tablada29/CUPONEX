import 'package:flutter/material.dart';

class UserMode extends ChangeNotifier {
/*
  List _UserData = [];

  List get userMode => _UserData;

  set userData(List data){
    this._UserData = data;
    notifyListeners();
  }

  List get UserData => _UserData;

  set UserData(List value) {
    _UserData = value;
  }
*/
  String _id = '';

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String _nombre = '';

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }



  String _apellidos = '';
  String _direccion = '';
  String _telefono = '';
  String _correo = '';
  String _contrasenia = '';
  String _tipoUsr = '';



  String get telefono => _telefono;

  set telefono(String value) {
    _telefono = value;
  }

  String get correo => _correo;

  set correo(String value) {
    _correo = value;
  }

  String get contrasenia => _contrasenia;

  set contrasenia(String value) {
    _contrasenia = value;
  }

  String get tipoUsr => _tipoUsr;

  set tipoUsr(String value) {
    _tipoUsr = value;
  }

  String get apellidos => _apellidos;

  set apellidos(String value) {
    _apellidos = value;
  }

  String get direccion => _direccion;

  set direccion(String value) {
    _direccion = value;
  }

}