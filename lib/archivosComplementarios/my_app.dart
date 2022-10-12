//Importamos el paquete de flutter
import 'package:flutter/material.dart';
//Importamos un archivo el cual esta en la carpeta presentation
//show nos sirve para renombrar una direccion
import 'package:read_json_file/archivosComplementarios/listaProducto.dart' show  MyHomePage;
//Stateful nos permite lectura y escritura de la aplicacion
class MyApp extends StatefulWidget {
//Sobre escritura
  @override
  //Creamos la aplicacion
  State<MyApp> createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Quitamos el baner que sale predeterminado
      debugShowCheckedModeBanner: false,
      //Colocamos un titulo al proyecto
      title: 'Carrito Compras',
      home: const  MyHomePage(),
    );
  }
}