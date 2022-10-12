/*
* Joan Alexander Vera Beltran
* SENA
* Ficha:2470980
* Fecha:10/10/2022
*
* */
//el paquete flutter nos importa el framework de flutter
import 'package:flutter/material.dart';
//nos trae el nombre actualizado que le vamos a dar a lo que tenemos en el json
import 'ProductDataModel.dart';
//este Widget nos permite lectura y escritura
class Cart extends StatefulWidget {
  // definimos el array en la variable cart
  final List<ProductDataModel> _cart;

  const Cart(this._cart, {super.key});

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);


  List<ProductDataModel> _cart;

  @override
  Widget build(BuildContext context) {
    //este widget nos ayuda a darle un mejor diseño a nuestra hoja
    return Scaffold(
      //creamos un header con un texto y icono para devolverce  a la hoja anterior
      appBar: AppBar(
        title: const Text(
          'Detalle',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _cart.length;
            });
          },
          color: Colors.white,
        ),
      ),
      body: GestureDetector(
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              ListView.builder(
                scrollDirection: Axis.vertical,
                //nos ayuda a que solo ocupe el espacio que necesita
                shrinkWrap: true,
                //Nos ayuda a que el usuario no haga scroll
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cart.length,
                itemBuilder: (context, index) {
                  //hacemos una carta
                  return Card(
                    // la separamos 5px una de la otra
                    elevation: 5,
                    //les creamos una margen
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                    //realizamos una culumna para mantener la imagen el nombre y el precio
                    child: Column(
                      children: <Widget>[
                        //creamos una fila
                        Row(
                          //centramos los elementos
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //colocamos la imagen
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: Image(
                                image: NetworkImage(
                                    _cart[index].imageURL.toString()),
                                //nos ayuda a alinear y darle ajuste a la imagen
                                fit: BoxFit.fill,
                              ),
                            ),
                            //expandimos el row
                            Expanded(
                                child: Container(
                                  //le damos una distancia de 8px
                              padding: EdgeInsets.only(bottom: 8),
                              child: Column(
                                //centramos
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // colocamos el nombre le damos una negrilla y tamaño de letra
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    child: Center(
                                      child: Text(
                                        _cart[index].nombre.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            //SizeBox vacío entre los dos widgets para obtener algo de espacio en el medio
                            const SizedBox(
                              height: 38.0,
                            ),
                            //colocamos el precio y le damos un tamaño de letra,negrita y color
                            Text(_cart[index].precio.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black)),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ))),
    );
  }
}
