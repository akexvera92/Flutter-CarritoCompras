/*
* Joan Alexander Vera Beltran
* SENA
* Ficha:2470980
* Fecha:10/10/2022
*
* */
//creamos la clase igual a los datos que esta en el Json
class ProductDataModel{
  int? id;
  int? cantidad;
  String? nombre;
  String? categoria;
  String? imageURL;
  String? precio;
  bool? isAdd;
//metodo constructor
  ProductDataModel(
      {
      this.id,
      this.nombre,
      this.categoria,
      this.imageURL,
      this.precio,
      this.cantidad,
        this.isAdd

      });
//traemos el nombre de los campos del json tienen que ser iguales
  ProductDataModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    nombre =json['nombre'];
    categoria = json['categoria'];
    imageURL = json['imageUrl'];
    precio = json['precio'];
    cantidad=json['cantidad'];
    isAdd=json['isAdd'];
  }
}