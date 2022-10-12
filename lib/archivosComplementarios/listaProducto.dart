/*
* Joan Alexander Vera Beltran
* SENA
* Ficha:2470980
* Fecha:10/10/2022
*
* */
//dart convert nos covierte el archivo json
import 'dart:convert';
//el paquete flutter nos importa el framework de flutter
import 'package:flutter/material.dart';
//nos trae el nombre actualizado que le vamos a dar a lo que tenemos en el json
import 'package:read_json_file/archivosComplementarios/ProductDataModel.dart';
//es la hoja donde llegan los productos
import 'package:read_json_file/archivosComplementarios/carritoCompras.dart' show Cart;
//nos ayuda a traer el archivo json
import 'package:flutter/services.dart' as rootBundle;
//este Widget nos permite lectura y escritura
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //creamos un array de la lista de los productos
  List<ProductDataModel> _productosModel = <ProductDataModel>[];
  //creamos un array de la lista de productos del carrito
  final List<ProductDataModel> _listaCarro = <ProductDataModel>[];

  @override
  //Nos permite actualizar la hoja a cada momento
  void initState() {
    setState(() {
      ReadJsonData().then((value) => _productosModel = value);
    });
    super.initState();
  }
  //creamos una funcion para mostrar un baner cuando agrega un producto
  void productoAgregado() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Producto Agregado'),
        duration: Duration(seconds: 1)
      ),
    );
  }
  //creamos una funcion para mostrar un baner cuando quita un producto
  void quitarProducto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Producto fuera de la lista'),
          duration: Duration(seconds: 1)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Es un Widget el cual nos ayuda a darle un mejor diseño a nuestra hoja
    return Scaffold(
      //creamos un header con un titulo y un icono el cual hace un conteo de los productos que entran a la lista del carrito
        appBar: AppBar(
          title: Text('Productos '),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    const Icon(
                      Icons.shopping_cart,
                      size: 38,
                    ),
                    if (_listaCarro.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Text(
                            _listaCarro.length.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                        ),
                      )
                  ],
                ),
                //Nos envia a la lista de productos de carrito
                onTap: () {
                  if (_listaCarro.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Cart(_listaCarro),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
        //creamos una lista la cual tiene una imagen del producto, el nombre del producto y un icono paraa añadir a la lista del carrito
        body: ListView.builder(
          //mostramos los productos que tenemos en la lista
          itemCount: _productosModel.length,
          itemBuilder: (context, index) {
            //hacemos un carta para tener todo mas organizado
            return Card(
              //la separamos 5px una de cada
              elevation: 5,
              //hacemos una margen de cada carta
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Container(
                padding: EdgeInsets.all(8),
                //Creamos una fila
                child: Row(
                  //alineamos al centro
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //hacemos un contenedor el cual tiene una imagen
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: Image(
                        image: NetworkImage(
                            _productosModel[index].imageURL.toString()),
                        fit: BoxFit.fill,
                      ),
                    ),
                    //expandimos el row
                    Expanded(
                      //creamos otro contenedor el cual tiene el nombre del producto y precio
                        child: Container(
                      padding: EdgeInsets.only(bottom: 8),
                      //creamos una columna para tener los dos objetos uno debajo del otro
                      child: Column(
                        //centramos
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: Text(
                              //productosModel es el array de productos en este momento lo utilizamos para que nos traiga el nombre
                              _productosModel[index].nombre.toString(),
                              //damos un negrilla y tamaño de letra
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child:
                            //productosModel es el array de productos en este momento lo utilizamos para que nos traiga el precio
                                Text(_productosModel[index].precio.toString()),
                          ),
                        ],
                      ),
                    )),
                    //creamos un icono que sirve de boton
                    IconButton(
                        onPressed: () {
                          //Nos sirve para mantener el estado del boton actualizado
                          setState(() {
                            //este if nos mantiene el producto fuera de la lista

                            if (_productosModel[index].isAdd!) {
                              _listaCarro.removeWhere(
                                  (element) => element.id == index);
                              _productosModel[index].isAdd = false;
                              quitarProducto();
                            }
                            //el else agrega el producto a la lista del carrito
                            else {
                              productoAgregado();
                              _listaCarro.add(_productosModel[index]);
                              _productosModel[index].isAdd = true;
                            }
                          });
                        },
                        //los signos de diferente al inicio y al finalnos sirve para invertir de false a true y viceversa
                        icon: (!_productosModel[index].isAdd!)
                        //el signo? convinado con los : nos sirve como una sentencia de if y else
                            ? Icon(Icons.shopping_cart)
                            : Icon(
                                Icons.shopping_cart_checkout,
                                color: Colors.green,
                              ))
                  ],
                ),
              ),
            );
          },
        ));
  }
//llamamos el Json y esperamos la respuesta y la convertimos a una lista
  Future<List<ProductDataModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('jsonfile/productlist.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => ProductDataModel.fromJson(e)).toList();
  }
}
